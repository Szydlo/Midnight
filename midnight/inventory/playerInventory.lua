PlayerInventory = inherit(Inventory)

function PlayerInventory:constructor(identity, player)
    self:init(identity)
    self.player = player

    self.showInventory = bind(PlayerInventory.showInventory, self)
    bindKey(self.player, "i", "down", self.showInventory)
end

function PlayerInventory:showInventory(player, _, _)
    triggerClientEvent(self.player, "mn:showPlayerInventory", resourceRoot, self:getItems())
end