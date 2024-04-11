addEvent("mn_auth:loginAccount", true)
addEvent("mn_auth:registerAccount", true)

function loginAccount(login, pass)
    local query = core.database:query("SELECT * FROM mn_users WHERE login=? LIMIT 1", login)

    if #query <= 0 then return end -- account doesn't exist
    if query[1].inGame == 1 then return end -- someone is already logged
    
    player = client
    passwordVerify(pass, query[1].password, {}, function(isValid)
        if not isValid then return end -- wrong password

        core.database:query("UPDATE mn_users SET inGame = '1' WHERE login = ?", login)

        player.identity = query[1].identity


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


function resetInGame()
    core.database:query("UPDATE mn_users SET inGame=0")
end

resetInGame()

addEventHandler("onPlayerQuit", root, function()
    if not source.identity then return end

    core.database:query("UPDATE mn_users SET inGame = '0' WHERE identity = ?", source.identity)
end)