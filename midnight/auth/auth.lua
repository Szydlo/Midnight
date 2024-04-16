addEvent("mn_auth:loginAccount", true)
addEvent("mn_auth:registerAccount", true)

function loginAccount(login, pass, plr)
    local query = core.database:query("SELECT * FROM mn_users WHERE login=? LIMIT 1", login)

    if #query <= 0 then return end -- account doesn't exist
    if query[1].inGame == 1 then return end -- someone is already logged
    
    player = client

    if not client then player = plr end

    passwordVerify(pass, query[1].password, {}, function(isValid)
        if not isValid then return end -- wrong password

        core.database:query("UPDATE mn_users SET inGame = '1' WHERE login = ?", login)

        player.identity = query[1].identity

        spawnPlayer(player, 816.01855, -1340.13916, 13.5293)
        setCameraTarget(player)

        if Config.gamemode.devMode then
            local data = {}

            data.login = login
            data.password = pass

            setElementData(player, "auth:devMode", data, false)
        end

        triggerClientEvent(player, "mn_auth:resultLogin", root)
    end)
end
addEventHandler("mn_auth:loginAccount", root, loginAccount)

function registerAccount(login, pass)
    if #login < 3 or #pass < 0 then return end -- login/password too short
    if #login > 32 or #pass > 32 then return end -- login/password too long

    local query = core.database:query("SELECT * FROM mn_users WHERE login=?", login)
    if #query > 0 then return end -- login already taken

    player = client -- wtf
    passwordHash(pass, "bcrypt", {}, function(hash)
        core.database:query("INSERT INTO mn_users (login, password, serial, inGame) VALUES (?, ?, ?, ?)", login, hash, getPlayerSerial(player), 0)
    end)
end
addEventHandler("mn_auth:registerAccount", root, registerAccount)


addEventHandler("onPlayerQuit", root, function()
    if not source.identity then return end

    core.database:query("UPDATE mn_users SET inGame = '0' WHERE identity = ?", source.identity)
end)

function resetInGame()
    core.database:query("UPDATE mn_users SET inGame=0")
end

function devMode()
    if not Config.gamemode.devMode then return end
    
    outputDebugString("[AUTH] DEVMODE IS ON! REMEMBER TO TURN IT OFF IN RELEASE MODE", 2)

    for i, player in pairs(getElementsByType("player")) do
        local data = getElementData(player, "auth:devMode")

        if not data then return end

        loginAccount(data.login, data.password, player)
    end

end

resetInGame()
devMode()