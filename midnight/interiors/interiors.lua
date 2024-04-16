local interiors = {}

function loadInteriors()
    interiors = {}

    local query = core.database:query("SELECT * FROM mn_interiors")

    for i, interior in pairs(query) do
        interiors[interior.identity] = new(Interior, interior.identity, interior.ownerID, interior.name, interior.description)
    
        local doors = core.database:query("SELECT * FROM mn_interiors_doors WHERE interiorID=?", interior.identity)
        interiors[interior.identity]:loadDoors(doors)
    end

    outputDebugString("[INTERIORS] LOADED "..#query.." INTERIORS")
end

loadInteriors()