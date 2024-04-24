Vehicle = {
    constructor = function(self, vehicleData)
        self.data = vehicleData        

        self:spawn()
    end,

    deconstructor = function(self)
        self:save()
        destroyElement(self.vehicle)

        self = nil
    end,

    spawn = function(self)
        self.vehicle = createVehicle(self.data.modelID, self.data.posX, self.data.posY, self.data.posZ, self.data.rotX, self.data.rotY, self.data.rotZ, "LS "..self.data.identity)
        enew(self.vehicle, self)

        setElementInterior(self.vehicle, self.data.interior)
        setElementDimension(self.vehicle, self.data.dimension)
        setElementHealth(self.vehicle, self.data.health)

        local color1 = split(self.data.color1, ',')
        local color2 = split(self.data.color2, ',')
        local color3 = split(self.data.color3, ',')
        local color4 = split(self.data.color4, ',')

        setVehicleColor(self.vehicle, 
            color1[1], color1[2], color1[3],
            color2[1], color2[2], color2[3],
            color3[1], color3[2], color3[3],
            color4[1], color4[2], color4[3]
        )

        local panelsDamage = split(self.data.panelsDamage, ',')
        local doorsDamage = split(self.data.doorsDamage, ',')
        local lightsDamage = split(self.data.lightsDamage, ',')

        for i=0,6 do
            setVehiclePanelState(self.vehicle, i, panelsDamage[i+1])
            if i <= 5 then setVehicleDoorState(self.vehicle, i, doorsDamage[i+1]) end
            if i <= 3 then setVehicleLightState(self.vehicle, i, lightsDamage[i+1]) end
        end
    
        local wheelsDamage = split(self.data.wheelsDamage, ',')
        setVehicleWheelStates(self.vehicle, wheelsDamage[1], wheelsDamage[2], wheelsDamage[3], wheelsDamage[4])
    
        local handling = fromJSON(self.data.handling)
        for name, value in pairs(handling) do
            setVehicleHandling(self.vehicle, name, value)
        end
    
        local visualTune = split(self.data.visualTune, ',')
        for i, tune in pairs(visualTune) do
            addVehicleUpgrade(self.vehicle, tune)
        end
    
        local lightsColor = split(self.data.lightsColor, ',')
        setVehicleHeadLightColor(self.vehicle, lightsColor[1], lightsColor[2], lightsColor[3])
    end,

    save = function(self)
        local health = getElementHealth(self.vehicle)
    
        local color1, color2, color3, color4 = {}, {}, {}, {}
    
        color1[1], color1[2], color1[3],
        color2[1], color2[2], color2[3],
        color3[1], color3[2], color3[3],
        color4[1], color4[2], color4[3] = getVehicleColor(self.vehicle, true)
    
        local lightsColor = table.concat({getVehicleHeadLightColor(self.vehicle)}, ',')
    
        local doorsDamage = {}
        local panelsDamage = {}
        local lightsDamage = {}
        local wheelsDamage = {getVehicleWheelStates(self.vehicle)}
    
        for i=0,6 do
            table.insert(panelsDamage, getVehiclePanelState(self.vehicle, i))
            if i <= 5 then table.insert(doorsDamage, getVehicleDoorState(self.vehicle, i)) end
            if i <= 3 then table.insert(lightsDamage, getVehicleLightState(self.vehicle, i)) end
        end
    
        local tune = table.concat(getVehicleUpgrades(self.vehicle), ',')
        local handling = toJSON(getVehicleHandling(self.vehicle))

        core.database:query("UPDATE mn_vehicles SET handling=?,health=?,mileage=?,color1=?,color2=?,color3=?,color4=?,panelsDamage=?,doorsDamage=?,wheelsDamage=?,lightsDamage=?,visualTune=?,lightsColor=? WHERE identity=?",
            handling, health, self.data.mileage, table.concat(color1, ','), table.concat(color2, ','), table.concat(color3, ','), table.concat(color4, ','), 
            table.concat(panelsDamage, ','), table.concat(doorsDamage, ','), table.concat(wheelsDamage, ','), 
            table.concat(lightsDamage, ','), tune, lightsColor, self.data.identity
        )
    end,

    getVehicle = function(self)
        return self.vehicle
    end,
}