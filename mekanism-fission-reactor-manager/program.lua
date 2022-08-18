local monitor1string = "monitor_4"
local monitor2string = "monitor_5"
local monitor3string = "monitor_6"
local monitor4string = "monitor_7"
local reactorString = "fissionReactorLogicAdapter_3"
local boilerString = "boilerValve_1"
local turbineString = "turbineValve_0"
local alarmInput = "right"
local alarmOutput = "left"

-- code

local monitor1 = peripheral.wrap(monitor1string)
local monitor2 = peripheral.wrap(monitor2string)
local monitor3 = peripheral.wrap(monitor3string)
local monitor4 = peripheral.wrap(monitor4string)
local reactor = peripheral.wrap(reactorString)
local boiler = peripheral.wrap(boilerString)
local turbine = peripheral.wrap(turbineString)

local updateBurnRate = {"0","0","0","0","0","0"}
local updateBurnRateCurrentField = 1
local updateBurnRateValueString = ""
local updateBurnValueCalc = ""
local updateBurnValue = 0

local reactorStatus = false
local reactorStatusButton = 0

local alarmStatus = false
local externalAlarmStatus = false

local stillAliveString = "."
local stillAliveTimer = 20

local reactorTemperature = -1
  
local reactorCoolantAmount = -1
local reactorCoolantCapacity = -1
local reactorCoolantFilledPercentage = -1
local reactorCoolantNeeded = -1

local reactorHeatedCoolantAmount = -1
local reactorHeatedCoolantCapacity = -1
local reactorHeatedCoolantFilledPercentage = -1
local reactorHeatedCoolantNeeded = -1

local reactorDamage = -1

local reactorFuelAmount = -1
local reactorFuelCapacity = -1
local reactorFuelFilledPercentage = -1

local reactorCurrentBurnRate = -1
local reactorBurnRate = -1
local reactorMaxBurnRate = -1

local reactorWasteAmount = -1
local reactorWasteCapacity = -1
local reactorWasteFilledPercentage = -1
  
local boilerTemperature = -1
  
local boilerWaterAmount = -1
local boilerWaterCapacity = -1
local boilerWaterFilledPercentage = -1
  
local boilerSteamAmount = -1
local boilerSteamCapacity = -1
local boilerSteamFilledPercentage = -1
  
local boilerCooledCoolantAmount = -1
local boilerCooledCoolantCapacity = -1
local boilerCooledCoolantFilledPercentage = -1
  
local boilerHeatedCoolantAmount = -1
local boilerHeatedCoolantCapacity = -1
local boilerHeatedCoolantFilledPercentage = -1
  
local boilerBoilRate = -1
local boilerMaxBoilRate = -1
local boilerBoilCapacity = -1
  
local turbineSteamAmount = -1
local turbineSteamCapacity = -1
local turbineSteamFilledPercentage = -1
local turbineSteamInputRate = -1
local turbineFlowRate = -1
local turbineMaxFlowRate = -1
local turbineDumpingMode = "UNKNOWN"
  
local turbineEnergyAmount = -1
local turbineMaxEnergy = -1
local turbineEnergyFilledPercentage = -1
local turbineProductionRate = -1
local turbineMaxProduction = -1
  
local reactorEnabled = false

