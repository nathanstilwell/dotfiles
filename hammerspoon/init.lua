-- Shared functions
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

-- Window Movement in Monitor
hs.hotkey.bind({"cmd", "ctrl", "alt", "shift"}, "Up", function ()
  local win = hs.window.focusedWindow()
  fullScreenWindow(win)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Up", function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Down", function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Left", function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "Right", function ()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move to Monitor

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "1", moveWindowToDisplay(1))
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "2", moveWindowToDisplay(2))
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "3", moveWindowToDisplay(3))

-- Focus Applications
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "B", function ()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "C", function ()
  hs.application.launchOrFocus("1Password")
end)

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "E", function ()
  hs.application.launchOrFocus("Visual Studio Code")
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

