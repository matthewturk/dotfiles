exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

set clipboard=unnamed

" Emulate Folding https://vimhelp.org/fold.txt.html#fold-commands

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall

exmap foldall obcommand editor:fold-all
nmap zM :foldall

exmap currentdate obcommand insert-current-date
map \cd :currentdate

exmap currenttime obcommand insert-current-time
map \ct :currenttime

exmap themedark obcommand theme:use-dark 
map \td :themedark

exmap themelight obcommand theme:use-light 
map \tl :themelight

exmap blockquote obcommand editor:toggle-blockquote
map \bq :blockquote

exmap runblocks obcommand execute-code:run-all-code-blocks-in-file
map \ex :runblocks

exmap splithorizontal obcommand workspace:split-horizontal
exmap sp splithorizontal
map \sp :splithorizontal

exmap splitvertical obcommand workspace:split-vertical
exmap vs splitvertical
map \vs :splitvertical

exmap movetonewwindow obcommand workspace:move-to-new-window
exmap ! movetonewwindow
map \! :movetonewwindow

exmap switcher obcommand switcher:open
map ; :switcher

" A few ways to improve usability on my laptop keyboard
exmap tabnext obcommand workspace:next-tab
map gt :tabnext

exmap tabprev obcommand workspace:previous-tab
map gT :tabprev

map <A-p> :pasteinto

map \ssc :%s/[‘’]/'/g

exmap close obcommand workspace:close
