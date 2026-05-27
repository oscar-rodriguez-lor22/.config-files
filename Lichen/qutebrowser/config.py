# Notes
## yank: tool for copying to clipboard without using the mouse, toggled by the `yf` keybinding
## hints: Tool for clicking on elements without using the mouse, toggled by `f` keybinding in normal mode
# Ideas to consider
## use mpv instead of running videos in the browser


# Browser Behavior
config.load_autoconfig(False) # Stops settings changed via the UI from loading
c.auto_save.session = True # Restores last session on open
c.content.blocking.enabled = True # Enables the built in adblocker
c.content.blocking.method = 'both' # Uses both the built in adblocker and the rust adblocker (required adblock python library be installed)
c.content.autoplay = False # Prevents autoplay
c.content.images = True # Allows images, turn to false for text only
c.content.canvas_reading = False # Prevents canvas fingerpringint
c.content.headers.do_not_track = True # Sends the "Do Not Track" header to websites
c.spellcheck.languages = ['en-US'] # Sets language for spellcheck
c.content.dns_prefetch = True # Preloads pages for faster navigation

# GUI
c.statusbar.show = 'in-mode' # Hides statusbar unless typing a command
# c.tabs.show = 'switching' # Tabs only shown while switching between them
c.completion.shrink = True # Shrinks the completion menu to fit only the results found

# Hints
c.hints.chars = "asdfghjkl" # Chars used in hints menu, best to keep these on the home row

# Search Shortcuts
c.url.searchengines = {
	#'shortcut': 'url'
}

# JavaScript Blacklist
config.set('content.javascript.enabled', True) # JS enabled globally
## Disableing JS for specific domains
with config.pattern('https://www.youtube.com/*') as p:
    p.content.javascript.enabled = False

with config.pattern('https://www.reddit.com/*') as p:
    p.content.javascript.enabled = False

with config.patter('https://www.x.com/*') as p:
   p.content.javascript.enabled = False

# Keybindings
## Syntax: config.bind('key', 'command')
## Be aware that these key bindings can collide with those of the OS.
## In cases that they do collide, the OS will win out in pretty much all casses.
## To prevent any collisions its best practice to preface all keybindings here with some leader key.
## Here I've chosen the "Leader" key ','
# utils
config.bind(',d', 'config-cycle colors.webpage.darkmode.enabled true false ;; reload') # Toggles dark mode on/off
config.bind(',p', 'config-cycle content.images true false') # Toggles images on/off
config.bind(',j', 'config-cycle -u {url} content.javascript.enabled True False ;; reload') # Toggles current URL whitelist
# Homepage Links
config.bind(',gh', 'open https://github.com')
# Hints
# Yank
# Cheat Sheet
config.bind(',?', 'message-info "GH: ,gh | Dark: ,d | Img: ,p | Tabs: J/K | Hist: H/L | New Tab: open -t | Clone Tab: tab-clone | Close Tab: tab-close | Reopen Closed Tab: undo | Copy Current Page URL: yD"')
