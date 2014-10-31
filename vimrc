" K. McCULLOCH VIMRC
" to inspect local environment:
" http://vim.wikia.com/wiki/Displaying_the_current_Vim_environment

function! OpenHelpInCurrentWindow(topic)
  view $VIMRUNTIME/doc/help.txt
  setl filetype=help
  setl buftype=help
  setl nomodifiable
  exe 'keepjumps help ' . a:topic
endfunction

command! -nargs=? -complete=help Help call OpenHelpInCurrentWindow(<q-args>)
nnoremap <silent> <leader>h :view +1 $VIMRUNTIME/doc/help.txt

" GLOBAL BEHAVIOR {{{

" Compatibility mode {{{
set nocompatible "use Vim (not Vi) option defaults
" }}}

" Pathogen {{{
call pathogen#infect() "add .vim/bundle/* to runtimepath
call pathogen#infect('~/.drush/vimrc/bundle/{}')
" }}}

" Edit/source vimrc {{{
" open .vimrc in a new tab for editing 
nnoremap <leader>ev :edit $MYVIMRC<CR>

" source .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" }}}

" Map leader {{{
" use the space bar as the mapleader key
"nnoremap <Space> <Nop>
"let mapleader = " "
map <Space> <Leader>
set timeout timeoutlen=3000 "set timeout gap for multi-key operations to 3 sec
set showcmd

