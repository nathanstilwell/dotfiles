--
-- Shared functions
--
function resizeWindow(dw, dh, dx, dy)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.w = dw and max.w * dw or f.w
    f.h = dh and max.h * dh or f.h
    f.x = dx and max.x + (max.w * dx) or f.x
    f.y = dy and max.y + (max.h * dy) or f.y
    win:setFrame(f)
end

function fullScreenWindow(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end

function moveWindowToDisplay(d)
  return function ()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    win:moveToScreen(displays[d], false, true)
    fullScreenWindow(win)
  end
end

--
-- Window Movement in Monitor
--

hs.hotkey.bind({"cmd", "ctrl", "alt", "shift"}, "Up", function ()
  local win = hs.window.focusedWindow()
  fullScreenWindow(win)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Up", function ()
  resizeWindow(1.0, 0.5, 0, 0)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Down", function ()
  resizeWindow(1.0, 0.5, 0, 0.5)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Left", function ()
  resizeWindow(0.5)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Right", function ()
  resizeWindow(0.5, nil, 0.5)
end)

--
-- Move to Monitor
--

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "1", moveWindowToDisplay(1))
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "2", moveWindowToDisplay(2))
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "3", moveWindowToDisplay(3))

--
-- Focus Applications
--

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "B", function ()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "C", function ()
  hs.application.launchOrFocus("1Password")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "D", function ()
  hs.application.launchOrFocus("Google Chrome Canary")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "E", function ()
  hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "G", function ()
  hs.application.launchOrFocus("Figma")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "H", function ()
  hs.application.launchOrFocus("Hammerspoon")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "I", function ()
  -- No idea why this is necessary
  hs.application.launchOrFocusByBundleID("com.culturedcode.ThingsMac")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "L", function ()
  hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "M", function ()
  hs.application.launchOrFocus("Messages")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "N", function ()
  hs.application.launchOrFocus("Linear")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "P", function ()
  hs.application.launchOrFocus("Music")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "R", function ()
  hs.application.launchOrFocus("Arc")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "T", function ()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "W", function ()
  hs.application.launchOrFocus("WezTerm")
end)

-- Sleep Displays

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "7", function ()
  hs.execute("pmset displaysleepnow")
end)
