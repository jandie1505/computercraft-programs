local reactorString = ""
local laserAmplifierString = ""
local turbineString = ""
local monitor1string = ""
local monitor2string = ""
local monitor3string = ""
local fuelValveSideString = ""

-- values

local reactorPlasmaTemperature = -1
local reactorMaxPlasmaTemperature = -1
local reactorCaseTemperature = -1
local reactorMaxCaseTemperature = -1
local reactorIgnitionTemperature = -1

local reactorDeuteriumAmount = -1
local reactorDeuteriumCapacity = -1
local reactorDeuteriumFilledPercentage = -1
local reactorTritiumAmount = -1
local reactorTritiumCapacity = -1
local reactorTritiumFilledPercentage = -1
local reactorDTFuelAmount = -1
local reactorDTFuelCapacity = -1
local reactorDTFuelFilledPercentage = -1

local reactorWaterAmount = -1
local reactorWaterCapacity = -1
local reactorWaterFilledPercentage = -1
local reactorSteamAmount = -1
local reactorSteamCapacity = -1
local reactorSteamFilledPercentage = -1

local reactorInjectionRate = -1
local reactorMinInjectionRate = -1

-- code

local monitor1 = peripheral.wrap(monitor1string)
local montior2 = peripheral.wrap(monitor2string)
local monitor3 = peripheral.wrap(monitor3string)

function values()
    local reactor = peripheral.wrap(reactorString)

    reactorPlasmaTemperature = reactor.getPlasmaTemperature()
    reactorMaxPlasmaTemperature = reactor.getMaxPlasmaTemperature()
    reactorCaseTemperature = reactor.getCaseTemperature()
    reactorMaxCaseTemperature = reactor.getMaxCaseTemperature()
    reactorIgnitionTemperature = reactor.getIgnitionTemperature()

    reactorDeuteriumAmount = reactor.getDeuterium()["amount"]
    reactorDeuteriumCapacity = reactor.getDeuteriumCapacity()
    reactorDeuteriumFilledPercentage = reactor.getDeuteriumFilledPercentage()
    reactorTritiumAmount = reactor.getTritium()["amount"]
    reactorTritiumCapacity = reactor.getTritiumCapacity()
    reactorTritiumFilledPercentage = reactor.getTritiumFilledPercentage()
    reactorDTFuelAmount = reactor.getDTFuel()["amount"]
    reactorDTFuelCapacity = reactor.getDTFuelCapacity()
    reactorDTFuelFilledPercentage = reactor.getDTFuelFilledPercentage()

    reactorWaterAmount = reactor.getWater()["amount"]
    reactorWaterCapacity = reactor.getWaterCapacity()
    reactorWaterFilledPercentage = reactor.getWaterFilledPercentage()
    reactorSteamAmount = reactor.getSteam()["amount"]
    reactorSteamCapacity = reactor.getSteamCapacity()
    reactorSteamFilledPercentage = reactor.getSteamFilledPercentage()

    reactorInjectionRate = reactor.getInjectionRate()
    reactorMinInjectionRate = reactor.getMinInjectionRate(true)
end