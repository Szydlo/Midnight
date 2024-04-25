Inventory = {
    init = function(self, identity)
        self.identity = identity

        self:loadItems()
    end,

    loadItems = function(self, itemsData)
        local qItems = core.database:query("SELECT * FROM mn_inventory_items WHERE inventoryID=?", self.identity)
        self.items = {}

        for i, data in pairs(qItems) do
            local itemData = getItem(data.itemID)

            -- @ TODO CHANGE IT, IS IT REALLY NECESSARY TO DO IT THIS WAY?
            if itemData.type == ItemTypes.Food then
                self.items[data.identity] = {item = new(FoodItem, itemData), amount = data.stack}
            elseif itemData.type == ItemTypes.Weapon then
                self.items[data.identity] = {item = new(WeaponItem, itemData), amount = data.stack}
            elseif itemData.type == ItemTypes.Ammo then
                self.items[data.identity] = {item = new(AmmoItem, itemData), amount = data.stack}
            end
        end
    end,

    addItem = function(self, item, amount)
    end,

    removeItem = function(self, item)
    end,

    getItems = function(self)
        return self.items
    end,

    getItemByID = function(self, itemID)
        return self.items[itemID]
    end,

    useItem = function(self, itemID)
        --self.items[itemID].item:use()
    end,
}