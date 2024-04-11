Database = {
    constructor = function(self, host, user, password, database)
        self.connection = dbConnect("mysql", 'dbname='..database..';host='..host..';charset=utf8', user, password, "share=1")
    
        assert(self.connection, "[DATABASE] CAN'T CONNECT WITH DATABASE HOST: "..host)

        if self.connection then
            outputDebugString("[DATABASE] connected with database! Host: "..host)
        end
    end,

    query = function(self, ...)
        local prepareString = dbPrepareString(self.connection, ...)
        local query = dbQuery(self.connection, prepareString)
        local result, affected_rows, insert_id = dbPoll(query, -1)
        dbFree(query)
                
        return result, affected_rows, insert_id
    end,

    exec = function(self, ...)
        local prepareString = dbPrepareString(self.connection, ...)

        local execHandle = dbExec(self.connection, prepareString)
        local result, numRows = dbPoll(execHandle, -1)
        return result, numRows
    end
}