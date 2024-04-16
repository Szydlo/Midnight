function interiorTeleportPlayer(player, x, y, z, interior, dimension)
    local veh = getPedOccupiedVehicle(player)

    if veh then
        setElementPosition(veh, x,y,z)
        setElementInterior(veh, interior)
        setElementDimension(veh, dimension)

        for i, peds in pairs(getVehicleOccupants(veh)) do
            setElementPosition(peds, x,y,z)
            setElementInterior(peds, interior)
            setElementDimension(peds, dimension)
        end
    else
        setElementPosition(player, x,y,z)
        setElementInterior(player, interior)
        setElementDimension(player, dimension)
    end
end