function updateMonitor1()
  monitor1.setCursorPos(1,1)
  monitor1.setBackgroundColor(colors.white)
  monitor1.setTextColor(colors.black)
  monitor1.clearLine()
  monitor1.write("REACTOR")
  monitor1.setCursorPos(24,1)
  monitor1.write(stillAliveString)
  if alarmStatus == true then
    monitor1.setCursorPos(46,1)
    monitor1.setTextColor(colors.red)
    monitor1.write("ALARM")
  elseif externalAlarmStatus == true then
    monitor1.setCursorPos(41,1)
    monitor1.setTextColor(colors.red)
    monitor1.write("EXT. ALARM")
  end
  monitor1.setBackgroundColor(colors.black)
  monitor1.setTextColor(colors.white)
  
  monitor1.setCursorPos(1,4)
  monitor1.clearLine()
  monitor1.write("TEMPERATURE:")
  monitor1.setCursorPos(1,5)
  monitor1.clearLine()
  monitor1.write(math.ceil(reactorTemperature) .. "K")
  
  monitor1.setCursorPos(1,7)
  monitor1.clearLine()
  monitor1.write("COOLANT:")
  monitor1.setCursorPos(1,8)
  monitor1.clearLine()
  monitor1.write(reactorCoolantAmount .. "mB / " .. reactorCoolantCapacity .. "mB (" .. math.ceil(reactorCoolantFilledPercentage) * 100 .. "%)")
  monitor1.setCursorPos(1,9)
  monitor1.clearLine()
  monitor1.write("Needed: " .. reactorCoolantNeeded .. "mB")
  
  monitor1.setCursorPos(1,11)
  monitor1.clearLine()
  monitor1.write("HEATED COOLANT:")
  monitor1.setCursorPos(1,12)
  monitor1.clearLine()
  monitor1.write(reactorHeatedCoolantAmount .. "mB / " .. reactorHeatedCoolantCapacity .. "mB (" .. math.ceil(reactorHeatedCoolantFilledPercentage * 100) .. "%)")
  monitor1.setCursorPos(1,13)
  monitor1.clearLine()
  monitor1.write("Needed: " .. reactorHeatedCoolantNeeded .. "mB")
  
  monitor1.setCursorPos(1,15)
  monitor1.clearLine()
  monitor1.write("DAMAGE:")
  monitor1.setCursorPos(1,16)
  monitor1.clearLine()
  monitor1.write(reactorDamage .. "%")
  
  monitor1.setCursorPos(-1,19)
  monitor1.setBackgroundColor(colors.gray)
  monitor1.clearLine()
  monitor1.setTextColor(colors.red)
  monitor1.write(reactorSafetyMessages)
  monitor1.setTextColor(colors.white)
  monitor1.setBackgroundColor(colors.black)
end

