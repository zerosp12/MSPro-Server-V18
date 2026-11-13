---------------------------------------------------------------------------
-- WelcomeLua - Comando de Bienvenida
---------------------------------------------------------------------------

BridgeFunctionAttach("OnCommandManager", "WelcomeLua_OnCommandManager")

function WelcomeLua_OnCommandManager(aIndex, arg)
    if arg == "/hola" then
        NoticeColorSend(aIndex, 1, 6, 9, 10, "Hola Mensaje de Color")
        NoticeColorSend(aIndex, 0, 6, 11, 11, "Hola Mensaje de Color 2")
        return 1
    end
    if arg == "/boss" then
        local index = MonsterCreate(22, 0, 144, 127, -1)

        if index < 0 then
            NoticeColorSend(aIndex, 1, 6, 9, 10, "Error al crear el monster")
            return 1
        else
            NoticeColorSend(aIndex, 1, 6, 9, 10, "Monster Creado")
        end

        local getHP = GetObjectLife(index)
        local getMaxHP = GetObjectMaxLife(index)

        NoticeColorSend(aIndex, 1, 6, 9, 10, 
            string.format("HP del Monster %d / %d", getHP, getMaxHP)
        )

        return 1
    end
    return 0
end