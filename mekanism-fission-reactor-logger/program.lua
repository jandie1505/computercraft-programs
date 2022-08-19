local reactorString = ""
--local boilerString = ""
--local turbineString = ""
local printerString = ""

-- code

local reactor = peripheral.wrap(reactorString)
--local boiler = peripheral.wrap(boilerString)
--local turbine = peripheral.wrap(turbineString)
local printer = peripheral.wrap(printerString)

local oldValues = {}
local currentValues = {}

oldValues.reactorEnabled = false

oldValues.reactorTemperature = -1
  
oldValues.reactorCoolantAmount = -1
oldValues.reactorCoolantCapacity = -1
oldValues.reactorCoolantFilledPercentage = -1
oldValues.reactorCoolantNeeded = -1

oldValues.reactorHeatedCoolantAmount = -1
oldValues.reactorHeatedCoolantCapacity = -1
oldValues.reactorHeatedCoolantFilledPercentage = -1
oldValues.reactorHeatedCoolantNeeded = -1

oldValues.reactorDamage = -1

oldValues.reactorFuelAmount = -1
oldValues.reactorFuelCapacity = -1
oldValues.reactorFuelFilledPercentage = -1

oldValues.reactorCurrentBurnRate = -1
oldValues.reactorBurnRate = -1
oldValues.reactorMaxBurnRate = -1

oldValues.reactorWasteAmount = -1
oldValues.reactorWasteCapacity = -1
oldValues.reactorWasteFilledPercentage = -1
  
oldValues.boilerTemperature = -1
  
oldValues.boilerWaterAmount = -1
oldValues.boilerWaterCapacity = -1
oldValues.boilerWaterFilledPercentage = -1
  
oldValues.boilerSteamAmount = -1
oldValues.boilerSteamCapacity = -1
oldValues.boilerSteamFilledPercentage = -1
  
oldValues.boilerCooledCoolantAmount = -1
oldValues.boilerCooledCoolantCapacity = -1
oldValues.boilerCooledCoolantFilledPercentage = -1
  
oldValues.boilerHeatedCoolantAmount = -1
oldValues.boilerHeatedCoolantCapacity = -1
oldValues.boilerHeatedCoolantFilledPercentage = -1
  
oldValues.boilerBoilRate = -1
oldValues.boilerMaxBoilRate = -1
oldValues.boilerBoilCapacity = -1
  
oldValues.turbineSteamAmount = -1
oldValues.turbineSteamCapacity = -1
oldValues.turbineSteamFilledPercentage = -1
oldValues.turbineSteamInputRate = -1
oldValues.turbineFlowRate = -1
oldValues.turbineMaxFlowRate = -1
oldValues.turbineDumpingMode = "UNKNOWN"
  
oldValues.turbineEnergyAmount = -1
oldValues.turbineMaxEnergy = -1
oldValues.turbineEnergyFilledPercentage = -1
oldValues.turbineProductionRate = -1
oldValues.turbineMaxProduction = -1

currentValues.reactorEnabled = false

currentValues.reactorTemperature = -1
  
currentValues.reactorCoolantAmount = -1
currentValues.reactorCoolantCapacity = -1
currentValues.reactorCoolantFilledPercentage = -1
currentValues.reactorCoolantNeeded = -1

currentValues.reactorHeatedCoolantAmount = -1
currentValues.reactorHeatedCoolantCapacity = -1
currentValues.reactorHeatedCoolantFilledPercentage = -1
currentValues.reactorHeatedCoolantNeeded = -1

currentValues.reactorDamage = -1

currentValues.reactorFuelAmount = -1
currentValues.reactorFuelCapacity = -1
currentValues.reactorFuelFilledPercentage = -1

currentValues.reactorCurrentBurnRate = -1
currentValues.reactorBurnRate = -1
currentValues.reactorMaxBurnRate = -1

currentValues.reactorWasteAmount = -1
currentValues.reactorWasteCapacity = -1
currentValues.reactorWasteFilledPercentage = -1
  
currentValues.boilerTemperature = -1
  
currentValues.boilerWaterAmount = -1
currentValues.boilerWaterCapacity = -1
currentValues.boilerWaterFilledPercentage = -1
  
currentValues.boilerSteamAmount = -1
currentValues.boilerSteamCapacity = -1
currentValues.boilerSteamFilledPercentage = -1
  
currentValues.boilerCooledCoolantAmount = -1
currentValues.boilerCooledCoolantCapacity = -1
currentValues.boilerCooledCoolantFilledPercentage = -1
  
currentValues.boilerHeatedCoolantAmount = -1
currentValues.boilerHeatedCoolantCapacity = -1
currentValues.boilerHeatedCoolantFilledPercentage = -1
  
currentValues.boilerBoilRate = -1
currentValues.boilerMaxBoilRate = -1
currentValues.boilerBoilCapacity = -1
  
currentValues.turbineSteamAmount = -1
currentValues.turbineSteamCapacity = -1
currentValues.turbineSteamFilledPercentage = -1
currentValues.turbineSteamInputRate = -1
currentValues.turbineFlowRate = -1
currentValues.turbineMaxFlowRate = -1
currentValues.turbineDumpingMode = "UNKNOWN"
  
currentValues.turbineEnergyAmount = -1
currentValues.turbineMaxEnergy = -1
currentValues.turbineEnergyFilledPercentage = -1
currentValues.turbineProductionRate = -1
currentValues.turbineMaxProduction = -1

