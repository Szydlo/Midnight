Door = {
    constructor = function(self, interiorID, doorID, isLocked, acceptsVehicles, enterData, exitData)
        self.interiorID = interiorID
        self.doorID = doorID
        self.isLocked, self.acceptsVehicles = intToBool(isLocked), acceptsVehicles    

        self.enterData = enterData
        self.exitData = exitData

        self:createEnterPickup()
        self:createExitPickup()
    end,

    createEnterPickup = function(self)
        self.enterPickup = createPickup(self.enterData.x, self.enterData.y, self.enterData.z, 3, self.enterData.pickup, 0)

        setElementInterior(self.enterPickup, self.enterData.interior)
        setElementDimension(self.enterPickup, self.enterData.dimension)

        addEventHandler("onPickupHit", self.enterPickup, function(player)
            local veh = getPedOccupiedVehicle(player)

            if veh and not self.acceptsVehicles then return end
            if veh and  getPedOccupiedVehicleSeat(player) ~= 0 then return end
            if self.isLocked then return outputChatBox("It's locked.") end

            bindKey(player, "e", "down", self.teleportPlayerToInterior, self.exitData.x, self.exitData.y, self.exitData.z, self.exitData.interior, self.interiorID)
        end)

        addEventHandler("onPickupLeave", self.enterPickup, function(player)
            unbindKey(player, "e", "down", self.teleportPlayerToInterior, self.exitData.x, self.exitData.y, self.exitData.z, self.exitData.interior, self.interiorID)
        end)
    end,

    createExitPickup = function(self)
        self.exitPickup = createPickup(self.exitData.x, self.exitData.y, self.exitData.z, 3, self.exitData.pickup, 0)

        setElementInterior(self.exitPickup, self.exitData.interior)
        setElementDimension(self.exitPickup, self.interiorID)

        addEventHandler("onPickupHit", self.exitPickup, function(player)
            local veh = getPedOccupiedVehicle(player)

            if veh and not self.acceptsVehicles then return end
            if veh and  getPedOccupiedVehicleSeat(player) ~= 0 then return end
            if self.isLocked then return outputChatBox("It's locked.") end

            bindKey(player, "e", "down", self.teleportPlayerToInterior, self.enterData.x, self.enterData.y, self.enterData.z, self.enterData.interior, self.enterData.dimension)
        end)

        addEventHandler("onPickupLeave", self.exitPickup, function(player)
            unbindKey(player, "e", "down", self.teleportPlayerToInterior, self.enterData.x, self.enterData.y, self.enterData.z, self.enterData.interior, self.enterData.dimension)
        end)
    end,

    teleportPlayerToInterior = function(player, _, _, x, y, z, interior, dimension)
        interiorTeleportPlayer(player, x, y, z, interior, dimension) -- cuz of binds
    end,

    isLocked = function()
        return self.isLocked 
    end,

    lock = function()
        self.isLocked = not self.isLocked
    end,

    acceptsVehicles = function()
        return acceptsVehicles
    end,
}