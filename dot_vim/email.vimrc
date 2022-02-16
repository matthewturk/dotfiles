call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'cocopon/iceberg.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

call plug#end()

let mapleader = ','

set background=dark
"colorscheme xoria256
"colorscheme badwolf
colorscheme Monokai
"colorscheme spacecamp
"colorscheme spacecamp_lite
colorscheme iceberg

set backspace=indent,eol,start

set smartcase
set ignorecase

set backupdir=~/.vim/tmp/                   " for the backup files
set directory=~/.vim/tmp/                   " for the swap files

" Let's turn on some highlight searching

 set t_kb=
 set t_kD=[3~
 set hls
 set is
map <leader>H <Esc>:nohl<cr>

map <leader>oc :w !xclip<cr>
map <leader>op :r!xclip -o<cr>

" Turn on relative numbering, but make it easy to switch around

set number
set relativenumber
map <leader>rn :set invrelativenumber<CR>
map <leader>rN :set invnumber<CR>

map <silent>,h <C-w>h
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l

" Hate the beeping!
set visualbell

map <leader>ct "=strftime("%c")<CR>P
map <leader>cd "=strftime("%Y-%m-%d")<CR>P
"
map <C-o> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="v"

" Some nice globals.  Always tab 4 spaces.
set expandtab
set tabstop=4
set shiftwidth=4

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

