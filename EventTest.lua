local Event = {
    ConnectedFunctions = {},
}
Event.Connect = function(self, f)
    table.insert(self.ConnectedFunctions, f)
end
Event.Fire = function(self, Parameters)
    for _, f in pairs(self.ConnectedFunctions) do
        f(table.unpack(Parameters))
    end
end
Event.__index = Event

local TestObject = {
    Name = "Bob",
    Changed = setmetatable({}, Event),

    Set = function(self, Prop, Value)
        self[Prop] = Value
        self.Changed:Fire({Prop, Value})
    end
}

TestObject.Changed:Connect(function(Prop, Value)
    print("Changed " .. Prop .. " to " .. Value)
end)

TestObject:Set("Name", "Steve")
