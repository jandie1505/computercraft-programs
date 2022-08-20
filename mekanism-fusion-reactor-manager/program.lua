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

local reactorProductionRate = -1
local reactorPassiveGeneration = -1

local reactorInjectionRate = -1
local reactorMinInjectionRate = -1

local reactorEnabled = false
local reactorRequiredBurnRate = 2

local monitor1 = peripheral.wrap(monitor1string)
local monitor2 = peripheral.wrap(monitor2string)
local monitor3 = peripheral.wrap(monitor3string)

local stillAliveString = "."
local stillAliveTimer = 20

local updateBurnRate = {"0","0","0","0","0","0","0"}
local updateBurnRateCurrentField = 1
local updateBurnRateValueString = ""
local updateBurnValueCalc = ""
local updateBurnValue = 0

-- local

function stillAliveDisplay()
    if stillAliveTimer <= 0 then
        if stillAliveString == "." then
        stillAliveString = ".."
    elseif stillAliveString == ".." then
        stillAliveString = "..."
    else
        stillAliveString = "."
    end
      stillAliveTimer = 20
    else
      stillAliveTimer = stillAliveTimer - 1
    end
end

function updateMonitor1()
    monitor1.setCursorPos(1,1)
    monitor1.setBackgroundColor(colors.white)
    monitor1.setTextColor(colors.black)
    monitor1.clearLine()
    monitor1.write("REACTOR")
    monitor1.setCursorPos(24,1)
    monitor1.write(stillAliveString)
    monitor1.setBackgroundColor(colors.black)
    monitor1.setTextColor(colors.white)

    monitor1.setCursorPos(1,3)
    monitor1.clearLine()
    monitor1.write("TEMPERATURE:")
    monitor1.setCursorPos(1,4)
    monitor1.clearLine()
    monitor1.write("Plasma: " .. math.ceil(reactorPlasmaTemperature) .. "K")
    monitor1.setCursorPos(1,5)
    monitor1.clearLine()
    monitor1.write("Case: " .. math.ceil(reactorCaseTemperature) .. "K")

    monitor1.setCursorPos(1,7)
    monitor1.clearLine()
    monitor1.write("FUEL:")
    monitor1.setCursorPos(1,8)
    monitor1.clearLine()
    monitor1.write("Deuterium: " .. math.ceil(reactorDeuteriumAmount) .. "mB / " .. math.ceil(reactorDeuteriumCapacity) .. "mB (" .. math.ceil(reactorDeuteriumFilledPercentage * 100) .. "%)")
    monitor1.setCursorPos(1,9)
    monitor1.clearLine()
    monitor1.write("Tritium: " .. math.ceil(reactorTritiumAmount) .. "mB / " .. math.ceil(reactorTritiumCapacity) .. "mB (" .. math.ceil(reactorTritiumFilledPercentage * 100) .. "%)")
    monitor1.setCursorPos(1,10)
    monitor1.clearLine()
    monitor1.write("DT-Fuel: " .. math.ceil(reactorDTFuelAmount) .. "mB / " .. math.ceil(reactorDTFuelCapacity) .. "mB (" .. math.ceil(reactorDTFuelFilledPercentage * 100) .. "%)")

    monitor1.setCursorPos(1,12)
    monitor1.clearLine()
    monitor1.write("WATER/STEAM:")
    monitor1.setCursorPos(1,13)
    monitor1.clearLine()
    monitor1.write("Water: " .. math.ceil(reactorWaterAmount) .. "mB / " .. math.ceil(reactorWaterCapacity) .. "mB (" .. math.ceil(reactorWaterFilledPercentage * 100) .. "%)")
    monitor1.setCursorPos(1,14)
    monitor1.clearLine()
    monitor1.write("Steam: " .. math.ceil(reactorSteamAmount) .. "mB / " .. math.ceil(reactorSteamCapacity) .. "mB (" .. math.ceil(reactorSteamFilledPercentage * 100) .. "%)")

    monitor1.setCursorPos(1,16)
    monitor1.clearLine()
    monitor1.write("MAX PRODUCTION:")
    monitor1.setCursorPos(1,17)
    monitor1.clearLine()
    monitor1.write("Active: " .. math.ceil(reactorProductionRate) .. "mB/t")
    monitor1.setCursorPos(1,18)
    monitor1.clearLine()
    monitor1.write("Passive: " .. math.ceil(reactorPassiveGeneration) .. "RF/t")
