 
  import XMonad
  import System.Exit
  
  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.ManageDocks
  import XMonad.Hooks.ManageHelpers
  import XMonad.Hooks.StatusBar
  import XMonad.Hooks.StatusBar.PP

  import XMonad.Util.EZConfig
  import XMonad.Util.Loggers
  import XMonad.Util.Ungrab

  import XMonad.Layout.Magnifier
  import XMonad.Layout.ThreeColumns
  import XMonad.Layout.NoBorders
  import XMonad.Hooks.EwmhDesktops

  import qualified XMonad.StackSet as W
  import qualified Data.Map        as M

  main :: IO ()
  main = xmonad
       . ewmhFullscreen
       . ewmh
       . withEasySB (statusBarProp "xmobar $HOME/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
       $ myConfig

  myConfig = def
      { modMask    = mod4Mask      -- Rebind Mod to the Super key
      , layoutHook = smartBorders myLayout      -- Use custom layouts
      , manageHook = myManageHook  -- Match on certain windows
      , focusedBorderColor = "#d98324"
      }
    `additionalKeysP`
      [ ("M-S-z"        , spawn "xscreensaver-command -lock"                    )
      , ("M-S-="        , unGrab *> spawn "scrot -s"                            )
      , ("M-w"          , spawn "firefox"                                       )
      , ("M-t"          , spawn "kitty"                                         )
      , ("M-S-<Return>" , spawn "kitty"                                       )
      , ("M-d"          , spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
      , ("M-S-q"        , kill                                                  )
      , ("M-<Return>"   , windows W.swapMaster                                  )
      , ("M-j"          , windows W.focusDown                                   )
      , ("M-k"          , windows W.focusUp                                     )
      , ("M-S-r"        , spawn "xmonad --recompile; xmonad --restart"          )
      , ("M-S-<Esc>"    , io (exitWith ExitSuccess)                             )
      , ("M-S-t"        , withFocused $ windows . W.sink                        )
      , ("M-<L>"        , spawn "amixer set Master toggle"                      )
      , ("M-<D>"        , spawn "amixer set Master 1%- unmute"                  )
      , ("M-<U>"        , spawn "amixer set Master 1%+ unmute"                  )
      , ("M-e"          , spawn "kitty lf"                                      )
      ]

  myManageHook :: ManageHook
  myManageHook = composeAll
      [ isDialog            --> doFloat ]

  myLayout = tiled ||| Full -- ||| Mirror tiled 
    where
      tiled    = Tall nmaster delta ratio
      nmaster  = 1      -- Default number of windows in the master pane
      ratio    = 1/2    -- Default proportion of screen occupied by master pane
      delta    = 3/100  -- Percent of screen to increment by when resizing panes

  myXmobarPP :: PP
  myXmobarPP = def
      { ppSep             = magenta " • "
      , ppTitleSanitize   = xmobarStrip
      , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
      , ppHidden          = white . wrap " " ""
      , ppHiddenNoWindows = lowWhite . wrap " " ""
      , ppUrgent          = red . wrap (yellow "!") (yellow "!")
      , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
      , ppExtras          = [logTitles formatFocused formatUnfocused]
      }
    where
      formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
      formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

      -- | Windows should have *some* title, which should not not exceed a
      -- sane length.
      ppWindow :: String -> String
      ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

      blue, lowWhite, magenta, red, white, yellow :: String -> String
      magenta  = xmobarColor "#ff79c6" ""
      blue     = xmobarColor "#bd93f9" ""
      white    = xmobarColor "#f8f8f2" ""
      yellow   = xmobarColor "#f1fa8c" ""
      red      = xmobarColor "#ff5555" ""
      lowWhite = xmobarColor "#bbbbbb" ""