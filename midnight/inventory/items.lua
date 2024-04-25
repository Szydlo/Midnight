local items = {}

function loadItemTypes()
    local q = core.database:query("SELECT * FROM mn_items_types")

    for i, data in pairs(q) do
        ItemTypes[data.name] = data.identity
    end
end

function loadItems()
    local q = core.database:query("SELECT * FROM mn_items")

    for i, data in pairs(q) do 
        items[data.identity] = data
    end
end

function getItems()
    return items
end

function getItem(id)
    return items[id]
end

loadItemTypes()
loadItems()