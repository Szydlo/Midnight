Interior = {
    constructor = function(self, identity, ownerID, name, description)
        self.identity = identity
        self.ownerID, self.name, self.description = ownerID, name, description
    end,

    loadDoors = function(self, doors)
        self.doors = {}

        for i, data in pairs(doors) do
            table.insert(self.doors, new(Door, 
            self.identity, data.identity, data.isLocked, data.acceptsVehicles, 
            {
                x = data.enterX,
                y = data.enterY,
                z = data.enterZ,
                interior = data.enterInterior,
                dimension = data.enterDimension,
                pickup = data.enterPickup
            }, 
            {
                x = data.exitX,
                y = data.exitY,
                z = data.exitZ,
                interior = data.exitInterior,
                pickup = data.exitPickup
            }))
        end
    end,

    getOwner = function(self)
        return self.ownerID
    end,

    getIdentity = function(self)
        return self.identity
    end,

    getDoors = function(self)
        return self.doors
    end,

    getName = function(self)
        return self.name
    end,

    getDescription = function(self)
        return self.description
    end,

    setOwner = function(self, ownerID)
        self.identity = ownerID
    end,

    setName = function(self, name)
        self.name = name
    end,

    setDescription = function(self, description)
        self.description = description
    end,
}