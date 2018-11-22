set nocp
" display the pressed commands in bottom right
set showcmd
syntax on
set number
colorscheme murphy
set hls
" Disable hls on Enter hit
nnoremap <CR> :set hlsearch!<CR>


" Vundle config
filetype off                  " required
" let Vundle manage Vundle, required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" --> Keep Plugin commands between vundle#begin/end.
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Bundle 'Rykka/riv.vim'
Bundle 'Rykka/InstantRst'
Plugin 'elzr/vim-json'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'

" <-- End of plugin declaration
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" dark backround is gth on Ubuntu console
"set background=dark

" Stupid mistakes repaired
:command WQ wq
:command Wq wq
:command Q q
:command W w

" Makes search act like search in modern browsers
set incsearch

" Ignore case when searching
" set ignorecase

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guifont=Ubuntu\ Mono:h13
    colorscheme desert
endif

"Show Brackets
set showmatch

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" Reselect visual block after indentation
vnoremap < <gv
vnoremap > >gv

" Tab related
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Vim 7+ tab shortcuts
nmap <F1> <C-w>gf
nmap <F2> :tabp<cr>
nmap <F3> :tabn<cr>

" Split config
set splitbelow
set splitright

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Folding
set foldmethod=indent
set foldlevel=99
" Map fold toggle to Space
nnoremap <space> za

"" github.com/mcantor/no_plugins
" make search in :find recursive from current position
set path+=**
" add menu with options for command mode
set wildmenu
" add file browser and network functionalities
if version >= 600
    filetype plugin indent on
    " Start it at when vim is called alone :
    augroup VimStartup
      au!
      au VimEnter * if expand("%") == "" | e . | endif
    augroup END

"    " Options for netrw
"    let g:netrw_browse_split=3  " open in prior window
"    let g:netrw_altv=1          " open splits to the right
"    let g:netrw_liststyle=3     " tree view
"    let g:netrw_list_hide=netrw_gitignore#Hide()
"    let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
"    let g:netrw_preview=1       " Vertical splitting for previewing files

"augroup ProjectDrawer
"      autocmd!
"        autocmd VimEnter * :Vexplore
"    augroup END
endif

"" Templates
" header for scripts
nnoremap ,head :-1r$HOME/scripts/vim/templates/head<CR>A

" Mark whitespaces red (probably(
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
