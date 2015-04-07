" K. McCULLOCH VIMRC
" vim: foldmethod=marker
" to inspect local environment:
" http://vim.wikia.com/wiki/Displaying_the_current_Vim_environment

" OPTIONS ================================================================== {{{

set nocompatible "use Vim (not Vi) option defaults

filetype on "source .vim/filetype.vim
filetype plugin on "source .vim/ftplugin
filetype indent on "source .vim/indent
syntax on "source .vim/syntax

set nobackup "do not make a backup before overwriting a file
set noswapfile "do not use a swapfile for the buffer
set shortmess=atI "shorten various system messages
set visualbell "use the visual bell instead of beeping
set history=1000 "increase command-line history from 20 to 1000
set scrolloff=3 "scrolling offset of 3 lines at top/bottom
set timeout timeoutlen=3000 "set timeout gap for multi-key operations to 3 sec
set showcmd "show partial command in last line of the screen

" ignore search case when typing a lower-case search string
" note: This causes vimscript code to evaluate "foo" == "Foo" as true!
" http: //learnvimscriptthehardway.stevelosh.com/chapters/22.html
set ignorecase "causes foo to match foo, Foo, FOO
set smartcase "causes Foo only to match Foo
set incsearch "see results while typing
set hlsearch "search matches are highlighted
set nowrapscan "keep searches from wrapping around the end of the file

"set hidden "keep buffers loaded when they are abandoned
set nohidden
set confirm "prompt for save before unloading a modified buffer

set laststatus=2 "always show the status line

set statusline=%n: "buffer number
"set statusline+=%f "path to file, relative to directory where vim was launched
set statusline+=%t "filename only
set statusline+=%m "modified flag
set statusline+=\ %y "filetype in brackets
set statusline+=%= "right justify rest of status line
set statusline+=%l/%L "current line/total lines
set statusline+=\ %c "column number

set noruler "statusline takes precedence over ruler
set notitle "prefer to have username@hostname in bash window title per default

set number "turn on left-hand numbering
set numberwidth=5 "use 5 spaces for left-hand number column

set expandtab "use spaces instead of tab character
set tabstop=2 "tab stops calculated every 2 spaces

set autoindent "copy indent from current line when starting a new line
set smartindent "autoindent automatically based on syntax
set shiftwidth=2 "number of spaces to use for each step of autoindent

set linebreak "wrap long lines rather than entering line breaks

" this doesn't seem to work
set switchbuf=useopen "buffer exists in open window, jump there

set modeline
set modelines=5

" }}}
" NORMAL MODE MAPPINGS ===================================================== {{{

" use the space bar as the mapleader key
"nnoremap <Space> <Nop>
"let mapleader = " "
map <Space> <Leader>

" use the tab key for escape operations, such as cancelling prefix keys
" (eg. # for count)
nnoremap <tab> <Esc>

" make sure marks move us back to the specified location
nnoremap ' `

" reverse paste/insert line to default to above for lowercase p/o
nnoremap p P
nnoremap P p
nnoremap o O
nnoremap O o

" keep cursor from jumping over multiline rows
nnoremap j gj
nnoremap k gk

" use the shift key to enhance movement
nnoremap J 5j
nnoremap K 5k
nnoremap H 10h
nnoremap L 10l

" move up or down half a page, then center screen
nnoremap <Leader>f 24jzz
nnoremap <Leader>F 24kzz

" require a leader stroke to use J to concatenate lines
nnoremap <Leader>J J

" a leader stroke followed by d/D deletes lines in confusing ways
nnoremap <Leader>d <Nop>
nnoremap <Leader>D <Nop>

" use u/U to make a word lower/upper case
nnoremap <Leader>U vawgU
nnoremap <Leader>u vawgu

" clear previous search string
nnoremap <Leader><Space> :let<Space>@/<Space>=<Space>""<CR>

" enter insert mode ready to append to the end of a line
nnoremap <Leader>a $a

" enter insert mode ready to prepend to the start of a line
nnoremap <Leader>i ^i

" insert a single character at the cursor point
nnoremap <Leader>r i_<Esc>r

" use the leader to move between windows
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>l <C-W><C-L>

