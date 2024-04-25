Item = {
    init = function(self, itemData)
        self.identity = itemData.identity
        self.type = itemData.type

        self.name, self.description, self.flags, self.weight, self.maxStack = itemData.name, itemData.description, fromJSON(itemData.flags), itemData.weight, itemData.maxStack
    end,

    use = function(self) 
        outputConsole("use item")
    end,
}

-- @ TODO CHANGE IT, IS IT REALLY NECESSARY TO DO IT THIS WAY?
FoodItem = inherit(Item)
WeaponItem = inherit(Item)
AmmoItem = inherit(Item)

function FoodItem:constructor(itemData)
    self:init(itemData)
end

function FoodItem:use(player)
    if not self.flags.health then return end

    setElementHealth(player, player.health + self.flags.health)
end

function WeaponItem:constructor(itemData)
    self:init(itemData)
end

function AmmoItem:constructor(itemData)
    self:init(itemData)
end
