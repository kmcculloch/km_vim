" Originally written by scrooloose
" (http://gist.github.com/205807)
" p.kevin.mcculloch@gmail.com modifications 8/28/15

if exists("g:loaded_nerdtree_grep_menuitem")
  finish
endif
let g:loaded_nerdtree_grep_menuitem = 1

call NERDTreeAddMenuItem({
      \ 'text': '(g)rep directory',
      \ 'shortcut': 'g',
      \ 'callback': 'NERDTreeGrep' })

function! NERDTreeGrep()
  let dirnode = g:NERDTreeDirNode.GetSelected()

  let pattern = input("Enter the search pattern: ")
  if pattern == ''
    echo 'Aborted'
    return
  endif

  " Change our working directory to the path of the NerdTree node.
  exec 'cd ' . dirnode.path.str()

  " Silently grep. Results will be saved in the Quickfix error list.
  exec 'silent grep! -rn ' . pattern . ' *'
      
  " The "silent" key can mess up the screen. Clear and redraw.
  redraw!

  " How long is the Quickfix error list?
  let hits = len(getqflist())
  if hits == 0
    echo "No hits"
  elseif hits > 1
    " Open the Quickfix buffer
    copen
  endif

endfunction