" change contents of parentheses, brackets, quotes, etc.
nnoremap <Leader>c( vi(c
nnoremap <Leader>c[ vi[c
nnoremap <Leader>c{ vi{c
nnoremap <Leader>c" vi"c
nnoremap <Leader>c' vi'c
nnoremap <Leader>c< vi<c

" open and edit .vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" when cursor is on word, use F10 to get info about syntax highlighting
nnoremap <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Set a given window width to the proper width for code editing
" 87 = 80 chars + 5 for line numbers + 2 for marks
nnoremap <Leader>wf :vertical resize 87<CR>:set winfixwidth<CR>

" Display window width
nnoremap <Leader>wd :echo winwidth(0)<CR>

" }}}
" INSERT MODE MAPPINGS ===================================================== {{{

" exit insert mode and restore cursor position (no move left)
inoremap <tab> <Esc>`^

" in insert mode, use the Esc key for tabs
"inoremap <Esc> <tab>

" use ctrl-u to make a word upper case in insert mode
inoremap <c-u> <esc>vawgUi

" }}}
" VISUAL MODE MAPPINGS ===================================================== {{{

" in visual mode, cancel any selection (gV prevents automatic reselection)
vnoremap <tab> <Esc>gV

" }}}
" OPERATOR-PENDING MODE MAPPINGS =========================================== {{{

" cancel any operator-pending command
onoremap <tab> <Esc>

" }}}
" PATHOGEN ================================================================= {{{

call pathogen#infect() "add .vim/bundle/* to runtimepath

" Vim files loaded on startup:
" plugin/
" ftdetect/ [rules for setting file types]
" after/ [deliberately runs after plugin]
"
" Vim files loaded on demand:
" colors/ [loaded when colorscheme is set]
" ftplugin/ [loaded when filetype is set]
" indent/ [loaded when filetype is set]
" syntax/ [loaded when filetype is set]
" compiler/ [loaded when filetype is set]
" doc/ [loaded when help is requested]
" autoload/ [loaded when plugin is needed]

" }}}
" SHOWMARKS ================================================================ {{{

hi ShowMarksHLl ctermfg=grey ctermbg=none
hi ShowMarksHLu ctermfg=grey ctermbg=none
hi ShowMarksHLo ctermfg=grey ctermbg=none
hi ShowMarksHLm ctermfg=grey ctermbg=none

let g:showmarks_enable=1
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" }}}
" GRUVBOX ================================================================== {{{

" note: see line 207 of gruvbox.vim for some custom overrides I've made
" TODO do the overrides in .vimrc instead
" TODO make a shell script for gruvbox colors in the terminal
set background=dark
set t_Co=256
let g:gruvbox_italic=0
colorscheme gruvbox

" }}}
" AIRLINE ================================================================== {{{

" Turn on airline's tabline extension to use the tabline to display buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_format = '%s:'

" }}}
" NERDCOMMENTER============================================================= {{{

let g:NERDCustomDelimiters = {
      \ 'php': {'left': '// ', 'leftAlt': '/*', 'rightAlt': '*/' }
      \ }

" }}}
" NERDTREE ================================================================= {{{

"let g:NERDTreeWinSize=28
call cabbrevplus#Cabbrev('nt', 'NERDTree')
"call cabbrevplus#Cabbrev('ntt', 'NERDTreeToggle')
call cabbrevplus#Cabbrev('nb', 'Bookmark')
"usage :nc bookmark_name
call cabbrevplus#Cabbrev('nc', 'ClearBookmarks')
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
"let NERDTreeHijackNetrw=1

" }}}
" MINIBUFEXPL ============================================================== {{{

" Note: minibufexpl.vim patched on line 1423 so that we can use its commands
" without the buffer itself being open

"let g:miniBufExplBRSplit=0 "put mini buffer on top
"let g:miniBufExplBuffersNeeded=1000 "suppress buffer window
let g:miniBufExplAutoStart=0 "only open manually

" use shift-arrow to scroll quickly through buffers
" note that bp and bn are abbreviated to expand to MiniBufExpl commands
" by Fancy Layout
nnoremap <s-left> :bp<CR>
nnoremap <s-right> :bn<CR>

" }}}
" FANCY LAYOUT ============================================================= {{{

call cabbrevplus#Cabbrev('fi', 'FancyLayoutInit')
call cabbrevplus#Cabbrev('fm', 'FancyLayoutGoto main')
call cabbrevplus#Cabbrev('fp', 'FancyLayoutGoto pre')
call cabbrevplus#Cabbrev('fn', 'FancyLayoutGoto notes')
call cabbrevplus#Cabbrev('ft', 'FancyLayoutNerdTree')
call cabbrevplus#Cabbrev('help', 'FancyLayoutHelp')
call cabbrevplus#Cabbrev('fh', 'FancyLayoutHelp')

" }}}
" VIMRC FOR DRUPAL ========================================================= {{{

call pathogen#infect('~/.drush/vimrc/bundle/{}')
let drupal#phpcs_exec = '/usr/local/bin/phpcs'
let drupal#phpcs_args = ''

" }}}



" create a shortcut for adding a space before all opening brackets
" (useful for CSS format correction)
" http: //stackoverflow.com/questions/8405946/regex-to-insert-space-in-vim
"nnoremap <leader>{ :%s/\(\S\){/\1 {/g<CR>

" create a shortcut for adding a space after all colons
" (useful for CSS format correction)
"nnoremap <leader>: :%s/:\(\S\)/: \1/g<CR>


"""""""""""""""""""""
" RIGHT-SIDE MARGIN "
"""""""""""""""""""""
"see http: //vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"highlight ColorColumn ctermbg=233
"let &colorcolumn=join(range(81,999),",")

" .vim/bundle/vimwiki
"let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
      "\'nested_syntaxes': {'php': 'php'}}]
"let g:vimwiki_table_mappings = 0
      "\'template_path': '~/Dropbox/vimwiki/template/',
      "\'template_default': 'default',
      "\'template_ext': '.html',
      "\'path_html': '~/Dropbox/github/vimwiki/'
"noremap <F4> : VimwikiAll2HTML<CR>

" Use the arrow keys to move quickly between windows, with possible overrides
" for particular buffer types
"autocmd BufEnter * call EnterBuffer()
"function! EnterBuffer()
  "noremap <buffer> <left> <c-w><c-h>
  "noremap <buffer> <right> <c-w><c-l>
  "noremap <buffer> <down> <c-w><c-j>
  "noremap <buffer> <up> <c-w><c-k>
  "if strpart(bufname("%"), 0, 10) ==# "NERD_tree_"
    "" in the nerd tree, use the up and down arrow keys for list navigation
    "noremap <buffer> <down> <down>
    "noremap <buffer> <up> <up>
  "endif
  "if bufname("%") ==# "-MiniBufExplorer-"
    ""echo 'hi there'
    ""<c-w><c-j>
    ""execute "normal \<C-W>\<C-J>"
  "endif
"endfunction
"
  " Use the leader with arrows to toss a new window in the arrow's direction
  "nnoremap <Leader>wk :aboveleft sp<CR>
  "nnoremap <Leader>wh :aboveleft vsp<CR>
  "nnoremap <Leader>wj :belowright sp<CR>
  "nnoremap <Leader>wl :belowright vsp<CR>

  " Equalize window sizes
  "nnoremap <Leader>w= <c-w>=


