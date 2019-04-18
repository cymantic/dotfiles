let firstrun=0
if !filereadable(expand("~/.vim/autoload/plug.vim"))
  let firstrun=1
  silent !mkdir -p ~/.vim/{autoload,undo,backups}
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
" sensible defaults
Plug 'tpope/vim-sensible'

" determine indentation
Plug 'tpope/vim-sleuth'

" surround with...
Plug 'tpope/vim-surround'

" Auto close brackets on enter
Plug 'rstacruz/vim-closer'

" Repeat for plugins
Plug 'tpope/vim-repeat'

" nicer colours
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'

" file navigation
Plug 'ctrlpvim/ctrlp.vim'

" netrw enhanced
Plug 'tpope/vim-vinegar'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" nicer status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
" requires powerline fonts installed from https://github.com/powerline/fonts
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h12
   endif
endif

" syntax highlighting
Plug 'scrooloose/syntastic'

" markdown
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/SyntaxRange'

" Presentation
Plug 'sotte/presenting.vim'

" Clojure stuff
Plug 'tpope/vim-salve'
"Plug 'tpope/vim-projectionist'
"Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'luochen1990/rainbow'
"Plug 'rkneufeld/vim-boot'
Plug 'venantius/vim-cljfmt'
"Plug 'venantius/vim-eastwood'

" Rust stuff
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'
let g:rustfmt_autosave = 1

" Swift stuff
" Plug 'keith/swift.vim'
" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" Elm stuff
"Plug 'elmcast/elm-vim'

" Crystal stuff
"Plug 'rhysd/vim-crystal'

" Ruby stuff
"Plug 'vim-ruby/vim-ruby'

" JavaScript stuff
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" TypeScript stuff
Plug 'leafgarland/typescript-vim'

let g:vim_jsx_pretty_colorful_config = 1 " default 0

call plug#end()
if 1 == firstrun
  :PlugInstall
endif

" configure vim like, assume vim-sensible
set nocompatible
syntax on
filetype plugin indent on
set modelines=0

" my prefered Colour schemes
set background=dark
silent! colorscheme solarized
silent! colorscheme vividchalk

" my prefered tab settings (overridden by vim-sleuth)
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" handle make files needing tabs
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

"set swp file storate to local ~/tmp
set dir=~/tmp

" easy to hit commands by mapping ; to :
nnoremap ; :

" default leader is \
let mapleader = ","

" make search case insensitive, toggle highlighting Ctrl-L from vim-sensible
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" some simpler editing commands for insert mode
inoremap jk <ESC>
inoremap aa @
inoremap '' "
inoremap jj ->
inoremap kk =>
inoremap hh &
inoremap uu _
" inoremap ;; :=

" on lose focus, save/write all changed buffers
au FocusLost * silent! wa
" on change/switch buffer, save/write buffer
set autowrite

" Remove Trailing Whitespace
nnoremap <leader>rtw :%s/\s\+$//e<CR>

" Clojure stuff http://blog.venanti.us/clojure-vim/
" Working with CtrlP
let g:ctrlp_root_markers = ['build.boot']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Ignore file defined in .gitignore from Ctrl-P docs
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" hot reloading
au Filetype clojure nmap <c-c><c-k> :Require<cr>
" Rainbow Parans (Toggle with :RainbowToggle)
let g:rainbow_active = 0
" Format file with :Cljfmt

" Syntastic recommended by elm-vim
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:elm_syntastic_show_warnings = 1
