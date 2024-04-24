local InventoryTypes = {Player, Vehicle}

Inventory = {
    constructor = function(self, identity, type, items)
        self.identity = identity
        self.type = type

        self:loadItems(items)
    end,

    loadItems = function(self, itemsData)
        self.items = {}
    end,

    addItem = function(self, item, amount)
    end,

    removeItem = function(self, item)
    end,

    useItem = function(self, item)
    end,
}