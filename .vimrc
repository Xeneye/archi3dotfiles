"  $$\   $$\                                                         $$\    $$\ $$\               
"  $$ |  $$ |                                                        $$ |   $$ |\__|              
"  \$$\ $$  | $$$$$$\  $$$$$$$\   $$$$$$\  $$\   $$\  $$$$$$\        $$ |   $$ |$$\ $$$$$$\$$$$\  
"   \$$$$  / $$  __$$\ $$  __$$\ $$  __$$\ $$ |  $$ |$$  __$$\       \$$\  $$  |$$ |$$  _$$  _$$\ 
"   $$  $$<  $$$$$$$$ |$$ |  $$ |$$$$$$$$ |$$ |  $$ |$$$$$$$$ |       \$$\$$  / $$ |$$ / $$ / $$ |
"  $$  /\$$\ $$   ____|$$ |  $$ |$$   ____|$$ |  $$ |$$   ____|        \$$$  /  $$ |$$ | $$ | $$ |
"  $$ /  $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$$\ \$$$$$$$ |\$$$$$$$\          \$  /   $$ |$$ | $$ | $$ |
"  \__|  \__| \_______|\__|  \__| \_______| \____$$ | \_______|          \_/    \__|\__| \__| \__|
"                                          $$\   $$ |                                             
"                                          \$$$$$$  |                                             
"                                           \______/                                              

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
  set ic
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" -- VIM PLUG Setup and LOAD --
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/forest-night'
call plug#end()

" Startup Settings
	set history=5001
	set nocompatible
	set number relativenumber
	colorscheme lucius 
	LuciusDark
	filetype plugin on
	syntax on
	set encoding=utf-8
	set wildmenu
	set wildmode=longest,list,full
	set laststatus=2
	if !has('gui_running')
	  set t_Co=256
	endif
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	set spell spelllang=en_gb
	hi Normal guibg=NONE ctermbg=NONE
" Key Maps
	map <C-o> :NERDTreeToggle<CR>
	map <C-\> :Goyo<CR>
	vnoremap <C-c> "+y
	nnoremap <F5> :UndotreeToggle<CR> :UndotreeFocus<CR>
" Persistent_undo
	if has("persistent_undo")
	    set undodir=$HOME"/.undodir"
	    set undofile
	endif
	let g:undotree_WindowLayout = 2

