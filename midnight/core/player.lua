Player = {
    constructor = function(self)
    end,

    loadData = function(self)
        self:loadInventory()
    end,

    loadInventory = function(self)
        local q = core.database:query("SELECT * FROM mn_inventory WHERE type=? AND ownerID=?", InventoryTypes.PlayerInventory, self.identity)
        self.inventory = new(PlayerInventory, q[1].identity, self)
    end,
}

registerElementClass("player", Player)