function updateMonitor2()
  monitor2.setCursorPos(1,1)
  monitor2.setBackgroundColor(colors.white)
  monitor2.setTextColor(colors.black)
  monitor2.clearLine()
  monitor2.write("REACTOR")
  monitor2.setCursorPos(24,1)
  monitor2.write(stillAliveString)
  if alarmStatus == true then
    monitor2.setCursorPos(46,1)
    monitor2.setTextColor(colors.red)
    monitor2.write("ALARM")
  elseif externalAlarmStatus == true then
    monitor2.setCursorPos(41,1)
    monitor2.setTextColor(colors.red)
    monitor2.write("EXT. ALARM")
  end
  monitor2.setBackgroundColor(colors.black)
  monitor2.setTextColor(colors.white)
  
  monitor2.setCursorPos(1,4)
  monitor2.clearLine()
  monitor2.write("FUEL:")
  monitor2.setCursorPos(1,5)
  monitor2.clearLine()
  monitor2.write(reactorFuelAmount .. "mB / " .. reactorFuelCapacity .. "mB (" .. math.ceil(reactorFuelFilledPercentage * 100) .. "%)")
  
  monitor2.setCursorPos(1,7)
  monitor2.clearLine()
  monitor2.write("BURN RATE:")
  monitor2.setCursorPos(1,8)
  monitor2.clearLine()
  monitor2.write(reactorCurrentBurnRate .. "mB/t / " .. reactorBurnRate .. "mB/t")
  monitor2.setCursorPos(1,9)
  monitor2.clearLine()
  monitor2.write("Max: " .. reactorMaxBurnRate .. "mB/t")
  
  monitor2.setCursorPos(1,11)
  monitor2.clearLine()
  monitor2.write("NUCLEAR WASTE:")
  monitor2.setCursorPos(1,12)
  monitor2.clearLine()
  monitor2.write(reactorWasteAmount .. "mB / " .. reactorWasteCapacity .. "mB (" .. math.ceil(reactorWasteFilledPercentage * 100) .. "%)")
  
  monitor2.setCursorPos(1,14)
  monitor2.clearLine()
  monitor2.write("REACTOR STATUS:")
  monitor2.setCursorPos(42,14)
  monitor2.setBackgroundColor(colors.gray)
  monitor2.write("Set Rate:")
  monitor2.setBackgroundColor(colors.black)
  monitor2.setCursorPos(1,15)
  monitor2.clearLine()
  if reactorEnabled then
    monitor2.write("enabled ")
  else
    monitor2.write("disabled")
  end
  monitor2.setCursorPos(42,15)
  monitor2.setBackgroundColor(colors.gray)
  monitor2.write("> " .. updateBurnRateValueString)
  monitor2.setBackgroundColor(colors.black)
  
  monitor2.setCursorPos(42,16)
  monitor2.clearLine()
  monitor2.setBackgroundColor(colors.gray)
  monitor2.write("[1][2][3]")
  monitor2.setBackgroundColor(colors.black)
  monitor2.setCursorPos(42,17)
  monitor2.clearLine()
  monitor2.setBackgroundColor(colors.gray)
  monitor2.write("[4][5][6]")
  monitor2.setBackgroundColor(colors.black)
  monitor2.setCursorPos(42,18)
  monitor2.clearLine()
  monitor2.setBackgroundColor(colors.gray)
  monitor2.write("[7][8][9]")
  monitor2.setBackgroundColor(colors.black)
  monitor2.setCursorPos(1,19)
  monitor2.setBackgroundColor(colors.gray)
  monitor2.clearLine()
  if reactorStatus == true then
    reactorStatusButton = 2
  elseif reactorStatusButton ~= 1 then
    reactorStatusButton = 0
  end
  if reactorStatusButton == 0 then
    monitor2.write("[START REACTOR]")
  elseif reactorStatusButton == 1 then
    monitor2.write("confirm reactor start [Y] [N]")
  elseif reactorStatusButton == 2 then
    monitor2.write("[SHUTDOWN REACTOR]")
  else
    monitor2.write("-- unknown status --")
    reactorStatus = false
  end
  monitor2.setCursorPos(42,19)
  monitor2.write("[C][0][S]")
  monitor2.setBackgroundColor(colors.black)
end

function updateMonitor3()
  monitor3.setCursorPos(1,1)
  monitor3.setTextColor(colors.black)
  monitor3.setBackgroundColor(colors.white)
  monitor3.clearLine()
  monitor3.write("BOILER")
  monitor3.setCursorPos(24,1)
  monitor3.write(stillAliveString)
  monitor3.setTextColor(colors.white)
  monitor3.setBackgroundColor(colors.black)
  
  monitor3.setCursorPos(1,4)
  monitor3.clearLine()
  monitor3.write("TEMPERATURE:")
  monitor3.setCursorPos(1,5)
  monitor3.clearLine()
  monitor3.write(math.ceil(boilerTemperature) .. "K")
  
  monitor3.setCursorPos(1,7)
  monitor3.clearLine()
  monitor3.write("WATER:")
  monitor3.setCursorPos(1,8)
  monitor3.clearLine()
  monitor3.write("Liquid: " .. boilerWaterAmount .. "mB / " .. boilerWaterCapacity .. "mB (" .. math.ceil(boilerWaterFilledPercentage * 100) .. "%)")
  monitor3.setCursorPos(1,9)
  monitor3.clearLine()
  monitor3.write("Gaseous: " .. boilerSteamAmount .. "mB / " .. boilerSteamCapacity .. "mB (" .. math.ceil(boilerSteamFilledPercentage * 100) .. "%)")
  
  monitor3.setCursorPos(1,11)
  monitor3.clearLine()
  monitor3.write("COOLANT:")
  monitor3.setCursorPos(1,12)
  monitor3.clearLine()
  monitor3.write("Cool: " .. boilerCooledCoolantAmount .. "mB / " .. boilerCooledCoolantCapacity .. "mB (" .. math.ceil(boilerCooledCoolantFilledPercentage * 100) .. "%)")
  monitor3.setCursorPos(1,13)
  monitor3.clearLine()
  monitor3.write("Hot: " .. boilerHeatedCoolantAmount .. "mB / " .. boilerHeatedCoolantCapacity .. "mB (" .. math.ceil(boilerHeatedCoolantFilledPercentage * 100) .. "%)")
  
  monitor3.setCursorPos(1,15)
  monitor3.clearLine()
  monitor3.write("BOIL RATE:")
  monitor3.setCursorPos(1,16)
  monitor3.clearLine()
  monitor3.write(boilerBoilRate .. "mB / " .. boilerMaxBoilRate .. "mB")
  monitor3.setCursorPos(1,17)
  monitor3.clearLine()
  monitor3.write("Capacity: " .. boilerBoilCapacity .. "mB")
  
  monitor3.setCursorPos(1,19)
  monitor3.setBackgroundColor(colors.gray)
  monitor3.clearLine()
  monitor3.setBackgroundColor(colors.black)
