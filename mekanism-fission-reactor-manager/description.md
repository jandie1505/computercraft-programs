# Mekanism Fission Reactor Manager

A management program for the sodium-cooled mekanism fission reactor.

## Features
- Overview of the reactor, boiler and turbine information on multiple monitors
- Start/stop reactor via the monitor
- Edit burn rate via the monitor
- Alarm system (high temperature, damage, coolant, fuel)
- Automatic reactor shutdown in case of an alarm
- Redstone input (external alarms) and Redstone output (in case of an alarm)

## Requirements
- 1 advanced computer
- 4 advanced monitors with size 5x3
- mekanism fission reactor (with logic adapter)
- mekanism boiler (with boiler valve)
- mekanism turbine (with turbine valve)
- 8 wired modems
- network cables

## Setup
1. Place the wired modems on the reactor logic adapter, boiler valve, turbine valve, computer and monitors
2. Connect all wired modems with a network cable and enable the modems (with right-clicking)
3. Download the program with wget
4. Open the program with edit (``edit <filename>``)
5. Set the first values (monitor1string, monitor2string, monitor3string, monitor4string, reactorString, boilerString, turbineString) to the correct peripherals (you see the peripheral names in chat if you right-click the wired modems)
6. Set the redstone alarm sides (alarmInput, alarmOutput) to a side of the computer (top, bottom, right, left, front, back)
7. Save the program
8. Create a file with the name ``startup`` (``edit startup``), write the line ``shell.run("<filename of the program>")`` into it and save the file (to start the program automatically on computer startup)
9. Run the program

## Controlling the reactor
- You can start and stop the reactor by clicking on ``[START REACTOR]`` or ``[STOP REACTOR]`` on monitor 2
- A reactor start needs to be confirmed by clicking on ``[Y]``
- The reactor start cannot be confirmed if there is currently an alarm
- The reactor cannot be controlled via the reactor gui (the computer will change the status back)
- You can set the reactor burn rate via the keypad on monitor 2
- ``x`` is the current cursor location in the input field
- By pressing one digit on the keypad, the cursor will move to the next field
- To clear the input, press the ``[C]`` (clear) key
- To apply the input, press the ``[S]`` (set) key (the input will only apply when it is below the max burn rate and higher than 0)
- The burn rate will be set to ``0`` if the reactor is started (you need to apply a burn rate after starting the reactor)

## Alarm system
An alarm starts if one of the following conditions is true:
- Reactor temperature is higher than 1200K
- Reactor damage is higher than 1%
- Reactor coolant is 50% or lower
- Reactor waste is higher or equal than 90%
  
The alarm message is displayed in the gray line on monitor 1.
  
If the reactor runs out of fuel, the internal reactor status will also be set to disabled. This means that an user has to restart the reactor manually if it gets back its fuel.
  
If the computer gets a redstone input on the ``alarmInput`` side, the reactor will be also shutdowned and if no other alarm is currently running, ``EXTERNAL`` is displayed in the alarm line on monitor 1.
  
If an alarm is running (except external alarm), the computer will output a redstone signal on the ``alarmOutput`` side. This can be connected to an alarm signal - for example the mekanism industrial alarm.
