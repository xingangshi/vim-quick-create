" vim-quick-create.vim - Quickly create files and directories
" Maintainer:   Your Name <your@email.com>
" Version:      1.3
" License:      VIM License

if exists('g:loaded_quick_create') || &cp
  finish
endif
let g:loaded_quick_create = 1

let s:save_cpo = &cpo
set cpo&vim

" Configuration
let g:netrw_winsize = get(g:, 'netrw_winsize', 25)

" Utility functions
function! s:EchoMessage(message)
  echo a:message
endfunction

" File and directory operations
function! s:QuickCreate(path, is_directory) abort
  let l:full_path = expand(a:path)

  if a:is_directory
    call mkdir(l:full_path, 'p')
    call s:EchoMessage("Directory created: " . l:full_path)
  else
    let l:dir = fnamemodify(l:full_path, ':h')
    if !isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
    execute 'edit ' . fnameescape(l:full_path)
    write
    call s:EchoMessage("File created: " . l:full_path)
  endif
endfunction

function! s:QuickCreateHere(filename) abort
  if a:filename =~ '/'
   call s:EchoMessage("Error: Please enter only a filename, not a path.")
   return
  endif
  let l:path = expand('%:p:h') . '/' . a:filename
  call s:QuickCreate(l:path, 0)
endfunction

function! s:DeleteFileOrDirectory(path)
  let l:path = expand(a:path)
  if isdirectory(l:path)
    call system('rm -rf ' . shellescape(l:path))
  elseif filereadable(l:path)
    call delete(l:path)
  else
    call s:EchoMessage("Invalid path")
    return
  endif
  call s:EchoMessage("Deleted: " . l:path)
endfunction

function! s:DeleteLastOpenedFile()
  " 获取最近打开的文件列表
  let l:history = get(g:, 'viminfo', [])
  if len(l:history) > 0
    " 获取最后一个打开的文件路径
    call s:EchoMessage("Error: Last ." . l:history)
    let last_opened_file = l:history[-1][1]
    " 确保获取的路径是绝对路径
    let last_opened_file = expand(last_opened_file)
    " 检查文件是否存在
    if filereadable(last_opened_file)
      call s:DeleteFileOrDirectory(last_opened_file)
    else
      call s:EchoMessage("Error: Last opened file does not exist.")
    endif
  else
    call s:EchoMessage("Error: No last opened file to delete.")
  endif
endfunction

function! s:RenameFileOrDirectory()
  let old_name = input("Enter current name: ")
  let new_name = input("Enter new name: ")
  if rename(old_name, new_name) == 0
    call s:EchoMessage("Renamed: " . old_name . " to " . new_name)
  else
    call s:EchoMessage("Failed to rename")
  endif
endfunction

" File explorer functions
function! s:ToggleFileExplorer()
  if exists("g:loaded_nerd_tree")
    NERDTreeToggle
  else
    " File explorer functions
    if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
        let cur_win_nr = winnr()
        exec expl_win_num . 'wincmd w'
        close
        exec cur_win_nr . 'wincmd w'
        unlet t:expl_buf_num
      else
        unlet t:expl_buf_num
      endif
    else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
    endif
  endif
endfunction

" Command definitions
command! -nargs=1 -complete=file CreateFile call s:QuickCreate(<q-args>, 0)
command! -nargs=1 -complete=dir CreateDir call s:QuickCreate(<q-args>, 1)
command! -nargs=1 CreateHere call s:QuickCreateHere(<q-args>)
command! -nargs=0 ToggleExplorer call s:ToggleFileExplorer()
command! -nargs=1 -complete=file DeletePath call s:DeleteFileOrDirectory(<q-args>)
command! -nargs=0 DeleteCurrent call s:DeleteFileOrDirectory(expand('%:p'))
command! -nargs=0 RenameFile call s:RenameFileOrDirectory()
command! -nargs=0 QuickCreateFile call feedkeys(":CreateFile ", "n")
command! -nargs=0 QuickCreateDir call feedkeys(":CreateDir ", "n")
command! -nargs=0 QuickCreateHere call feedkeys(":CreateHere ", "n")