end

function updateMonitor4()
  monitor4.setCursorPos(1,1)
  monitor4.setTextColor(colors.black)
  monitor4.setBackgroundColor(colors.white)
  monitor4.clearLine()
  monitor4.write("TURBINE")
  monitor4.setCursorPos(24,1)
  monitor4.write(stillAliveString)
  monitor4.setTextColor(colors.white)
  monitor4.setBackgroundColor(colors.black)
  
  monitor4.setCursorPos(1,4)
  monitor4.clearLine()
  monitor4.write("STEAM:")
  monitor4.setCursorPos(1,5)
  monitor4.clearLine()
  monitor4.write("Stored: " .. turbineSteamAmount .. "mB / " .. turbineSteamCapacity .. "mB (" .. math.ceil(turbineSteamFilledPercentage * 100) .. "%)")
  monitor4.setCursorPos(1,6)
  monitor4.clearLine()
  monitor4.write("Input: " .. turbineSteamInputRate .. "mB/t")
  monitor4.setCursorPos(1,7)
  monitor4.clearLine()
  monitor4.write("Flow: " .. turbineFlowRate .. "mB/t / " .. turbineMaxFlowRate .. "mB/t")
  monitor4.setCursorPos(1,8)
  monitor4.clearLine()
  monitor4.write("Dumping: " .. turbineDumpingMode)
  
  monitor4.setCursorPos(1,10)
  monitor4.clearLine()
  monitor4.write("ENERGY:")
  monitor4.setCursorPos(1,11)
  monitor4.clearLine()
  monitor4.write("Stored: " .. math.ceil(turbineEnergyAmount) .. "FE / " .. math.ceil(turbineMaxEnergy) .. "FE (" .. math.ceil(turbineEnergyFilledPercentage * 100) .. "%)")
  monitor4.setCursorPos(1,12)
  monitor4.clearLine()
  monitor4.write("Production: " .. math.ceil(turbineProductionRate) .. "RF/t / " .. math.ceil(turbineMaxProduction) .. "RF/t")
  
  monitor4.setCursorPos(1,19)
  monitor4.setBackgroundColor(colors.gray)
  monitor4.clearLine()
  monitor4.setBackgroundColor(colors.black)
end

function updateMonitors()
  updateMonitor1()
  updateMonitor2()
  updateMonitor3()
  updateMonitor4()
end

function reactorStatusManager()
  if reactorStatus ~= reactorEnabled then
    if reactorStatus == true then
      if reactor.getStatus() == false then
        reactor.setBurnRate(0)
        reactor.activate()
      end
    else
      if reactor.getStatus() == true then
        reactor.scram()
      end
    end
  end
end