" use the tab key for escape operations and vice-versa
" in normal mode, cancel any prefix keys (eg. # for count)
nnoremap <Tab> <Esc>
" in visual mode, cancel any selection (gV prevents automatic reselection)
vnoremap <Tab> <Esc>gV
" cancel any operator-pending command
onoremap <Tab> <Esc>
" exit insert mode and restore cursor position (no move left)
inoremap <Tab> <Esc>`^
" in insert mode, use the Esc key for tabs
inoremap <Esc> <Tab>
" turn off K (does a sudden help topic lookup that is distracting)
nnoremap K <Nop>

" }}}

" Backups {{{
" turn off the default backup/swapfile behavior
set nobackup 
set noswapfile 
" }}}

" Command line and messages {{{
set shortmess=atI "shorten various system messages
set visualbell "use the visual bell instead of beeping
set history=1000 "increase command-line history from 20 to 1000
" }}}

" Scrolling {{{
set scrolloff=3 "scrolling offset of 3 lines at top/bottom
" }}}

" Marks {{{
" make sure marks move us back to the specified location
nnoremap ' `
nnoremap ` '
" }}}

" Search {{{
" ignore search case when typing a lower-case search string
" note: This causes vimscript code to evaluate "foo" == "Foo" as true!
" http: //learnvimscriptthehardway.stevelosh.com/chapters/22.html
set ignorecase "causes foo to match foo, Foo, FOO
set smartcase "causes Foo only to match Foo

set incsearch "see results while typing
set hlsearch "search matches are highlighted
set nowrapscan "keep searches from wrapping around the end of the file
" }}}

" }}}

" LAYOUT AND APPEARANCE {{{

" Fancy layout
function! FancyLayout()
  :silent only
  :MBEOpen
  :NERDTree
  3wincmd w
  :vsplit
  :vsplit
  :vertical resize 87
  :set winfixwidth
  4wincmd w
  :vertical resize 87
  :set winfixwidth
  3wincmd w
  echo 'fancy layout'
endfunction
nnoremap <Leader>fl :call FancyLayout()<cr>

" Buffers {{{
set hidden "keep buffers loaded when they are abandoned
set confirm "prompt for save before unloading a modified buffer

let g:miniBufExplBRSplit=0 "put mini buffer on top
"let g:miniBufExplBuffersNeeded=0 "start mini buffer automatically

" use shift-arrow to scroll quickly through buffers
" note that bp and bn are abbreviated to expand to MiniBufExpl commands
nnoremap <s-left> :bp<CR>
nnoremap <s-right> :bn<CR>
" }}}

" Windows {{{
" Use the arrow keys to move quickly between windows, with possible overrides
" for particular buffer types
autocmd BufEnter * call EnterBuffer()
function! EnterBuffer()
  noremap <buffer> <left> <c-w><c-h>
  noremap <buffer> <right> <c-w><c-l>
  noremap <buffer> <down> <c-w><c-j>
  noremap <buffer> <up> <c-w><c-k>
  if strpart(bufname("%"), 0, 10) ==# "NERD_tree_"
    " in the nerd tree, use the up and down arrow keys for list navigation
    noremap <buffer> <down> <down>
    noremap <buffer> <up> <up>
  endif
  if bufname("%") ==# "-MiniBufExplorer-"
    "echo 'hi there'
    "<c-w><c-j>
    "execute "normal \<C-W>\<C-J>"
  endif
endfunction

" Use the leader with arrows to toss a new window in the arrow's direction
nnoremap <Leader><Up> :aboveleft sp<CR>
nnoremap <Leader><Left> :aboveleft vsp<CR>
nnoremap <Leader><Down> :belowright sp<CR>
nnoremap <Leader><Right> :belowright vsp<CR>

" Equalize window sizes
nnoremap <Leader>w= <c-w>=
" Set a given window width to the proper width for code editing
" 87 = 80 chars + 5 for line numbers + 2 for marks
nnoremap <Leader>wf :vertical resize 87<CR>:set winfixwidth<CR>
" }}}

" Status bar {{{
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
" }}}

" Line numbers {{{
set number "turn on left-hand numbering
set numberwidth=5 "use 5 spaces for left-hand number column
" }}}

" Gruvbox {{{
" note: see line 207 of gruvbox.vim for some custom overrides I've made
" TODO do the overrides in .vimrc instead
" TODO make a shell script for gruvbox colors in the terminal
set background=dark
set t_Co=256
let g:gruvbox_italic=0
colorscheme gruvbox
" }}}

" }}}

" EDITING {{{

" Filetype and syntax {{{
filetype on "source .vim/filetype.vim
filetype plugin on "source .vim/ftplugin
filetype indent on "source .vim/indent
syntax on "source .vim/syntax

" when cursor is on word, use F10 to get info about syntax highlighting
noremap <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}

" Tabs {{{
set expandtab "use spaces instead of tab character
set tabstop=2 "tab stops calculated every 2 spaces
" }}}

" Indent {{{
set autoindent "copy indent from current line when starting a new line
set smartindent "autoindent automatically based on syntax
set shiftwidth=2 "number of spaces to use for each step of autoindent
" }}}

" Line breaks {{{
set linebreak "wrap long lines rather than entering line breaks
" }}}

" Movement mappings {{{
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
" }}}

" Other mappings for editing text {{{
" require a leader stroke to use J to concatenate lines
nnoremap <Leader>J J
nnoremap J <Nop>

" a leader stroke followed by d/D deletes lines in confusing ways
nnoremap <Leader>d <Nop>
nnoremap <Leader>D <Nop>

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

" change contents of parentheses
nnoremap <Leader>cp vi(c

" change contents of brackets
nnoremap <Leader>cb vi[c

" change contents of curly braces
nnoremap <Leader>cc vi{c

" change contents of (double) quotes
nnoremap <Leader>cd vi"c

" change contents of (single) quotes
nnoremap <Leader>cs vi'c
" }}}

" }}}

" PLUGINS {{{

" ShowMarks {{{
" .vim/bundle/ShowMarks
" help showmarks-mappings
hi ShowMarksHLl ctermfg=grey ctermbg=none
hi ShowMarksHLu ctermfg=grey ctermbg=none
hi ShowMarksHLo ctermfg=grey ctermbg=none
hi ShowMarksHLm ctermfg=grey ctermbg=none
let g:showmarks_enable=0
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" }}}

" Nerdtree {{{
" help nerdtreemappings
cabbrev nt NERDTree
cabbrev ntt NERDTreeToggle
cabbrev nb Bookmark
" }}}

" MiniBufExplorer {{{
cabbrev bn MBEbn
cabbrev bp MBEbp
cabbrev bf MBEbf
cabbrev bb MBEbb
cabbrev bd MBEbd
cabbrev bw MBEbw
cabbrev bun MBEbun
" }}}

" Vim Notes {{{
let g:notes_tab_indents = 0
" }}}

" }}}

" TODO {{{
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

" VimWiki plugin {{{
" .vim/bundle/vimwiki
"let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
      "\'nested_syntaxes': {'php': 'php'}}]
"let g:vimwiki_table_mappings = 0
      "\'template_path': '~/Dropbox/vimwiki/template/',
      "\'template_default': 'default',
      "\'template_ext': '.html',
      "\'path_html': '~/Dropbox/github/vimwiki/'
"noremap <F4> : VimwikiAll2HTML<CR>
" }}}
" }}}