end

function updateMonitor2()
    monitor2.setCursorPos(1,1)
    monitor2.setBackgroundColor(colors.white)
    monitor2.setTextColor(colors.black)
    monitor2.clearLine()
    monitor2.write("MANAGEMENT")
    monitor2.setCursorPos(24,1)
    monitor2.write(stillAliveString)
    monitor2.setBackgroundColor(colors.black)
    monitor2.setTextColor(colors.white)

    monitor2.setCursorPos(1,3)
    monitor2.clearLine()
    monitor2.write("INJECTION RATE:")
    monitor2.setCursorPos(1,4)
    monitor2.clearLine()
    monitor2.write(reactorInjectionRate .. " (required: " .. reactorMinInjectionRate .. ")")

    monitor2.setCursorPos(42,16)
    monitor2.clearLine()
    monitor2.setBackgroundColor(colors.gray)
    monitor2.write("[1][2][3]")
    monitor2.setBackgroundColor(colors.black)
    monitor2.setCursorPos(42,17)
    monitor2.clearLine()
    monitor2.setBackgroundColor(colors.gray)
    monitor2.write("[4][5][6]")
    monitor2.setBackgroundColor(colors.gray)
    monitor2.setCursorPos(1,18)
    monitor2.clearLine()
    monitor2.write("REACTOR: ")
    monitor2.setCursorPos(10,18)
    if reactorEnabled == true then
        monitor2.setBackgroundColor(colors.lime)
    else
        monitor2.setBackgroundColor(colors.gray)
    end
    monitor2.write("[ON]")
    monitor2.setCursorPos(14,18)
    if reactorEnabled == true then
        monitor2.setBackgroundColor(colors.gray)
    else
        monitor2.setBackgroundColor(colors.red)
    end
    monitor2.write("[OFF]")
    monitor2.setBackgroundColor(colors.gray)
    monitor2.setCursorPos(42,18)
    monitor2.setBackgroundColor(colors.gray)
    monitor2.write("[7][8][9]")
    monitor2.setBackgroundColor(colors.gray)
    monitor2.setCursorPos(1,19)
    monitor2.clearLine()
    monitor2.write("IGNITION: ")
    monitor2.setCursorPos(11,19)
    if reactorEnabled == true then
        monitor2.write("[IGNITE]")
    else
        monitor2.write("N/A")
    end
    monitor2.setBackgroundColor(colors.gray)
    monitor2.setCursorPos(42,19)
    monitor2.setBackgroundColor(colors.gray)
    monitor2.write("[C][0][>]")
    monitor2.setBackgroundColor(colors.black)
end

function values()
    while true do
        local reactor = peripheral.wrap(reactorString)

        reactorPlasmaTemperature = reactor.getPlasmaTemperature()
        reactorMaxPlasmaTemperature = reactor.getMaxPlasmaTemperature(true)
        reactorCaseTemperature = reactor.getCaseTemperature()
        reactorMaxCaseTemperature = reactor.getMaxCasingTemperature(true)
        reactorIgnitionTemperature = reactor.getIgnitionTemperature(true)

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

        reactorProductionRate = reactor.getProductionRate()
        reactorPassiveGeneration = reactor.getPassiveGeneration(true)/2.5

        reactorInjectionRate = reactor.getInjectionRate()
        reactorMinInjectionRate = reactor.getMinInjectionRate(true)
    end
end

function main()
    while true do
        updateMonitor1()
        updateMonitor2()

        stillAliveDisplay()

        sleep(0.05)
    end
end

monitor1.clear()
monitor2.clear()
monitor3.clear()

monitor1.setCursorPos(1,1)
monitor2.setCursorPos(1,1)
monitor3.setCursorPos(1,1)

monitor1.write("Fusion Reactor Manager")
monitor2.write("Fusion Reactor Manager")
monitor3.write("Fusion Reactor Manager")

monitor1.setCursorPos(1,19)
monitor2.setCursorPos(1,19)
monitor3.setCursorPos(1,19)

monitor1.write("Initializing...")
monitor2.write("Initializing...")
monitor3.write("Initializing...")

sleep(3)

monitor1.setCursorPos(1,1)
monitor2.setCursorPos(1,1)
monitor3.setCursorPos(1,1)

monitor1.clear()
monitor2.clear()
monitor3.clear()

parallel.waitForAll(main, values)
