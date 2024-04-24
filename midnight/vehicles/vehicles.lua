function spawnAllVehicles()
    local query = core.database:query("SELECT * FROM mn_vehicles")

    for i, data in pairs(query) do
        new(Vehicle, data)
    end

    outputDebugString("[VEHICLES] LOADED "..#query.." VEHICLES")
end

spawnAllVehicles()