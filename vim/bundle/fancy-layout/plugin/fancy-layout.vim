" vim: foldmethod=marker

" MOVEMENT MAPPINGS {{{
" use the leader to move between windows
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>l <C-W><C-L>

" Use the leader with arrows to toss a new window in the arrow's direction
nnoremap <Leader>wk :aboveleft sp<CR>
nnoremap <Leader>wh :aboveleft vsp<CR>
nnoremap <Leader>wj :belowright sp<CR>
nnoremap <Leader>wl :belowright vsp<CR>

" Equalize window sizes
nnoremap <Leader>w= <c-w>=

" Set a given window width to the proper width for code editing
" 87 = 80 chars + 5 for line numbers + 2 for marks
nnoremap <Leader>wf :vertical resize 87<CR>:set winfixwidth<CR>

" Display window width
nnoremap <Leader>wd :echo winwidth(0)<CR>
"}}}
function! FancyLayoutInit() "{{{
  " open the nerd tree
  :NERDTree
  " go back to the main window and split vertically
  2wincmd w
  :vsplit
  " go to the new window and split horizontally
  3wincmd w
  :split
  " go back to the main window
  2wincmd w
  vertical resize 87
  set winfixwidth
  " prevent jumping directly to NerdTree
  nnoremap <Leader>h <Nop>
  let g:fancy_loaded = 1
endfunction

" Is fancy layout loaded?
let g:fancy_loaded = 0

if !exists(':FancyLayoutInit')
  command! FancyLayoutInit call FancyLayoutInit()
endif
"}}}
function! FancyLayoutEnter() "{{{
  if g:fancy_loaded
    " resize windows
    if &ft ==# "nerdtree"
      vertical resize 35
    else
      vertical resize 87
    endif

    " prevent direct jumping to NerdTree
    if winnr() == 2
      nnoremap <Leader>h <Nop>
    else
      nnoremap <Leader>h <C-W><C-H>
    endif
  endif
endfunction

autocmd WinEnter * :call FancyLayoutEnter()
"}}}
function! FancyLayoutLeave() "{{{
  if g:fancy_loaded
    " Condense NerdTree
    if &ft ==# "nerdtree"
      vertical resize 28
    endif
  endif
endfunction

autocmd WinLeave * :call FancyLayoutLeave()
"}}}
function! FancyLayoutGoto(window) "{{{
  if g:fancy_loaded
    "execute a:window . 'wincmd w'
    if a:window ==# 'tree'
      1wincmd w
    elseif a:window ==# 'main'
      2wincmd w
    elseif a:window ==# 'pre'
      3wincmd w
    elseif a:window ==# 'notes'
      4wincmd w
    endif
  endif
endfunction

if !exists(':FancyLayoutGoto')
  command! -nargs=1 FancyLayoutGoto call FancyLayoutGoto(<f-args>)
endif
"}}}
function! FancyLayoutNerdTree() "{{{
  if g:fancy_loaded
    " Go to our destination window so NerdTree files open there
    "3wincmd w
    call FancyLayoutGoto('pre')
    " Go to NerdTree
    "1wincmd w
    call FancyLayoutGoto('tree')
  endif
endfunction

if !exists(':FancyLayoutNerdTree')
  command! FancyLayoutNerdTree call FancyLayoutNerdTree()
endif
"}}}
function! FancyLayoutHelp(topic) "{{{
  if g:fancy_loaded
    "4wincmd w
    call FancyLayoutGoto('notes')
    if &ft ==# 'help'
      execute 'help ' . a:topic
    else
      execute 'help ' . a:topic
      5wincmd w
      quit
    endif
  endif
endfunction

if !exists(':FancyLayoutHelp')
  command! -nargs=1 FancyLayoutHelp call FancyLayoutHelp(<f-args>)
endif
"}}}
" COMMAND LINE ABBREVIATIONS {{{
" Initialize Fancy Layout
cabbrev fi FancyLayoutInit
cabbrev <expr> fi ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutInit' : 'fi')

" Go to particular windows
cabbrev <expr> fm ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutGoto main' : 'fm')
cabbrev <expr> fp ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutGoto pre' : 'fp')
cabbrev <expr> fn ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutGoto notes' : 'fn')
cabbrev <expr> ft ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutNerdTree' : 'ft')

" Open a help topic in the notes window
cabbrev <expr> fh ((getcmdtype() == ':' && getcmdpos() <= 3)? 'FancyLayoutHelp' : 'fh')
"}}}

":Note
