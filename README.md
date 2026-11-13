# MSPro Server V18 (repack)

Configuration and data of the MSPro V18 server, without executables, licenses (`Data.xtr`), logs or passwords.

- Put the server executables in each folder.
- Put your `Data.xtr` in the root; MSPro Admin copies it to every program folder.
- The MSPro Admin installer creates the ODBC connection, writes the SQL user and password in the `.ini` files,
  links ServerManager and sets the players' IP (`ServerList.dat`, `MapServerInfo.dat` ship with `127.0.0.1`).
- `Database/MuOnline.sql`: the MuOnline database for SQL Server 2014 or newer: tables, procedures and the
  configuration rows, without accounts, characters, guilds, logs or rankings. The installer runs it.