" Key mappings
nnoremap <unique> <script> <Plug>QuickCreateFile  :CreateFile<Space>
nnoremap <unique> <script> <Plug>QuickCreateDir   :CreateDir<Space>
nnoremap <unique> <script> <Plug>QuickCreateHere  :CreateHere<Space>
nnoremap <unique> <script> <Plug>ToggleExplorer   :ToggleExplorer<CR>
nnoremap <unique> <script> <Plug>DeletePath       :DeletePath<Space>
nnoremap <unique> <script> <Plug>DeleteCurrent    :DeleteCurrent<CR>
nnoremap <unique> <script> <Plug>RenameFile       :RenameFile<CR>

" Default key mappings (can be overridden by users)
if !hasmapto('<Plug>QuickCreateFile')
  nmap <unique> <Leader>cf <Plug>QuickCreateFile
endif
if !hasmapto('<Plug>QuickCreateDir')
  nmap <unique> <Leader>cd <Plug>QuickCreateDir
endif
if !hasmapto('<Plug>QuickCreateHere')
  nmap <unique> <Leader>ch <Plug>QuickCreateHere
endif
if !hasmapto('<Plug>ToggleExplorer')
  nmap <unique> <Leader>te <Plug>ToggleExplorer
endif
if !hasmapto('<Plug>DeletePath')
  nmap <unique> <Leader>dp <Plug>DeletePath
endif
if !hasmapto('<Plug>DeleteCurrent')
  nmap <unique> <Leader>dc <Plug>DeleteCurrent
endif
if !hasmapto('<Plug>RenameFile')
  nmap <unique> <Leader>rf <Plug>RenameFile
endif

" Global variable to store all quick menu buffer numbers
let g:quick_menu_bufnrs = []

" Menu function
function! s:OpenQuickMenu()
  " Close all existing menus
  call s:CloseAllQuickMenus()

  let options = [
        \ '1. Create File',
        \ '2. Create Directory',
        \ '3. Create File Here',
        \ '4. Toggle Explorer',
        \ '5. Delete Path',
        \ '6. Delete Last Opened File',
        \ '7. Rename File',
        \ '8. Rename Current File'
        \ ]

  " Open a new window at the bottom
  botright 10new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  setlocal nonumber norelativenumber signcolumn=no

  " Store the buffer number of the menu
  call add(g:quick_menu_bufnrs, bufnr('%'))

  call setline(1, "Quick Create Menu")
  call setline(2, "================")
  call setline(3, "")
  call setline(4, options)

  " Set syntax highlighting
  syn match QuickMenuTitle /^Quick Create Menu$/
  syn match QuickMenuOption /^\d\+\./
  hi def link QuickMenuTitle Title
  hi def link QuickMenuOption Identifier

  " Set mappings
  nnoremap <buffer> <CR> :call <SID>MenuHandler(line('.'))<CR>
  nnoremap <buffer> q :call <SID>CloseAllQuickMenus()<CR>

  " Add number key mappings
  for i in range(1, 8)
    execute 'nnoremap <buffer> ' . i . ' :call <SID>MenuHandler(' . (i+3) . ')<CR>'
  endfor

  " Move cursor to the first option
  normal! 4G

  " Set buffer name
  file Quick\ Create\ Menu
endfunction

function! s:CloseAllQuickMenus()
  for bufnr in g:quick_menu_bufnrs
    if bufexists(bufnr)
      execute 'bwipeout! ' . bufnr
    endif
  endfor
  let g:quick_menu_bufnrs = []
endfunction

function! s:MenuHandler(line_number)
  let selected = a:line_number - 3
  call s:CloseAllQuickMenus()
  if selected == 1
    call feedkeys(":CreateFile ", "n")
  elseif selected == 2
    call feedkeys(":CreateDir ", "n")
  elseif selected == 3
    call feedkeys(":CreateHere ", "n")
  elseif selected == 4
    ToggleExplorer
  elseif selected == 5
    call feedkeys(":DeletePath ", "n")
  elseif selected == 6
    call s:DeleteLastOpenedFile()
  elseif selected == 7
    RenameFile
  elseif selected == 8
    RenameCurrentFile
  endif
endfunction

command! -nargs=0 QuickMenu call s:OpenQuickMenu()
nnoremap <unique> <script> <Plug>QuickMenu :QuickMenu<CR>
if !hasmapto('<Plug>QuickMenu')
  nmap <unique> <Leader>qm <Plug>QuickMenu
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et sw=2:
