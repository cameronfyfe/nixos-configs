module CameronXMonad (runXMonad) where

import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeys)
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Hooks.EwmhDesktops
import Colors

-- import XMonad.Hooks.StatusBar
-- import XMonad.Hooks.StatusBar.PP

-- xmobarTop    = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 0 ~/.config/xmobar/xmobar_top_primary.hs"    (pure ppTop)
-- xmobarBottom = statusBarPropTo "_XMONAD_LOG_2" "xmobar -x 0 ~/.config/xmobar/xmobar_top_primary.hs" (pure ppBottom)
-- xmobar1      = statusBarPropTo "_XMONAD_LOG_3" "xmobar -x 1 ~/.config/xmobar/xmobar_top_primary.hs"       (pure pp1)

-- barSpawner :: ScreenId -> IO StatusBarConfig
-- barSpawner 0 = pure $ xmobarTop
-- -- barSpawner 0 = pure $ xmobarTop <> xmobarBottom -- two bars on the main screen
-- barSpawner 1 = pure $ xmobar1
-- barSpawner _ = mempty -- nothing on the rest of the screens

startupHook = do
    spawn "mkdir -p scrot/window"
    spawn "mkdir -p scrot/multiscreen"
    spawn "mkdir -p scrot/select"
    spawn "xscreensaver --no-splash"
    spawn "aw-start"
    spawnOn "w8" "spotify"
    spawnOn "w0" "codium /etc/nixos"
    spawnOn "w0" "xterm -e \"cd /etc/nixos\""

workspaceMap =
    (map (\(key, ws) -> (mod1Mask, key, ws))
        [ (xK_1, "1"), (xK_2, "2"), (xK_3, "3")
        , (xK_4, "4"), (xK_5, "5"), (xK_6, "6")
        , (xK_7, "7"), (xK_8, "8"), (xK_9, "9")
        , (xK_0, "0")
        ]
    ) ++
    (map (\(key, ws) -> (mod4Mask, key, ws))
        [ (xK_1, "w1"), (xK_2, "w2"), (xK_3, "w3")
        , (xK_4, "w4"), (xK_5, "w5"), (xK_6, "w6")
        , (xK_7, "w7"), (xK_8, "w8"), (xK_9, "w9")
        , (xK_0, "w0")
        ]
    )

workspaces =
    map (\(_, _, ws) -> ws) workspaceMap

btHeadphonesCmd cmd = do
    spawn $ "/etc/nixos/machines/laptop/system/bluetooth/cmds.sh headphones_" ++ cmd

vscodeCmd cmd = do
    spawn $ "/etc/nixos/machines/laptop/apps/vscode/cmds.sh " ++ cmd

customKeys =
    -- Show XMonad custom keys
    [ ((mod1Mask .|. controlMask, xK_k), spawn "showXMonadKeys")

    -- Restart xmonad
    , ((mod1Mask, xK_q), restart "xmonad" True)
    -- Display status bar
    , ((mod1Mask .|. controlMask, xK_s), spawn "xmobar-start 0")
    -- Hide status bar
    , ((mod1Mask .|. controlMask, xK_d), spawn "xmobar-stop")
    
    -- Disconnect bluetooth headphones
    , ((mod1Mask .|. controlMask, xK_q), btHeadphonesCmd "disconnect")
    -- Connect bluetooth headphones
    , ((mod1Mask .|. controlMask, xK_w), btHeadphonesCmd "connect")
    -- Set bluetooth headphones to A2DP
    , ((mod1Mask .|. controlMask, xK_e), btHeadphonesCmd "set_a2dp")
    -- Set bluetooth headphones to HFP
    , ((mod1Mask .|. controlMask, xK_r), btHeadphonesCmd "set_hfp")

    -- Vscode: enable rust inlays
    , ((mod1Mask .|. shiftMask, xK_i), vscodeCmd "rust_inlays_enable")
    -- Vscode: disable rust inlays
    , ((mod1Mask .|. shiftMask, xK_o), vscodeCmd "rust_inlays_disable")

    -- Screensaver/Lock Screen
    , ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    -- Screenshot (Current Monitor)
    , ((mod1Mask, xK_Print), spawn "cd scrot/window; scrot --focused")
    -- Screenshot (All Monitors)
    , ((mod1Mask .|. controlMask, xK_Print), spawn "cd scrot/multiscreen; scrot --multidisp")
    -- Screenshot (Drag / Select)
    , ((mod1Mask .|. shiftMask, xK_Print), spawn "cd scrot/select; scrot --select --freeze")
    
    -- Switch to extra workspace
    ] ++ [
        ((modKey, key), (windows $ W.greedyView ws))
        | (modKey, key, ws) <- workspaceMap
    -- Send window to extra workspace
    ] ++ [
        ((modKey .|. shiftMask, key), (windows $ W.shift ws))
        | (modKey, key, ws) <- workspaceMap
    ]
-- customKeysEnd

config = 
    -- dynamicSBs barSpawner (
    XMonad.def
        { XMonad.layoutHook = avoidStruts $ layoutHook XMonad.def
        , XMonad.startupHook = CameronXMonad.startupHook
        , XMonad.manageHook = manageSpawn
        , XMonad.workspaces = CameronXMonad.workspaces
        , XMonad.normalBorderColor = Colors.normalBorderColor
        , XMonad.focusedBorderColor = Colors.focusedBorderColor
        }
        `additionalKeys` customKeys
    -- )

runXMonad = getDirectories >>= launch CameronXMonad.config
