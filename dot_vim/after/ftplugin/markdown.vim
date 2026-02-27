" ~/.vim/after/ftplugin/markdown.vim

" 1. Slide Navigation (Jump between '---' separators)
" Go to next slide
nnoremap <buffer> ]] /^---$<CR>zz
" Go to previous slide
nnoremap <buffer> [[ ?^---$<CR>zz

" 2. Slide Selection Text Object ('as' = A Slide)
" 'is' = Inner Slide (Content only, no delimiters)
xdnoremap <buffer> is :<C-u>silent! ?^---$?+1<CR>V/^\(---$\)\\|\(\%$\)/-1<CR>
onoremap <buffer> is :<C-u>silent! ?^---$?+1<CR>V/^\(---$\)\\|\(\%$\)/-1<CR>

" 'as' = A Slide (Content + Delimiters)
xdnoremap <buffer> as :<C-u>silent! ?^---$?+0<CR>V/^\(---$\)\\|\(\%$\)/+0<CR>
onoremap <buffer> as :<C-u>silent! ?^---$?+0<CR>V/^\(---$\)\\|\(\%$\)/+0<CR>

" 3. Slide Movement (Move entire slide up/down)
" Move current slide DOWN
nnoremap <buffer> <LocalLeader>J das]]p
" Move current slide UP
nnoremap <buffer> <LocalLeader>K das[[P

" 4. Validation (Optional - checks if 'prairie_manager' is available first)
if executable('prairie_manager')
    nnoremap <buffer> <LocalLeader>v :!python -m prairie_manager.app --validate<CR>
endif
