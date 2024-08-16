" vim-quick-create.vim - Quickly create files and directories
" Maintainer:   Your Name <your@email.com>
" Version:      1.1
" License:      VIM License

if exists('g:loaded_quick_create') || &cp
  finish
endif
let g:loaded_quick_create = 1

" Save cpo (compatible-mode options)
let s:save_cpo = &cpo
set cpo&vim

" Main function to create file or directory
function! s:QuickCreate(path, is_directory) abort
  let l:full_path = expand(a:path)
  
  if a:is_directory
    call mkdir(l:full_path, 'p')
    echo "Directory created: " . l:full_path
  else
    let l:dir = fnamemodify(l:full_path, ':h')
    if !isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
    execute 'edit ' . fnameescape(l:full_path)
    write
    echo "File created: " . l:full_path
  endif
endfunction

" Function to create file in current directory
function! s:QuickCreateHere(filename) abort
  let l:path = expand('%:p:h') . '/' . a:filename
  call s:QuickCreate(l:path, 0)
endfunction

" Define commands
command! -nargs=1 -complete=file CreateFile call s:QuickCreate(<q-args>, 0)
command! -nargs=1 -complete=dir CreateDir call s:QuickCreate(<q-args>, 1)
command! -nargs=1 CreateHere call s:QuickCreateHere(<q-args>)

" Define default mappings
if !hasmapto('<Plug>QuickCreateFile')
  nmap <unique> <Leader>cf <Plug>QuickCreateFile
endif
if !hasmapto('<Plug>QuickCreateDir')
  nmap <unique> <Leader>cd <Plug>QuickCreateDir
endif
if !hasmapto('<Plug>QuickCreateHere')
  nmap <unique> <Leader>ch <Plug>QuickCreateHere
endif

" Define <Plug> mappings
nnoremap <unique> <script> <Plug>QuickCreateFile  :CreateFile<Space>
nnoremap <unique> <script> <Plug>QuickCreateDir   :CreateDir<Space>
nnoremap <unique> <script> <Plug>QuickCreateHere  :CreateHere<Space>

" Restore cpo
let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et sw=2:
