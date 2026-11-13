# MSPro Lua Platform — scripts del DataServer

Copiar esta carpeta a `DataServer\Script\`:

```
DataServer\
  DataServer.ini
  Script\
    DataScriptMain.lua
    Platform\Platform.lua
    Modules\Storage.lua
```

## DataServer.ini

```ini
[LuaScript]
Enable=1
Script=.\Script\DataScriptMain.lua
TimeLimit=200        ; ms máximo por llamada (0 = sin límite)
```

Si no existe el script, el DataServer arranca normal y la plataforma queda desactivada (`[LuaData] Disabled` en el log).

## Cómo funciona

- Lua corre en el hilo de la cola de protocolo del DataServer (un solo hilo): no hay concurrencia entre scripts.
- **Conexión SQL propia** (mismas credenciales de `DataServerInfo`): los scripts no comparten sentencias ni buffers con el DataServer. Reconecta sola si se corta.
- **Solo SQL con parámetros** (`?`): no se expone ejecutar SQL armado concatenando texto.
- Cada llamada tiene límite de tiempo; las llamadas de más de 50 ms se loguean. Un script lento frena la cola de **todos** los GameServers: consultas por clave primaria, lotes y nada de loops largos.
- Los errores de un script se loguean y no tiran el DataServer.
- **Recarga**: desde el GameServer con `Net.ReloadData()` (por ejemplo con un comando de GM).

## API

```lua
-- Canales (GameServer: Net.ToData / Net.Request / Net.OnData)
Net.On("mi_modulo", function(msg, ctx)
    local rows = SQL.Query("SELECT Name, Points FROM MiTabla WHERE Name = ?", msg.name)
    Net.Reply(ctx, { rows = rows })          -- responde un Net.Request
end)
Net.Send(serverIndex, "mi_modulo", msg, aIndex)   -- mensaje a un GameServer (Net.OnData)

-- Tablas: se crean/actualizan en cada carga
Platform.Install("mi_modulo", function()
    SQL.Exec([[IF OBJECT_ID('MiTabla') IS NULL CREATE TABLE MiTabla (...)]])
end)

-- SQL
SQL.Query(sql, ...)    -- { { Columna = valor, ... }, ... } | nil, error
SQL.Exec(sql, ...)     -- filas afectadas | nil, error
SQL.Scalar(sql, ...)   -- primer valor | nil
SQL.Binary(string)     -- parámetro VARBINARY
SQL.Transaction(fn)    -- commit si fn termina bien, rollback si falla

-- Serialización (para guardar tablas Lua en VARBINARY)
Pack(value) -> string
Unpack(string) -> value | nil, error

LogPrint(text) / LogError(text)
```

Tipos de parámetro: `nil` (NULL), boolean, entero, número, string, `SQL.Binary(...)`.
Tipos de resultado: enteros, números, strings, binarios como string, NULL como `nil` (el campo no aparece en la fila).

## Módulo Storage

`Modules\Storage.lua` crea `MSPro_LuaStorage` y atiende el canal `storage` que usa `Storage.Load` / `Storage.Save` del GameServer. Sirve para sistemas simples; los sistemas grandes (logros, rankings) deberían tener sus propias tablas y consultas en su propio módulo.
