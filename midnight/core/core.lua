Core = {
    constructor = function(self)
        self.database = new(Database, Config.database.host, Config.database.login, Config.database.password, Config.database.database)
        setFPSLimit(60)
    end
}

core = new(Core)