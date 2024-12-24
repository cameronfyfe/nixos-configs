Config { font = "xft:Bitstream Vera Sans Mono:size=10:antialias=true"
, bgColor = "#702963"
, alpha = 255
, fgColor = "grey"
, position = Top
, lowerOnStart = True
, commands =
    [ Run Date "%a %b %d %H:%M:%S" "date" 10
    , Run DynNetwork
      [ "--template" , "↑<tx>kB/s ↓<rx>kB/s"
      , "--Low"      , "1000" -- B/s
      , "--High"     , "5000" -- B/s
      , "--low"      , "green"
      , "--normal"   , "orange"
      , "--high"     , "red"
      ] 10
    , Run Cpu
      [ "--Low"      ,"5" -- %
      , "--High"     ,"50" -- %
      , "--normal"   ,"green"
      , "--high"     ,"red"
      ] 10
    , Run MultiCoreTemp
      [ "--template" , "Temp: <core0>°C"
      , "--Low"      , "70" -- °C
      , "--High"     , "80" -- °C
      , "--low"      , "green"
      , "--normal"   , "orange"
      , "--high"     , "red"
      ] 50
    , Run Memory
      [ "--template" ,"Mem: <usedratio>%"
      , "--Low"      , "20" -- %
      , "--High"     , "90" -- %
      , "--low"      , "green"
      , "--normal"   , "orange"
      , "--high"     , "red"
      ] 10
    , Run Battery
      [ "--template" , "<acstatus> - Bat: <left>%"
      , "--Low"      , "25"
      , "--High"     , "55"
      , "--low"      , "red"
      , "--normal"   , "yellow"
      , "--high"     , "green"
      , "--"
      , "-O"         , "AC"
      , "-o"         , "<timeleft>"
      ] 10
    , Run Com "/etc/nixos/machines/laptop/system/bluetooth/cmds.sh" [ "headphones_get_profile" ] "headphones" 10
    , Run Com "cat" ["/home/cameron/.timer/time"] "timer" 10
    ]
, sepChar = "%"
, alignSep = "}{"
, template = "%cpu% %multicoretemp% | %memory% | %dynnetwork%}{%headphones% | %timer% | <fc=#49E20E>%date%</fc> | %battery% "
}