function reactorSafetyCheck()
  reactorSafetyMessages = ""
  alarmStatus = false
  externalAlarmStatus = false
  if reactorDamage >= 1 then
    reactorStatus = false
    reactorSafetyMessages = reactorSafetyMessages .. ", DAMAGE"
    alarmStatus = true
  end
  if reactorTemperature >= 1200 then
    reactorStatus = false
    reactorSafetyMessages = reactorSafetyMessages .. ", TEMPERATURE"
    alarmStatus = true
  end
  if reactorWasteFilledPercentage >= 0.9 then
    reactorStatus = false
    reactorSafetyMessages = reactorSafetyMessages .. ", WASTE"
    alarmStatus = true
  end
  if reactorCoolantFilledPercentage <= 0.5 then
    reactorStatus = false
    reactorSafetyMessages = reactorSafetyMessages .. ", COOLANT"
    alarmStatus = true
  end
  if reactorFuelFilledPercentage <= 0 then
    reactorStatus = false
    reactorSafetyMessages = reactorSafetyMessages .. ", FUEL"
  end
  if rs.getInput(alarmInput) == true then
    reactorStatus = false
    externalAlarmStatus = true
  end
  if alarmStatus == false and externalAlarmStatus == true then
    reactorSafetyMessages = reactorSafetyMessages .. ", EXTERNAL"
  end
end

function alarmStatusCheck()
  if alarmStatus == true then
    rs.setOutput(alarmOutput, true)
  else
    rs.setOutput(alarmOutput, false)
  end
end

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

function main()
  while(true) do
    updateBurnRateValueString = ""
    for i = 1, 6 do
      if i == updateBurnRateCurrentField then
        updateBurnRateValueString = updateBurnRateValueString .. "x"
      else
        updateBurnRateValueString = updateBurnRateValueString .. updateBurnRate[i]
      end
      if i == 4 then
        updateBurnRateValueString = updateBurnRateValueString .. "."
      end
    end
    
    reactorSafetyCheck()
    
    alarmStatusCheck()
    
    reactorStatusManager()
    
    stillAliveDisplay()
  
    updateMonitors()
  
    sleep(0.05)
  end
end

function values()
  while true do
    reactorTemperature = reactor.getTemperature()
  
    reactorCoolantAmount = reactor.getCoolant()["amount"]
    reactorCoolantCapacity = reactor.getCoolantCapacity()
    reactorCoolantFilledPercentage = reactor.getCoolantFilledPercentage()
    reactorCoolantNeeded = reactor.getCoolantNeeded()

    reactorHeatedCoolantAmount = reactor.getHeatedCoolant()["amount"]
    reactorHeatedCoolantCapacity = reactor.getHeatedCoolantCapacity()
    reactorHeatedCoolantFilledPercentage = reactor.getHeatedCoolantFilledPercentage()
    reactorHeatedCoolantNeeded = reactor.getHeatedCoolantNeeded()

    reactorDamage = reactor.getDamagePercent()

    reactorFuelAmount = reactor.getFuel()["amount"]
    reactorFuelCapacity = reactor.getFuelCapacity()
    reactorFuelFilledPercentage = reactor.getFuelFilledPercentage()

    reactorCurrentBurnRate = reactor.getActualBurnRate()
    reactorBurnRate = reactor.getBurnRate()
    reactorMaxBurnRate = reactor.getMaxBurnRate()

    reactorWasteAmount = reactor.getWaste()["amount"]
    reactorWasteCapacity = reactor.getWasteCapacity()
    reactorWasteFilledPercentage = reactor.getWasteFilledPercentage()
  
    boilerTemperature = boiler.getTemperature()
  
    boilerWaterAmount = boiler.getWater()["amount"]
    boilerWaterCapacity = boiler.getWaterCapacity()
    boilerWaterFilledPercentage = boiler.getWaterFilledPercentage()
  
    boilerSteamAmount = boiler.getSteam()["amount"]
    boilerSteamCapacity = boiler.getSteamCapacity()
    boilerSteamFilledPercentage = boiler.getSteamFilledPercentage()
  
    boilerCooledCoolantAmount = boiler.getCooledCoolant()["amount"]
    boilerCooledCoolantCapacity = boiler.getCooledCoolantCapacity()
    boilerCooledCoolantFilledPercentage = boiler.getCooledCoolantFilledPercentage()
  
    boilerHeatedCoolantAmount = boiler.getHeatedCoolant()["amount"]
    boilerHeatedCoolantCapacity = boiler.getHeatedCoolantCapacity()
    boilerHeatedCoolantFilledPercentage = boiler.getHeatedCoolantFilledPercentage()
  
    boilerBoilRate = boiler.getBoilRate()
    boilerMaxBoilRate = boiler.getMaxBoilRate()
    boilerBoilCapacity = boiler.getBoilCapacity()
  
    turbineSteamAmount = turbine.getSteam()["amount"]
    turbineSteamCapacity = turbine.getSteamCapacity()
    turbineSteamFilledPercentage = turbine.getSteamFilledPercentage()
    turbineSteamInputRate = turbine.getLastSteamInputRate()
    turbineFlowRate = turbine.getFlowRate()
    turbineMaxFlowRate = turbine.getMaxFlowRate()
    turbineDumpingMode = turbine.getDumpingMode()
  
    turbineEnergyAmount = turbine.getEnergy()
    turbineMaxEnergy = turbine.getMaxEnergy()
    turbineEnergyFilledPercentage = turbine.getEnergyFilledPercentage()
    turbineProductionRate = turbine.getProductionRate()
    turbineMaxProduction = turbine.getMaxProduction()
  
    reactorEnabled = reactor.getStatus()
  end
