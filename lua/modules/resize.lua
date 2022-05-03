local cmd = vim.cmd
cmd([[
"  The MIT License (MIT)

"  Copyright (c) 2013 Benjamin Attal

"  Permission is hereby granted, free of charge, to any person obtaining a copy of
"  this software and associated documentation files (the "Software"), to deal in
"  the Software without restriction, including without limitation the rights to
"  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
"  the Software, and to permit persons to whom the Software is furnished to do so,
"  subject to the following conditions:

"  The above copyright notice and this permission notice shall be included in all
"  copies or substantial portions of the Software.

"  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
"  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
"  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
"  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
"  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" resize.vim    resizing the screen
" Author:       Breuckelen (Benjamin Attal)
" Version:      1.0

"  vim-resize
"  ==========

"  *Are you a vim user? Don't know what to use the arrow keys for?*
"  * **Download this plugin for smart window resizing using the arrow keys!**

"  ## Usage
"  * use the arrow keys in normal mode to resize a vertical or horizontal split in the desired direction

"  ## Configuration

"  ### Mappings

"  By default, this plugin uses these mappings:

"      nnoremap <silent> <c-left> :CmdResizeLeft<cr>
"      nnoremap <silent> <c-down> :CmdResizeDown<cr>
"      nnoremap <silent> <c-up> :CmdResizeUp<cr>
"      nnoremap <silent> <c-right> :CmdResizeRight<cr>

"  If you want to set your own mappings, copy this line into your vimrc:

"      let g:vim_resize_disable_auto_mappings = 1

"  and use the format above to customize them to your liking.

" Globals
let g:resize_count = 2

"Is<direction>Most Boolean Functions
function! IsRightMost()
    let oldw = winnr()
    silent! exec "normal! \<c-w>l"
    let neww = winnr()
    silent! exec oldw.'wincmd w'
    return oldw == neww
endfunction

function! IsBottomMost()
    let oldw = winnr()
    silent! exec "normal! \<c-w>j"
    let neww = winnr()
    silent! exec oldw.'wincmd w'
    return oldw == neww
endfunction

function! IsTopMost()
    let oldw = winnr()
    silent! exec "normal! \<c-w>k"
    let neww = winnr()
    silent! exec oldw.'wincmd w'
    return oldw == neww
endfunction

function! IsLeftMost()
    let oldw = winnr()
    silent! exec "normal! \<c-w>h"
    let neww = winnr()
    silent! exec oldw.'wincmd w'
    return oldw == neww
endfunction

"Resize<direction> functions and helpers
function! CacheResizeCount(n)
    if a:n
        return a:n
    else
        return g:resize_count
    endif
    echo ""
endfunction

function! s:ResizeUp(n)
    let g:resize_count = CacheResizeCount(a:n)
    if IsBottomMost()
        if IsTopMost()
            silent! exec "normal! " . g:resize_count . "\<c-w>-"
        else
            silent! exec "normal! " . g:resize_count . "\<c-w>+"
        endif
    else
        silent! exec "normal! " . g:resize_count . "\<c-w>-"
    endif
    echo ""
endfunction

function! s:ResizeDown(n)
    let g:resize_count = CacheResizeCount(a:n)
    if IsBottomMost()
        if IsTopMost()
            silent! exec "normal! " . g:resize_count . "\<c-w>+"
        else
            silent! exec "normal! " . g:resize_count . "\<c-w>-"
        endif
    else
        silent! exec "normal! " . g:resize_count . "\<c-w>+"
    endif
    echo ""
endfunction

function! s:ResizeLeft(n)
    let g:resize_count = CacheResizeCount(a:n)
    if IsRightMost()
        if !IsLeftMost()
            silent! exec "normal! " . g:resize_count . "\<c-w>>"
        endif
    else
        silent! exec "normal! " . g:resize_count . "\<c-w><"
    endif
    echo ""
endfunction

function! s:ResizeRight(n)
    let g:resize_count = CacheResizeCount(a:n)
    if IsRightMost()
        if !IsLeftMost()
            silent! exec "normal! " . g:resize_count . "\<c-w><"
        endif
    else
        silent! exec "normal! " . g:resize_count . "\<c-w>>"
    endif
    echo ""
endfunction

command! CmdResizeLeft call <SID>ResizeLeft(v:count)
command! CmdResizeDown call <SID>ResizeDown(v:count)
command! CmdResizeUp call <SID>ResizeUp(v:count)
command! CmdResizeRight call <SID>ResizeRight(v:count)

"  if get(g:, 'vim_resize_disable_auto_mappings') == 0
"      nnoremap <silent> <c-left> :CmdResizeLeft<cr>
"      nnoremap <silent> <c-down> :CmdResizeDown<cr>
"      nnoremap <silent> <c-up> :CmdResizeUp<cr>
"      nnoremap <silent> <c-right> :CmdResizeRight<cr>
"  endif
]])
