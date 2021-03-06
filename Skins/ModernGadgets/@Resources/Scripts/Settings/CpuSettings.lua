-- MODERNGADGETS CPU SETTINGS SCRIPT
-- By iamanai
--
-- Consists of hard-coded functions to change settigns in CPU Meter
--

isDbg = false

function Initialize()

  cpuSettingsPath = SKIN:GetVariable('cpuSettingsPath')
  cpuMeterPath = SKIN:GetVariable('cpuMeterPath')
  cpuMeterConfig = SKIN:GetVariable('cpuMeterConfig')

end

function Update() end

function ToggleCpuName(currentValue)

  LogHelper(tostring(currentValue), 'Debug')

  currentValue = tonumber(currentValue)

  if currentValue == 0 then
    SKIN:Bang('!SetVariable', 'showCpuName', '1')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuName', '1', cpuSettingsPath)
    SKIN:Bang('!ShowMeter', 'CpuDisplayNameString', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!SetOption', 'CpuDisplayNameString', 'Y', '#*rowSpacing*#R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Y', '#*rowSpacing*#R', cpuMeterPath)
  else
    SKIN:Bang('!SetVariable', 'showCpuName', '0')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuName', '0', cpuSettingsPath)
    SKIN:Bang('!HideMeter', 'CpuDisplayNameString', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!SetOption', 'CpuDisplayNameString', 'Y', 'R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Y', 'R', cpuMeterPath)
  end

  SKIN:Bang('!UpdateMeter', 'CpuDisplayNameString', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'Background', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)

end

function TogglePage(currentValue)

  LogHelper(tostring(currentValue), 'Debug')

  currentValue = tonumber(currentValue)
  local colorPage = SKIN:GetVariable('colorPage')

  if currentValue == 0 then
    SKIN:Bang('!SetVariable', 'showPageFile', '1')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showPageFile', '1', cpuSettingsPath)
    SKIN:Bang('!ShowMeterGroup', 'CpuPage', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'PageLabelString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageFractionString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageValueString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageBar', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!SetOption', 'PageLabelString', 'Y', '#*rowSpacing*#R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'PageLabelString', 'Y', '#*rowSpacing*#R', cpuMeterPath)
    SKIN:Bang('!SetOption', 'GraphLines', 'LineColor22', colorPage, cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor22', colorPage, cpuMeterPath)
  else
    SKIN:Bang('!SetVariable', 'showPageFile', '0')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showPageFile', '0', cpuSettingsPath)
    SKIN:Bang('!HideMeterGroup', 'CpuPage', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'PageLabelString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageFractionString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageValueString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'PageBar', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!SetOption', 'PageLabelString', 'Y', '-#*barTextOffset*#R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'PageLabelString', 'Y', '-#*barTextOffset*#R', cpuMeterPath)
    SKIN:Bang('!SetOption', 'GraphLines', 'LineColor22', '0,0,0,0', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor22', '0,0,0,0', cpuMeterPath)
  end

  SKIN:Bang('!UpdateMeterGroup', 'CpuPage', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'LineGraph', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'Background', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)

end

function ToggleCoreTemps(currentValue, isHwinfoAvailable, cpuCores)

  LogHelper(tostring(currentValue), 'Debug')

  currentValue = tonumber(currentValue)
  isHwinfoAvailable = tonumber(isHwinfoAvailable)
  cpuCores = tonumber(cpuCores)

  if isHwinfoAvailable == 1 then
    if currentValue == 0 then
      SKIN:Bang('!SetVariable', 'showCoreTemps', '1')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showCoreTemps', '1', cpuSettingsPath)

      SKIN:Bang('!CommandMeasure', 'MeasureCpuConfigScript', 'ToggleTemps(' .. cpuCores .. ', true)', cpuMeterConfig)
    else
      SKIN:Bang('!SetVariable', 'showCoreTemps', '0')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showCoreTemps', '0', cpuSettingsPath)
      SKIN:Bang('!CommandMeasure', 'MeasureCpuConfigScript', 'ToggleTemps(' .. cpuCores .. ', false)', cpuMeterConfig)
    end

  SKIN:Bang('!UpdateMeterGroup', 'CoreTemps', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)

  else
    SKIN:Bang('!Log', isHwinfoAvailable .. ' | Cannot display core temperatures, for HWiNFO is not running!', 'Warning')
  end

end

function ToggleCpuFan(currentValue, isHwinfoAvailable, showCpuClock, showLineGraph)

  LogHelper(tostring(currentValue), 'Debug')

  if isHwinfoAvailable == 1 then
    if currentValue == 0 then
      SKIN:Bang('!SetVariable', 'showCpuFan', '1')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuFan', '1', cpuSettingsPath)

      SKIN:Bang('!ShowMeterGroup', 'CpuFan', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'FanLabelString', 'Hidden', '0', cpuMeterPath)
      SKIN:Bang('!WriteKeyValue', 'FanValueString', 'Hidden', '0', cpuMeterPath)
      SKIN:Bang('!SetOption', 'FanLabelString', 'Y', '#*rowSpacing*#R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'FanLabelString', 'Y', '#*rowSpacing*#R', cpuMeterPath)

      SetLineGraphY(showLineGraph, 1, showCpuClock)
    else
      SKIN:Bang('!SetVariable', 'showCpuFan', '0')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuFan', '0', cpuSettingsPath)
      SKIN:Bang('!HideMeterGroup', 'CpuFan', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'FanLabelString', 'Hidden', '1', cpuMeterPath)
      SKIN:Bang('!WriteKeyValue', 'FanValueString', 'Hidden', '1', cpuMeterPath)
      SKIN:Bang('!SetOption', 'FanLabelString', 'Y', 'R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'FanLabelString', 'Y', 'R', cpuMeterPath)

      SetLineGraphY(showLineGraph, 0, showCpuClock)
    end
  else
        SKIN:Bang('!Log', 'Cannot display fan speed, for HWiNFO is not running!', 'Error')
  end

  SKIN:Bang('!UpdateMeterGroup', 'CpuFan', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'LineGraph', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'Background', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)

end

-- function ToggleAltFanDisplay(currentValue, showCpuFan, showCpuClock, showLineGraph, isHwinfoAvailable)
--   
--   currentValue = tonumber(currentValue)
--   showCpuFan = tonumber(showCpuFan)
--   showCpuClock = tonumber(showCpuClock)
--   showLineGraph = tonumber(showLineGraph)
--   isHwinfoAvailable = tonumber(isHwinfoAvailable)
--   
--   if isHwinfoAvailable == 1 then
--     if showCpuFan == 1 then
--       if currentValue == 0 then
--         SKIN:Bang('!SetVariable', 'useAltFanDisplay', '1')
--         SKIN:Bang('!SetVariable', 'useAltFanDisplay', '1', cpuMeterConfig)
--         SKIN:Bang('!WriteKeyValue', 'Variables', 'useAltFanDisplay', '1', cpuSettingsPath)
--         
--         SKIN:Bang('!HideMeterGroup', 'CpuFan', cpuMeterConfig)
--         
--       else
--         SKIN:Bang('!SetVariable', 'useAltFanDisplay', '0')
--         SKIN:Bang('!SetVariable', 'useAltFanDisplay', '0', cpuMeterConfig)
--         SKIN:Bang('!WriteKeyValue', 'Variables', 'useAltFanDisplay', '0', cpuSettingsPath)
--         
--       end
--     else
--       LogHelper('Regular fan display must be enabled first!', 'Warning')
--     end
--   else
--     LogHelper('Cannot display CPU fan information without HWiNFO running!', 'Warning')
--   end
--   
-- end

function ToggleCpuClock(currentValue, showCpuFan, showLineGraph)

  LogHelper(tostring(currentValue), 'Debug')

  if currentValue == 0 then
    SKIN:Bang('!SetVariable', 'showCpuClock', '1')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuClock', '1', cpuSettingsPath)

    SKIN:Bang('!ShowMeterGroup', 'CpuClock', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuClockLabelString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'CpuClockValueString', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!SetOption', 'CpuClockLabelString', 'Y', '#*rowSpacing*#R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuClockLabelString', 'Y', '#*rowSpacing*#R', cpuMeterPath)

    SetLineGraphY(showLineGraph, showCpuFan, 1)
  else
    SKIN:Bang('!SetVariable', 'showCpuClock', '0')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showCpuClock', '0', cpuSettingsPath)
    SKIN:Bang('!HideMeterGroup', 'CpuClock', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuClockLabelString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'CpuClockValueString', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!SetOption', 'CpuClockLabelString', 'Y', 'R', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuClockLabelString', 'Y', 'R', cpuMeterPath)

    SetLineGraphY(showLineGraph, showCpuFan, 0)
  end

SKIN:Bang('!UpdateMeterGroup', 'CpuClock', cpuMeterConfig)
SKIN:Bang('!UpdateMeterGroup', 'LineGraph', cpuMeterConfig)
SKIN:Bang('!UpdateMeterGroup', 'Background', cpuMeterConfig)
SKIN:Bang('!Redraw', cpuMeterConfig)

end

function ToggleLineGraph(currentValue, showCpuFan, showCpuClock)

  LogHelper(tostring(currentValue), 'Debug')

  if currentValue == 0 then
    SKIN:Bang('!SetVariable', 'showLineGraph', '1')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showLineGraph', '1', cpuSettingsPath)

    SKIN:Bang('!ShowMeterGroup', 'LineGraph', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'GraphLines', 'Hidden', '0', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'GraphBorder', 'Hidden', '0', cpuMeterPath)

    SetLineGraphY(1, showCpuFan, showCpuClock)
  else
    SKIN:Bang('!SetVariable', 'showLineGraph', '0')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'showLineGraph', '0', cpuSettingsPath)

    SKIN:Bang('!HideMeterGroup', 'LineGraph', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'GraphLines', 'Hidden', '1', cpuMeterPath)
    SKIN:Bang('!WriteKeyValue', 'GraphBorder', 'Hidden', '1', cpuMeterPath)

    SetLineGraphY(0, showCpuFan, showCpuClock)
  end

  SKIN:Bang('!UpdateMeterGroup', 'LineGraph', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'Background', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)
  SKIN:Bang('!UpdateMeterGroup', 'ToggleButtons')
  SKIN:Bang('!Redraw')

end

function ToggleAvgCpuGraph(currentValue, showLineGraph)

  currentValue = tonumber(currentValue)
  showLineGraph = tonumber(showLineGraph)

  if showLineGraph == 1 then
    if currentValue == 0 then
      SKIN:Bang('!SetVariable', 'showAvgCpu', '1')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showAvgCpu', '1', cpuSettingsPath)

      SKIN:Bang('!SetOption', 'GraphLines', 'LineColor', '0,0,0,0', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor', '0,0,0,0', cpuMeterPath)
      for i=2,20 do
        SKIN:Bang('!SetOption', 'GraphLines', 'LineColor' .. i, '0,0,0,0', cpuMeterConfig)
        SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor' .. i, '0,0,0,0', cpuMeterPath)
      end
      SKIN:Bang('!SetOption', 'GraphLines', 'LineColor21', '#*colorAvgCpu*#', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor21', '#*colorAvgCpu*#', cpuMeterPath)
    else
      SKIN:Bang('!SetVariable', 'showAvgCpu', '0')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showAvgCpu', '0', cpuSettingsPath)
      SKIN:Bang('!CommandMeasure', 'MeasureCpuConfigScript', 'ConfigCores(#threadCount#, 0)', cpuMeterConfig)
      SKIN:Bang('!SetOption', 'GraphLines', 'LineColor21', '0,0,0,0', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor21', '0,0,0,0', cpuMeterPath)
    end

    SKIN:Bang('!UpdateMeter', 'GraphLines', cpuMeterConfig)
    SKIN:Bang('!Redraw', cpuMeterConfig)
  else
    LogHelper('Line graph is disabled', 'Warning')
  end

end

function SetLineGraphY(showLineGraph, showCpuFan, showCpuClock)

  -- SKIN:Bang('!Log', showLineGraph .. ', ' .. showCpuFan .. ', ' .. showCpuClock, 'Debug')

  if showCpuFan == 1 or showCpuClock == 1 then
    if showLineGraph == 1 then
      SKIN:Bang('!SetOption', 'ThermalThrottlingHistogram', 'Y', '(#*barTextOffset*# + 1)R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'ThermalThrottlingHistogram', 'Y', '(#*barTextOffset*# + 1)R', cpuMeterPath)
    else
      SKIN:Bang('!SetOption', 'ThermalThrottlingHistogram', 'Y', 'R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'ThermalThrottlingHistogram', 'Y', 'R', cpuMeterPath)
    end
  else
    if showLineGraph == 1 then
      SKIN:Bang('!SetOption', 'ThermalThrottlingHistogram', 'Y', '5R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'ThermalThrottlingHistogram', 'Y', '5R', cpuMeterPath)
    else
      SKIN:Bang('!SetOption', 'ThermalThrottlingHistogram', 'Y', '2R', cpuMeterConfig)
      SKIN:Bang('!WriteKeyValue', 'ThermalThrottlingHistogram', 'Y', '2R', cpuMeterPath)
    end
  end

end

function SetCpuName(name)

  if name == "" then
    SKIN:Bang('!SetVariable', 'cpuName', 'auto')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'cpuName', 'auto', cpuSettingsPath)
    SKIN:Bang('!SetOption', 'CpuDisplayNameString', 'Text', '%1', cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Text', '%1', cpuMeterPath)
    SKIN:Bang('!UpdateMeter', 'CpuDisplayNameString', cpuMeterConfig)
    SKIN:Bang('!Redraw', cpuMeterConfig)
  else
    SKIN:Bang('!SetVariable', 'cpuName', name)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'cpuName', name, cpuSettingsPath)
    SKIN:Bang('!SetOption', 'CpuDisplayNameString', 'Text', name, cpuMeterConfig)
    SKIN:Bang('!WriteKeyValue', 'CpuDisplayNameString', 'Text', name, cpuMeterPath)
    SKIN:Bang('!UpdateMeter', 'CpuDisplayNameString', cpuMeterConfig)
    SKIN:Bang('!Redraw', cpuMeterConfig)
  end

end

function ToggleTtDetection(currentValue)

  currentValue = tonumber(currentValue)

  if currentValue == 0 then
      SKIN:Bang('!SetVariable', 'showTt', '1')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showTt', '1', cpuSettingsPath)
      SKIN:Bang('!SetVariable', 'showTt', '1', cpuMeterConfig)
  else
      SKIN:Bang('!SetVariable', 'showTt', '0')
      SKIN:Bang('!WriteKeyValue', 'Variables', 'showTt', '0', cpuSettingsPath)
      SKIN:Bang('!SetVariable', 'showTt', '0', cpuMeterConfig)
  end
  
  SKIN:Bang('!UpdateMeasure', 'MeasureCpuTtCalc', cpuMeterConfig)
  SKIN:Bang('!Redraw', cpuMeterConfig)

end

function ToggleTtSound(currentValue, showTt)

  currentValue = tonumber(currentValue)
  showTt = tonumber(showTt)
  
  if showTt == 1 then
    if currentValue == 0 then
        SKIN:Bang('!SetVariable', 'playTtSound', '1')
        SKIN:Bang('!WriteKeyValue', 'Variables', 'playTtSound', '1', cpuSettingsPath)
        SKIN:Bang('!SetVariable', 'playTtSound', '1', cpuMeterConfig)
    else
        SKIN:Bang('!SetVariable', 'playTtSound', '0')
        SKIN:Bang('!WriteKeyValue', 'Variables', 'playTtSound', '0', cpuSettingsPath)
        SKIN:Bang('!SetVariable', 'playTtSound', '0', cpuMeterConfig)
    end
  else
    LogHelper("Thermal throttling detection is not enabled!", "Warning")
  end

  SKIN:Bang('!UpdateMeasure', 'MeasureCpuTtCalc', cpuMeterConfig)

end

function UpdateSettings()

  local showCpuName = math.abs(tonumber(SKIN:GetVariable('showCpuName')) - 1)
  local showPageFile = math.abs(tonumber(SKIN:GetVariable('showPageFile')) - 1)
  local showCoreTemps = math.abs(tonumber(SKIN:GetVariable('showCoreTemps')) - 1)
  local showCpuFan = tonumber(SKIN:GetVariable('showCpuFan'))
  local showCpuClock = tonumber(SKIN:GetVariable('showCpuClock'))
  local showLineGraph = tonumber(SKIN:GetVariable('showLineGraph'))
  local showAvgCpu = tonumber(SKIN:GetVariable('showAvgCpu'))
  local cpuName = tostring(SKIN:GetVariable('cpuName'))
  local showTt = tonumber(SKIN:GetVariable('showTt'))
  local playTtSound = tonumber(SKIN:GetVariable('playTtSound'))
  local isHwinfoAvailable = tonumber(SKIN:GetVariable('isHwinfoAvailable'))
  local cpuCores = tonumber(SKIN:GetVariable('threadCount'))

  if cpuName == 'auto' then cpuName = '' end

  ToggleCpuName(showCpuName)
  TogglePage(showPageFile)
  ToggleCoreTemps(showCoreTemps, isHwinfoAvailable, cpuCores)
  ToggleCpuFan(math.abs(showCpuFan - 1), isHwinfoAvailable, showLineGraph, showCpuClock)
  ToggleCpuClock(math.abs(showCpuClock - 1), isHwinfoAvailable, showLineGraph, showCpuFan)
  ToggleLineGraph(math.abs(showLineGraph - 1), showCpuFan, showCpuClock)
  ToggleAvgCpuGraph(math.abs(showAvgCpu - 1), showLineGraph)
  SetCpuName(cpuName)
  ToggleTtDetection(math.abs(showTt - 1))
  ToggleTtSound(math.abs(playTtSound - 1), showTt)

end

function SetDefaults()

  local isHwinfoAvailable = tonumber(SKIN:GetVariable('isHwinfoAvailable'))
  local cpuCores = tonumber(SKIN:GetVariable('cpuCores'))

  ToggleCpuName(0)
  TogglePage(1)
  ToggleCoreTemps(0, isHwinfoAvailable, cpuCores)
  ToggleCpuFan(0, isHwinfoAvailable, 1, 1)
  ToggleCpuClock(0, isHwinfoAvailable, 1, 1)
  ToggleLineGraph(0, 1, 1)
  ToggleAvgCpuGraph(1,1)
  SetCpuName('')
  ToggleTtDetection(0)
  ToggleTtSound(0, 1)

end

-- function to make logging messages less cluttered
function LogHelper(message, type)

  if isDbg == true then
    SKIN:Bang("!Log", message, type)
  elseif type ~= 'Debug' then
  	SKIN:Bang("!Log", message, type)
	end

end
