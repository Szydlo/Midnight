local gui = {}

gui.window = guiCreateWindow(0.40, 0.38, 0.21, 0.24, "Authorization", true)
    guiWindowSetMovable(gui.window, false)
    guiWindowSetSizable(gui.window, false)
gui.label = guiCreateLabel(0.03, 0.12, 0.97, 0.16, "Midnight Core!\nExample framework", true, gui.window)
    guiLabelSetHorizontalAlign(gui.label, "center", false)
    guiLabelSetVerticalAlign(gui.label, "center")
gui.loginBox = guiCreateEdit(0.16, 0.31, 0.71, 0.15, "Szydlo", true, gui.window)
gui.passwordBox = guiCreateEdit(0.16, 0.50, 0.71, 0.15, "elo123", true, gui.window)
    guiEditSetMasked(gui.passwordBox, true)
gui.loginButton = guiCreateButton(0.16, 0.70, 0.31, 0.14, "Login", true, gui.window)
gui.registerButton = guiCreateButton(0.56, 0.70, 0.31, 0.14, "Register", true, gui.window)
gui.checkbox = guiCreateCheckBox(0.38, 0.88, 0.34, 0.08, "Remember me", false, true, gui.window) 

showCursor(true)
showChat(false)

setPlayerHudComponentVisible("all", false)

fadeCamera(true, 2)
setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)

addEventHandler("onClientGUIClick", root, function(button, state)
    local login = guiGetText(gui.loginBox)
    local pass = guiGetText(gui.passwordBox)

    if source == gui.loginButton then
        triggerServerEvent("mn_auth:loginAccount", localPlayer, login, pass)
    elseif source == gui.registerButton then
        triggerServerEvent("mn_auth:registerAccount", localPlayer, login, pass)
    elseif source == gui.checkbox then

    end
end)

addEvent("mn_auth:resultLogin", true)
addEventHandler("mn_auth:resultLogin", root, function()
    showCursor(false)
    showChat(true)
    guiSetVisible(gui.window, false)
end)