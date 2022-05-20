import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Hooks.EwmhDesktops

normalBorderColor = "#000000"
focusedBorderColor = "#702963"

startupHook = do
    spawn "~/.xmonad/xstart.sh"
    spawn "xmobar -x 0 ~/.xmonad/xmobar.hs"
    spawn "aw-start"
    spawnOn "w8" "spotify"
    spawnOn "w0" "codium /etc/nixos"

extraWorkspaces =
    [ (xK_1, "w1"), (xK_2, "w2"), (xK_3, "w3")
    , (xK_4, "w4"), (xK_5, "w5"), (xK_6, "w6")
    , (xK_7, "w7"), (xK_8, "w8"), (xK_9, "w9")
    , (xK_0, "w0")
    ]

workspaces =
    ["1","2","3","4","5","6","7","8","9"] ++ (map snd extraWorkspaces)

customKeys =
    -- Screensaver/Lock Screen
    [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    -- Screenshot (Current Monitor)
    , ((mod1Mask, xK_Print), spawn "cd scrot/window; scrot --focused")
    -- Screenshot (All Monitors)
    , ((mod1Mask .|. controlMask, xK_Print), spawn "cd scrot/multiscreen; scrot --multidisp")
    -- Screenshot (Drag / Select)
    , ((mod1Mask .|. shiftMask, xK_Print), spawn "cd scrot/select; scrot --select --freeze")
    -- Switch to extra workspace
    ] ++ [
        ((mod4Mask, key), (windows $ W.greedyView ws))
        | (key, ws) <- extraWorkspaces
    -- Send window to extra workspace
    ] ++ [
        ((mod4Mask .|. shiftMask, key), (windows $ W.shift ws))
        | (key, ws) <- extraWorkspaces
    ]

main :: IO ()
main = do
    xmonad $ docks . ewmhFullscreen . ewmh $ XMonad.def
        { XMonad.layoutHook = avoidStruts $ layoutHook XMonad.def
        , XMonad.startupHook = Main.startupHook
        , XMonad.manageHook = manageSpawn
        , XMonad.workspaces = Main.workspaces
        , XMonad.normalBorderColor = Main.normalBorderColor
        , XMonad.focusedBorderColor = Main.focusedBorderColor
        }
        `additionalKeys` customKeys