print("Running Mekanism Fission Reactor Logger")

while true do
    currentValues.reactorEnabled = reactor.getStatus()

    currentValues.reactorTemperature = math.ceil(reactor.getTemperature())
  
    currentValues.reactorCoolantAmount = math.ceil(reactor.getCoolant()["amount"])
    currentValues.reactorCoolantCapacity = math.ceil(reactor.getCoolantCapacity())
    currentValues.reactorCoolantFilledPercentage = math.ceil(reactor.getCoolantFilledPercentage())
    currentValues.reactorCoolantNeeded = math.ceil(reactor.getCoolantNeeded())

    currentValues.reactorHeatedCoolantAmount = math.ceil(reactor.getHeatedCoolant()["amount"])
    currentValues.reactorHeatedCoolantCapacity = math.ceil(reactor.getHeatedCoolantCapacity())
    currentValues.reactorHeatedCoolantFilledPercentage = math.ceil(reactor.getHeatedCoolantFilledPercentage())
    currentValues.reactorHeatedCoolantNeeded = math.ceil(reactor.getHeatedCoolantNeeded())

    currentValues.reactorDamage = math.ceil(reactor.getDamagePercent())

    currentValues.reactorFuelAmount = math.ceil(reactor.getFuel()["amount"])
    currentValues.reactorFuelCapacity = math.ceil(reactor.getFuelCapacity())
    currentValues.reactorFuelFilledPercentage = math.ceil(reactor.getFuelFilledPercentage())

    currentValues.reactorCurrentBurnRate = math.ceil(reactor.getActualBurnRate())
    currentValues.reactorBurnRate = math.ceil(reactor.getBurnRate())
    currentValues.reactorMaxBurnRate = math.ceil(reactor.getMaxBurnRate())

    currentValues.reactorWasteAmount = math.ceil(reactor.getWaste()["amount"])
    currentValues.reactorWasteCapacity = math.ceil(reactor.getWasteCapacity())
    currentValues.reactorWasteFilledPercentage = math.ceil(reactor.getWasteFilledPercentage())
  
    --currentValues.boilerTemperature = math.ceil(boiler.getTemperature())
  
    --currentValues.boilerWaterAmount = math.ceil(boiler.getWater()["amount"])
    --currentValues.boilerWaterCapacity = math.ceil(boiler.getWaterCapacity())
    --currentValues.boilerWaterFilledPercentage = math.ceil(boiler.getWaterFilledPercentage())
  
    --currentValues.boilerSteamAmount = math.ceil(boiler.getSteam()["amount"])
    --currentValues.boilerSteamCapacity = math.ceil(boiler.getSteamCapacity())
    --currentValues.boilerSteamFilledPercentage = math.ceil(boiler.getSteamFilledPercentage())
  
    --currentValues.boilerCooledCoolantAmount = math.ceil(boiler.getCooledCoolant()["amount"])
    --currentValues.boilerCooledCoolantCapacity = math.ceil(boiler.getCooledCoolantCapacity())
    --currentValues.boilerCooledCoolantFilledPercentage = math.ceil(boiler.getCooledCoolantFilledPercentage())
  
    --currentValues.boilerHeatedCoolantAmount = math.ceil(boiler.getHeatedCoolant()["amount"])
    --currentValues.boilerHeatedCoolantCapacity = math.ceil(boiler.getHeatedCoolantCapacity())
    --currentValues.boilerHeatedCoolantFilledPercentage = math.ceil(boiler.getHeatedCoolantFilledPercentage())
  
    --currentValues.boilerBoilRate = math.ceil(boiler.getBoilRate())
    --currentValues.boilerMaxBoilRate = math.ceil(boiler.getMaxBoilRate())
    --currentValues.boilerBoilCapacity = math.ceil(boiler.getBoilCapacity())
  
    --currentValues.turbineSteamAmount = math.ceil(turbine.getSteam()["amount"])
    --currentValues.turbineSteamCapacity = math.ceil(turbine.getSteamCapacity())
    --currentValues.turbineSteamFilledPercentage = math.ceil(turbine.getSteamFilledPercentage())
    --currentValues.turbineSteamInputRate = math.ceil(turbine.getLastSteamInputRate())
    --currentValues.turbineFlowRate = math.ceil(turbine.getFlowRate())
    --currentValues.turbineMaxFlowRate = math.ceil(turbine.getMaxFlowRate())
    --currentValues.turbineDumpingMode = math.ceil(turbine.getDumpingMode())
  
    --currentValues.turbineEnergyAmount = math.ceil(turbine.getEnergy() / 2.5)
    --currentValues.turbineMaxEnergy = math.ceil(turbine.getMaxEnergy() / 2.5)
    --currentValues.turbineEnergyFilledPercentage = math.ceil(turbine.getEnergyFilledPercentage())
    --currentValues.turbineProductionRate = math.ceil(turbine.getProductionRate() / 2.5)
    --currentValues.turbineMaxProduction = math.ceil(turbine.getMaxProduction() / 2.5)

    if currentValues ~= oldValues then
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
        printer.write("Fuel: " .. currentValues.reactorFuelAmount)

        printer.setCursorPos(1,12)
        printer.write("Max Fuel: " .. currentValues.reactorFuelCapacity)

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

    oldValues = currentValues
    sleep(1)
end