" K. McCULLOCH VIMRC

""""""""""""
" PATHOGEN "
""""""""""""
" add .vim/bundle/* to runtimepath
call pathogen#infect()

"""""""""""
" OPTIONS "
"""""""""""
" use Vim (not Vi) option defaults
set nocompatible

" ignore search case when typing a lower-case search string
" note: This causes vimscript code to evaluate "foo" == "Foo" as true!
" http: //learnvimscriptthehardway.stevelosh.com/chapters/22.html
set ignorecase "causes foo to match foo, Foo, FOO
set smartcase "causes Foo only to match Foo

" other search options
set incsearch "see results while typing
set hlsearch "search matches are highlighted
set nowrapscan "keep searches from wrapping around the end of the file

" left-hand line numbering
set number "turn on left-hand numbering
set numberwidth=5 "use 5 spaces for left-hand number column

" tab bar at top of screen
"set showtabline=2 "always show tab bar

" status bar at bottom left of screen
set laststatus=2 "always show the status line
set statusline=%f "path to file, relative to directory where vim was launched
set statusline+=\ %y "filetype in brackets
set statusline+=%= "right justify rest of status line
set statusline+=%l/%L "current line/total lines
set noruler "statusline takes precedence over ruler
set notitle "prefer to have username@hostname in bash window title per default

" turn off the default backup/swapfile behavior
set nobackup 
set noswapfile 

" other options
set linebreak "wrap long lines rather than entering line breaks
set scrolloff=3 "scrolling offset of 3 lines at top/bottom
set timeout timeoutlen=3000 "set timeout gap for multi-key operations to 3 sec
set expandtab "use spaces instead of tab character
set tabstop=2 "tab stops calculated every 2 spaces
set shiftwidth=2 "number of spaces to use for each step of autoindent
set autoindent "copy indent from current line when starting a new line
set smartindent "autoindent automatically based on syntax
set history=1000 "increase command-line history from 20 to 1000
set shortmess=atI "shorten various system messages
set visualbell "use the visual bell instead of beeping

""""""""""""""""
" KEY MAPPINGS "
""""""""""""""""
" use the space bar as the mapleader key
nnoremap <Space> <Nop>
let mapleader = " "

" use the tab key for escape operations
" in normal mode, cancel any prefix keys (eg. # for count)
nnoremap <Tab> <Esc>
" in visual mode, cancel any selection (gV prevents automatic reselection)
vnoremap <Tab> <Esc>gV
" cancel any operator-pending command
onoremap <Tab> <Esc>
" exit insert mode and restore cursor position (no move left)
inoremap <Tab> <Esc>`^
" insert an actual-to-goodness tab when in insert mode
inoremap \<Tab> <Tab>
" turn off K (does a sudden help topic lookup that is distracting)
nnoremap K <Nop>

" require a leader stroke to use J to concatenate lines
nnoremap <Leader>J J
nnoremap J <Nop>

" a leader stroke followed by d/D deletes lines in confusing ways
nnoremap <Leader>d <Nop>
nnoremap <Leader>D <Nop>

" use the arrow keys to navigate between open tabs
"noremap <Leader><Left> :tabp<CR>
"noremap <leader><Right> :tabn<CR>
"noremap <Leader><Down> :tabnew<CR>
"noremap <Leader><Up> :tabm 0<CR>

" use u/U to make a word lower/upper case in normal mode
noremap <Leader>U vawgU
noremap <Leader>u vawgu

" use ctrl-u to make a word upper case in insert mode
inoremap <c-u> <esc>vawgUi

" clear previous search string
noremap <Leader><Space> :let<Space>@/<Space>=<Space>""<CR>

" always paste above
nnoremap p P

" always insert line above 
nnoremap o O

" enter insert mode ready to append to the end of a line
noremap <Leader>a $a

" enter insert mode ready to prepend to the start of a line
noremap <Leader>i ^i

" insert a single character at the cursor point
nnoremap <Leader>r i_<Esc>r

" open .vimrc in a new tab for editing 
" @TODO use buffer instead
"nnoremap <leader>ev :tabnew $MYVIMRC<CR>

" source .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" create a shortcut for adding a space before all opening brackets
" (useful for CSS format correction)
" http: //stackoverflow.com/questions/8405946/regex-to-insert-space-in-vim
nnoremap <leader>{ :%s/\(\S\){/\1 {/g<CR>

" create a shortcut for adding a space after all colons
" (useful for CSS format correction)
nnoremap <leader>: :%s/:\(\S\)/: \1/g<CR>

" when cursor is on word, use F10 to get info about syntax highlighting
noremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" make sure marks move us back to the specified location
nnoremap ' `
nnoremap ` '

" keep cursor from jumping over multiline rows
nnoremap j gj
nnoremap k gk

" multiples of ten
noremap <Leader>j 10j
noremap <Leader>k 10k
noremap <Leader>h 10h
noremap <Leader>l 10l

noremap J 5j
noremap K 5k
noremap H 5h
noremap L 5l

" up or down half a page, then center screen
noremap <Leader>f 24jzz
noremap <Leader>F 24kzz

"""""""""""""""""
" ABBREVIATIONS "
"""""""""""""""""
" rewrite :help to expand to :tab help (opens help topics in a new tab)
"cabbrev help tab help

"""""""""""
" PLUGINS "
"""""""""""
" source .vim/filetype.vim
filetype on
" source .vim/ftplugin
filetype plugin on
" source .vim/indent
filetype indent on
" source .vim/syntax
syntax on

"""""""""""""""""
" COLOR SCHEMES "
"""""""""""""""""
" solarized
" for this to look right, we must first set our terminal emulator's
" colorscheme to use the Solarized palette.
" http://ethanschoonover.com/solarized/vim-colors-solarized
"set background=dark
"set t_Co=16
"colorscheme solarized

" gruvbox
" note: see line 207 of gruvbox.vim for some custom overrides I've made
set background=dark
set t_Co=256
let g:gruvbox_italic=0
colorscheme gruvbox

"""""""""""""
" SHOWMARKS "
"""""""""""""
" .vim/bundle/ShowMarks
" Default keymappings are:
" <Leader>mt - Toggles ShowMarks on and off.
" <Leader>mo - Turns ShowMarks on, and displays marks.
" <Leader>mh - Clears a mark.
" <Leader>ma - Clears all marks.
" <Leader>mm - Places the next available mark.
hi ShowMarksHLl ctermfg=grey ctermbg=none
hi ShowMarksHLu ctermfg=grey ctermbg=none
hi ShowMarksHLo ctermfg=grey ctermbg=none
hi ShowMarksHLm ctermfg=grey ctermbg=none
let g:showmarks_enable=0
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"""""""""""
" VIMWIKI "
"""""""""""
" .vim/bundle/vimwiki
"let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
      "\'nested_syntaxes': {'php': 'php'}}]
"let g:vimwiki_table_mappings = 0
      "\'template_path': '~/Dropbox/vimwiki/template/',
      "\'template_default': 'default',
      "\'template_ext': '.html',
      "\'path_html': '~/Dropbox/github/vimwiki/'
"noremap <F4> : VimwikiAll2HTML<CR>

"""""""""""""""""""""
" RIGHT-SIDE MARGIN "
"""""""""""""""""""""
"see http: //vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"highlight ColorColumn ctermbg=233
"let &colorcolumn=join(range(81,999),",")

"""""""""""
" BUFFERS "
"""""""""""
set hidden
set confirm
set equalalways
set splitbelow
set splitright

nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <Leader>wj <c-w><c-j>
nnoremap <Leader>wk <c-w><c-k>
nnoremap <Leader>wl <c-w><c-l>
nnoremap <Leader>wh <c-w><c-h>
nnoremap <Leader>w= <c-w>=
noremap <Left> <c-w><c-h>
noremap <Right> <c-w><c-l>
noremap <Down> <c-w><c-j>
noremap <Up> <c-w><c-k>

let g:miniBufExplBuffersNeeded=0 "start automatically
let g:miniBufExplBRSplit=0 "put mini buffer on top

