local reactorString = ""
local printerString = ""

-- code

local reactor = peripheral.wrap(reactorString)
local printer = peripheral.wrap(printerString)

local oldValues = {}
local currentValues = {}

oldValues.reactorEnabled = false

oldValues.reactorTemperature = -1
  
oldValues.reactorCoolantAmount = -1
oldValues.reactorCoolantCapacity = -1

oldValues.reactorHeatedCoolantAmount = -1
oldValues.reactorHeatedCoolantCapacity = -1

oldValues.reactorDamage = -1

oldValues.reactorCurrentBurnRate = -1
oldValues.reactorBurnRate = -1
oldValues.reactorMaxBurnRate = -1

oldValues.reactorWasteAmount = -1
oldValues.reactorWasteCapacity = -1

currentValues.reactorEnabled = false

currentValues.reactorTemperature = -1
  
currentValues.reactorCoolantAmount = -1
currentValues.reactorCoolantCapacity = -1

currentValues.reactorHeatedCoolantAmount = -1
currentValues.reactorHeatedCoolantCapacity = -1

currentValues.reactorDamage = -1

currentValues.reactorCurrentBurnRate = -1
currentValues.reactorBurnRate = -1
currentValues.reactorMaxBurnRate = -1

currentValues.reactorWasteAmount = -1
currentValues.reactorWasteCapacity = -1

local reactorFuelAmount = -1
local reactorFuelCapacity = -1

function deepcompare(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not deepcompare(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not deepcompare(v1,v2) then return false end
    end
    return true
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

print("Running Mekanism Fission Reactor Logger")

while true do
    currentValues.reactorEnabled = reactor.getStatus()

    currentValues.reactorTemperature = math.ceil(reactor.getTemperature())
  
    currentValues.reactorCoolantAmount = math.ceil(reactor.getCoolant()["amount"])
    currentValues.reactorCoolantCapacity = math.ceil(reactor.getCoolantCapacity())

    currentValues.reactorHeatedCoolantAmount = math.ceil(reactor.getHeatedCoolant()["amount"])
    currentValues.reactorHeatedCoolantCapacity = math.ceil(reactor.getHeatedCoolantCapacity())

    currentValues.reactorDamage = math.ceil(reactor.getDamagePercent())

    reactorFuelAmount = math.ceil(reactor.getFuel()["amount"])
    reactorFuelCapacity = math.ceil(reactor.getFuelCapacity())

    currentValues.reactorCurrentBurnRate = math.ceil(reactor.getActualBurnRate())
    currentValues.reactorBurnRate = math.ceil(reactor.getBurnRate())
    currentValues.reactorMaxBurnRate = math.ceil(reactor.getMaxBurnRate())

    currentValues.reactorWasteAmount = math.ceil(reactor.getWaste()["amount"])
    currentValues.reactorWasteCapacity = math.ceil(reactor.getWasteCapacity())

    if not deepcompare(currentValues, oldValues, false) then
        printer.newPage()
        printer.setPageTitle("REACTOR " .. os.date())

        printer.setCursorPos(1,1)
        printer.write("REACTOR DATA:")

        printer.setCursorPos(1,2)
        printer.write(os.date())

        printer.setCursorPos(1,4)
        printer.write("Status: " .. tostring(currentValues.reactorEnabled))

        printer.setCursorPos(1,5)
        printer.write("Temp: " .. currentValues.reactorTemperature)

        printer.setCursorPos(1,6)
        printer.write("Coolant: " .. currentValues.reactorCoolantAmount)

        printer.setCursorPos(1,7)
        printer.write("Max Coolant: " .. currentValues.reactorCoolantCapacity)

        printer.setCursorPos(1,8)
        printer.write("H.Coolant: " .. currentValues.reactorHeatedCoolantAmount)

        printer.setCursorPos(1,9)
        printer.write("Max H.Cool.: " .. currentValues.reactorHeatedCoolantCapacity)

        printer.setCursorPos(1,10)
        printer.write("Damage: " .. currentValues.reactorDamage)

        printer.setCursorPos(1,11)
        printer.write("Fuel: " .. reactorFuelAmount)

        printer.setCursorPos(1,12)
        printer.write("Max Fuel: " .. reactorFuelCapacity)

        printer.setCursorPos(1,13)
        printer.write("Burn rate: " .. currentValues.reactorCurrentBurnRate)

        printer.setCursorPos(1,14)
        printer.write("Set Burn rate: " .. currentValues.reactorBurnRate)

        printer.setCursorPos(1,15)
        printer.write("Max burn rate: " .. currentValues.reactorMaxBurnRate)

        printer.setCursorPos(1,16)
        printer.write("Waste: " .. currentValues.reactorWasteAmount)

        printer.setCursorPos(1,17)
        printer.write("Max Waste: " .. currentValues.reactorWasteCapacity)

        printer.setCursorPos(1,19)
        printer.write("--- END ---")

        printer.endPage()

        print("Printed new reactor values")
    end

    oldValues = deepcopy(currentValues)
    sleep(1)
end