end

function input()
  while(true) do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if(side == monitor2string) then
      -- 1
      if(x == 43 and y == 16) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 1
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 2
      if(x == 46 and y == 16) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 2
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 3
      if(x == 49 and y == 16) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 3
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 4
      if(x == 43 and y == 17) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 4
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 5
      if(x == 46 and y == 17) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 5
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 6
      if(x == 49 and y == 17) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 6
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 7
      if(x == 43 and y == 18) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 7
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 8
      if(x == 46 and y == 18) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 8
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- 9
      if(x == 49 and y == 18) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 9
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- C
      if(x == 43 and y == 19) then
        updateBurnRate = {"0","0","0","0","0","0"}
        updateBurnRateCurrentField = 1
      end
      -- 0
      if(x == 46 and y == 19) then
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRate[updateBurnRateCurrentField] = 0
        end
        if(updateBurnRateCurrentField <= 6) then
          updateBurnRateCurrentField = updateBurnRateCurrentField + 1
        end
      end
      -- S
      if(x == 49 and y == 19) then
        updateBurnRateValueCalc = updateBurnRate[1] .. updateBurnRate[2] .. updateBurnRate [3]  .. updateBurnRate [4] .. "." .. updateBurnRate [5] .. updateBurnRate [6]
        updateBurnRateValue = tonumber(updateBurnRateValueCalc)
        if updateBurnRateValue <= reactor.getMaxBurnRate() and updateBurnRateValue >= 0 then
          reactor.setBurnRate(updateBurnRateValue)
        end
        updateBurnRate = {"0","0","0","0","0","0"}
        updateBurnRateCurrentField = 1
      end
      if(x >= 2 and x <= 14 and y == 19 and reactorStatusButton == 0) then
        reactorStatusButton = 1
      end
      if(x == 24 and y == 19 and reactorStatusButton == 1) then
        reactorStatus = true
      end
      if(x == 28 and y == 19 and reactorStatusButton == 1) then
        reactorStatusButton = 0
      end
      if(x >= 2 and x <= 17 and y == 19 and reactorStatusButton == 2) then
        reactorStatus = false
      end
    end
    -- print("The monitor on side " .. side .. " was touched at (" .. x .. ", " .. y .. ")")
  end
end

monitor1.clear()
monitor2.clear()
monitor3.clear()
monitor4.clear()

monitor1.setCursorPos(1,1)
monitor2.setCursorPos(1,1)
monitor3.setCursorPos(1,1)
monitor4.setCursorPos(1,1)

monitor1.setTextScale(1)
monitor2.setTextScale(1)
monitor3.setTextScale(1)
monitor4.setTextScale(1)

monitor1.write("Initializing...")
monitor2.write("Initializing...")
monitor3.write("Initializing...")
monitor4.write("Initializing...")

sleep(3)

monitor1.clear()
monitor2.clear()
monitor3.clear()
monitor4.clear()

parallel.waitForAll(main, values, input)
