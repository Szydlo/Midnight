Core = {
    constructor = function(self)
        self.database = new(Database, "localhost", "root", "", "midnight")
        setFPSLimit(60)
    end
}

core = new(Core)