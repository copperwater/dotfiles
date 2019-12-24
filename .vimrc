"" GENERAL SETTINGS

" backspace over autoindent, line breaks, start of insert
set bs=2

" paste mode
set pastetoggle=<F2>

" make it see tab characters as 8 spaces
set tabstop=8
" make the default indent level 2 spaces
set shiftwidth=2
" make softtabstop always take the value of shiftwidth by setting it negative
set softtabstop=-1
" make indenting commands snap to multiples of <shiftwidth> spaces
set shiftround
" make pressing the tab key insert <shiftwidth> spaces instead of a literal tab
set expandtab
" make backspacing go back to a multiple of <shiftwidth> spaces instead of 1
set smarttab

" bind Ctrl-N to :nohlsearch (turn off search match highlight) command
noremap <C-n> :nohlsearch<CR>
vnoremap <C-n> :nohlsearch<CR>

" make multiple levels of indenting easier by keeping the same text selected after doing a < or >
vnoremap > >gv
vnoremap < <gv

" autocomplete parens when typed
" inoremap ( ()<Esc>i

" bind Ctrl-H, Ctrl-J, Ctrl-K, Ctrl-L to move between windows rather than Ctrl-W + [hjkl]
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" a bunch of mappings will be set with comma as an initial step
" set up comma as the map leader
let mapleader = ","

" bind tab commands to ,q ,e ,t
" map <Leader>q <esc>:tabprevious<CR>
map <Leader>e <esc>:tabprevious<CR>
map <Leader>r <esc>:tabnext<CR>
map <Leader>t <esc>:tabnew<CR>

" bind save to ,s
map <Leader>s <esc>:update<CR>

" bind :quit to ,q
noremap <Leader>q :quit<CR>
" and bind :quitall to ,Q
noremap <Leader>Q :quitall<CR>

" bind w to "write"
nnoremap w :w<CR>

" highlight syntax
syntax on

" disable normal backups (created by writing to an existing file)
set nobackup
" disable swap file
set noswapfile
" don't make backups before overwriting a file
set nowritebackup

" auto-indent new lines to same indentation as old lines
set autoindent

" don't set in-editor newlines (lines can go off the right of the screen)
set nowrap

" Highlight search results
set hlsearch

" Search incrementally; ie find next match as the search input is changed
set incsearch

" Automatically read files when they are changed by something besides Vim
" (i.e. Git)
set autoread

" Enable wildmenu (vim command line completion for files and commands)
set wildmenu
" In wildmenu, ignore certain file types that never get edited
set wildignore=*.o,*~,*.pyc,*.git/*

" Ignore case when searching
set ignorecase
" but override that when the search pattern contains uppercase chars
set smartcase

" don't redraw when executing a macro
set lazyredraw

" Function for deleting trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" Delete trailing white space when saving a buffer
autocmd BufWrite * :call DeleteTrailingWS()

" enable filetype detection
filetype on
filetype plugin on
" indent based on file type
filetype indent on

""" FILETYPE SPECIFIC SETTINGS
" Handlebars HTML template files: Set .hbs files to html mode
autocmd BufReadPost *.hbs set filetype=html
" Template Toolkit output: is HTML plus extensions, also set to html
autocmd BufNewFile,BufReadPost *.tt set filetype=html
" ChucK music programming language: Set .ck files to chuck mode
autocmd BufReadPost *.ck set filetype=ck
" Comma separated or tab separated values: Set .csv files to CSV mode
" does having both BufNewFile, BufReadPost work?
autocmd BufNewFile,BufReadPost *.csv set filetype=csv
" To avoid having to make a copy of csv.vim as tsv.vim and just add a few commands to it,
" stick them here instead.
autocmd BufNewFile,BufReadPost *.tsv set filetype=csv | set shiftwidth=0 | set noexpandtab
" For some reason this requires its own line.
autocmd BufNewFile,BufReadPost *.tsv Delimiter \t
" Different indent levels
" Uncomment if there is a problem with any of these file types
" autocmd FileType javascript set shiftwidth=2
" autocmd FileType html set shiftwidth=2
" autocmd filetype c set shiftwidth=2
" autocmd filetype cpp set shiftwidth=2
autocmd FileType css set shiftwidth=4
" autocmd FileType cucumber set shiftwidth=2
" autocmd FileType ruby set shiftwidth=2


""" POWERLINE

" set runtime path to include powerline
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
"set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
"set t_Co=256


""" VUNDLE
" NOTE: If you just downloaded this vimrc, plugins will not be installed.
" Run :PluginInstall or see documentation at github.com/VundleVim/Vundle.vim

" required settings for vundle
set nocompatible
filetype off

" set runtime path to include vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim

" start vundle
call vundle#begin()

" required plugin is Vundle itself, must be first
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'christoomey/vim-tmux-navigator'

" Plugins to look into
" gmarik/Vundle.vim
" scrooloose/nerdtree
" scrooloose/nerdcommenter
" Valloric/YouCompleteMe
" tomtom/tcomment_vim
" jistr/vim-nerdtree-tabs
" nathanaelkane/vim-indent-guides

" stop vundle
call vundle#end()

" bind tcomment behavior to period
vnoremap . :TComment<CR>

""" MORE GENERAL SETTINGS THAT HAVE TO GO AFTER VUNDLE

" set filetype again
filetype on
" use filetype plugins and filetype specific indentation
filetype plugin indent on

" formatoptions is set to defaults by setting nocompatible, so changes to that have to go here
" formatoptions help: ":help fo-table" or ":help fo"
" Don't autowrap text
set fo-=t
" Don't autowrap comments
set fo-=c
" Do insert comment leader when hitting Enter in insert mode
set fo+=r
" Do insert comment leader when hitting o or O on a comment line in normal mode
set fo+=o

" Helpful notes
" Format XML and CSV: :%!xmllint --format -  :%!column -s, -t
