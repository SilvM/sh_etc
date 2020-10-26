set nocp
" display the pressed commands in bottom right
set showcmd
syntax on
set number
set hls
" Disable hls on Enter hit
nnoremap <CR> :set noh<CR>

"call plug#begin('C:\Users\Silv\vimfiles\autoload\plug.vim')
call plug#begin('~/.vim/plugged/')
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
call plug#end()

" Toggle hls on Enter hit
nnoremap <CR> :set hlsearch!<CR>

" Ale shortcuts move between errors. CTRL H or L
map <silent> <C-h> <Plug>(ale_previous_wrap)
map <silent> <C-l> <Plug>(ale_next_wrap)
" Note Ale line length configured in actual linter (e.g. for Python it's in ~/.config/flake8
" Ale tie with Airline Status line
let g:airline#extensions#ale#enabled=1
" Format of message at the bottom
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" THEME
" Footer theme
let g:airline_theme='soda'
" ayu_mirage
" monochrome
" base16_isotope
"let g:airline_theme='base16_isotope'
" All gruvbox settings come before colorscheme command https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark
" Changes theme to dark
set background=dark
" disable italics comments
let g:gruvbox_italicize_comments=0
colorscheme gruvbox

" Stupid mistakes repaired
:command WQ wq
:command Wq wq
:command Q q
:command QA qa
:command W w

" SEARCH
" Ignore case when searching
set ignorecase
" Start searching as soon as I type; search case insensitive until you see capital letter
set incsearch smartcase

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guifont=Ubuntu\ Mono:h15
    set encoding=utf-8
    set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
endif

"Show Brackets
set showmatch

" Turn backup off, since most stuff is in git etc anyway...
set nobackup nowb noswapfile
set undodir=~/.vim/undodir/
set undofile
" Disable middle click pasting
imap <MiddleMouse> <Nop>
map <MiddleMouse> <Nop>

" Reselect visual block after indentation
vnoremap < <gv
vnoremap > >gv

" Tab related
set smarttab expandtab " Use spaces instead of tabs & Be smart when using tabs ;)
" 1 tab == 4 spaces
set shiftwidth=4 tabstop=4 softtabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Move a line of text using ALT+[jk]
nmap <C-J> mz:m+<cr>`z
nmap <C-K> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Vim 7+ tab shortcuts to use ctrl+tab
nmap <F1> <C-w>gf
nmap <C-Tab> :tabn<cr>
nmap <C-S-Tab> :tabp<cr>
" Split config
set splitbelow
set splitright
" Split navigation
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Folding
set foldmethod=indent
set foldlevel=99
" Map fold toggle to Space
nnoremap <space> za

"" github.com/mcantor/no_plugins
set path=** " make search in :find recursive from current position
set wildmenu " add menu with options for command mode

" add file browser and network functionalities
"if version >= 600
"    filetype plugin indent on
"    " Start it at when vim is called alone :
"    augroup VimStartup
"      au!
"      au VimEnter * if expand("%") == "" | e . | endif
"    augroup END
"endif

" Options for netrw
"let g:netrw_browse_split=2  " open in prior window
"let g:netrw_altv=1          " open splits to the right
let g:netrw_keepdir = 0     " cd everytime we navigate around
let g:netrw_banner = 0      " hide banner
let g:netrw_liststyle = 1   " list with details
let g:netrw_winsize = 80    " when opening with v, give more space to it than netrw

"augroup ProjectDrawer
"      autocmd!
"        autocmd VimEnter * :Vexplore
"    augroup END

"" Templates
" header for scripts
nnoremap ,head :-1r$HOME/scripts/vim/templates/head<CR>A

" Mark whitespaces red (probably)
highlight UnwanttedTab ctermbg=red guibg=darkred
highlight TrailSpace guibg=red ctermbg=darkred
match UnwanttedTab /\t/
match TrailSpace / \+$/

autocmd ColorScheme * highlight UnwanttedTab ctermbg=red guibg=darkred
autocmd ColorScheme * highlight TrailSpace guibg=red ctermbg=darkred

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Vim sessions config
let g:session_dir = '~/.vim/sessions'
" Speed up ctrl+p by disabling cache
let g:ctrlp_use_caching =0

" Disable bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Reason why ^O takes seconds to return when hitting Esc. Affects only terminal
set timeout timeoutlen=5000 ttimeoutlen=100

" What I might want in the future:
" wrap lines by breaking at spaces not midword
" set linebreak
" Load matchit.vim, default plugin to match with % more than brackets
packadd! matchit

"Leader commands
map <Leader>j :.!jq .<Enter>
map <Leader>J :%!jq .<Enter>
map <Leader>n :s/\\\\n/\r/g<Enter>:s/\\n/\r/g<Enter>
map <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
