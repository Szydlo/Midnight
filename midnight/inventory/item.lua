Item = {
    constructor = function(self, identity, type, name, description, flags, weight, maxStack)
        self.identity = identity
        self.type = type

        self.name, self.description, self.flags, self.weight, self.maxStack = name, description, fromJSON(flags), weight, maxStack
    end,

    use = function(self) end
}

FoodItem = inherit(Item)
Weaponitem = inherit(Item)
Ammo = inherit(Item)