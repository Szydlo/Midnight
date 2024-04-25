local gui = {}

gui.window = guiCreateWindow(0.79, 0.34, 0.18, 0.33, "Inventory", true)
    guiWindowSetSizable(gui.window, false)
gui.gridlist = guiCreateGridList(0.06, 0.07, 0.90, 0.76, true, gui.window)
    guiGridListAddColumn(gui.gridlist, "ID", 0.3)
    guiGridListAddColumn(gui.gridlist, "Name", 0.3)
    guiGridListAddColumn(gui.gridlist, "Amount", 0.3)
gui.remove = guiCreateButton(0.35, 0.85, 0.31, 0.12, "Remove", true, gui.window)
gui.use = guiCreateButton(0.03, 0.85, 0.31, 0.12, "Use", true, gui.window)
gui.exit = guiCreateButton(0.66, 0.85, 0.31, 0.12, "Exit", true, gui.window)

guiSetVisible(gui.window, false)

addEvent("mn:showPlayerInventory", true)
addEventHandler("mn:showPlayerInventory", root, function(items)
    guiSetVisible(gui.window, not guiGetVisible(gui.window))
    showCursor(guiGetVisible(gui.window))

    guiGridListClear(gui.gridlist)

    for i, data in pairs(items) do
        guiGridListAddRow(gui.gridlist, i, data.item.name, data.amount)
    end
end)

addEventHandler("onClientGUIClick", root, function()
    if source == gui.exit then
        guiSetVisible(gui.window, false)
        showCursor(false)
    elseif source == gui.remove then
        
    elseif source == gui.use then
        
    end
end)