  -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit
import qualified XMonad.StackSet as W
import           System.Exit                         (exitSuccess)
import           System.IO                           (hPutStrLn)

    -- Actions
import XMonad.Actions.Minimize
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.SpawnOn
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import qualified XMonad.Layout.BoringWindows         as BW
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Minimize

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2

myModMask       = mod4Mask

myNormalBorderColor  = "#828282"
myFocusedBorderColor = "#5FB462"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom &"
  spawnOnce "emacs --daemon"
  spawnOnce "feh --bg-scale ~/Pictures/wallpapers/0003.jpg  &"

------------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
    -- Alacritty
    ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- Launcher
    , ((modm, xK_Return), spawn "rofi -show run")
    -- Emacs client
    , ((modm, xK_e), spawn "emacsclient --create-frame")
    -- Brave
    , ((modm, xK_c), spawn "brave")
    -- Settings
    , ((modm, xK_v), spawn "systemsettings5")
    -- Lock screen
    , ((modm, xK_x), spawn "i3lock-fancy-rapid 30 3")
    -- Close app (except MS Teams)
    , ((modm,  xK_q), kill)
    -- Cycle layouts
    , ((modm, xK_space), sendMessage NextLayout)
    -- Back to center
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Easy layout switcher
    , ((modm .|. controlMask, xK_Tab), spawn "layout")
    -- Resize viewed windows to the correct size
    , ((modm, xK_n), refresh)
    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)
    -- Move focus to the next window
    , ((modm, xK_j), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm, xK_k), windows W.focusUp )
    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown)
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp)
    -- Shrink the master area
    , ((modm, xK_h), sendMessage Shrink)
    -- Expand the master area
    , ((modm, xK_l), sendMessage Expand)
    -- Push window back into tiling
    , ((modm, xK_t), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm, xK_comma), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))
    -- Toggle struts -> disable bar / overwrite bar in fullscreen.
    , ((modm, xK_b), sendMessage ToggleStruts)
    -- Multi media stuff
    , ((modm, xK_F1), spawn "amixer -q set Master toggle")
    , ((modm, xK_F2), spawn "amixer -q sset Master 5%-")
    , ((modm, xK_F3), spawn "amixer -q sset Master 5%+")
    , ((modm, xK_F4), spawn "xbacklight -dec 5")
    , ((modm, xK_F5), spawn "xbacklight -inc 5")
  ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [1..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myWorkspaces :: [String]
myWorkspaces = ["emacs", "sys", "web", "doc", "src", "org", "mus", "vid", "com"]

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] 

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices
  
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

spirals  = renamed [Replace "spirals"]
           $ minimize . BW.boringWindows
           $ windowNavigation
           $ mySpacing 6
           $ spiral (2/2)
monocle  = renamed [Replace "monocle"]
           $ minimize . BW.boringWindows
           $ limitWindows 12 Full
center = renamed [Replace "center"]
           $ minimize . BW.boringWindows
           $ mySpacing 6
           $ limitWindows 5
           $ ThreeColMid 1 (1/100) (1/2)
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout = withBorder myBorderWidth center
                                 ||| spirals
                                 ||| noBorders monocle


myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , isFullscreen --> doCenterFloat
     ]

main :: IO ()
main = do
  xmobar <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
  xmonad $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = docksEventHook <+> fullscreenEventHook,
        startupHook        = myStartupHook,
        logHook =  dynamicLogWithPP $ xmobarPP
          { ppOutput = \x -> hPutStrLn xmobar x
          , ppCurrent = xmobarColor "#6A3DBD" "" . wrap "<box type=Bottom width=2 mb=2 color=#6A3BDB>" "</box>"
          , ppVisible = xmobarColor "#6A3DBD" "" . clickable
          , ppHidden = xmobarColor "#6C7BC6" "" . wrap "<box type=Top width=2 mt=2 color=#6C5BC6>" "</box>" . clickable
          , ppHiddenNoWindows = xmobarColor "#6C7BC6" ""  . clickable 
          , ppTitle = xmobarColor "#C34737" "" . shorten 60               
          , ppSep =  "<fc=#23272A>  </fc>"                    
          , ppUrgent = xmobarColor "#C34737" "" . wrap "!" "!"            
          , ppExtras  = [windowCount]
          , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
          }
      }

