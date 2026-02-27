" ~/.vim/after/ftplugin/markdown.vim

" 1. Slide Navigation (Jump between '---' separators)
" Go to next slide
nnoremap <buffer> ]] /^---$<CR>zz
" Go to previous slide
nnoremap <buffer> [[ ?^---$<CR>zz

" 2. Slide Selection Text Object ('as' = A Slide)
" Usage: 'das' (delete slide), 'vas' (select slide), 'yas' (yank slide)
xnoremap <buffer> as :<C-u>silent! ?^---$?+1<CR>V/^\(---$\)\\|\(\%$\)/-1<CR>
onoremap <buffer> as :<C-u>silent! ?^---$?+1<CR>V/^\(---$\)\\|\(\%$\)/-1<CR>

" 3. Slide Movement (Move entire slide up/down)
" Move current slide DOWN
nnoremap <buffer> <LocalLeader>J das]]p
" Move current slide UP
nnoremap <buffer> <LocalLeader>K das[[P

" 4. Validation (Optional - checks if 'prairie_manager' is available first)
if executable('prairie_manager')
    nnoremap <buffer> <LocalLeader>v :!python -m prairie_manager.app --validate<CR>
endif
