if !exists('g:env')
    finish
endif

if g:plug.is_installed('enhancd')
    let g:enhancd_action = g:plug.is_installed('dirvish') ? 'Dirvish' : 'Ex'
endif

if g:plug.is_installed('asyncomplete.vim')
    let g:lsp_async_completion = 1
endif

if g:plug.is_installed('fzf.vim')
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit' }

    command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

    imap <C-c><C-w> <plug>(fzf-complete-word)
    imap <C-c><C-p> <plug>(fzf-complete-path)
    imap <C-c><C-l> <plug>(fzf-complete-line)
    nnoremap <silent> ff :<C-u>Files<CR>
    nnoremap <silent> rg :<C-u>Rg<CR>
    nnoremap <silent> ag :<C-u>Ag<CR>
endif

if g:plug.is_installed('mru.vim')
    let MRU_Auto_Close = 1
    let MRU_Window_Height = 30
    let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
    let MRU_Max_Entries = 1000
    nnoremap <silent> [Space]j :<C-u>MRU<CR>
else
    " MRU configuration variables
    if !exists('s:MRU_File')
        if has('unix') || has('macunix')
            let s:MRU_File = $HOME . '/.vim_mru_files'
        else
            let s:MRU_File = $VIM . '/_vim_mru_files'
            if has('win32')
                if $USERPROFILE != ''
                    let s:MRU_File = $USERPROFILE . '\_vim_mru_files'
                endif
            endif
        endif
    endif

    function! s:MRU_LoadList()
        if filereadable(s:MRU_File)
            let s:MRU_files = readfile(s:MRU_File)
            if s:MRU_files[0] =~# '^#'
                call remove(s:MRU_files, 0)
            else
                let s:MRU_files = []
            endif
        else
            let s:MRU_files = []
        endif
    endfunction

    function! s:MRU_SaveList()
        let l = []
        call add(l, '# Most recently used files list')
        call extend(l, s:MRU_files)
        call writefile(l, s:MRU_File)
    endfunction
    function! s:MRU_AddList(buf)
        if s:mru_list_locked
            return
        endif

        let fname = fnamemodify(bufname(a:buf + 0), ':p')
        if fname == ''
            return
        endif

        if &buftype != ''
            return
        endif

        if index(s:MRU_files, fname) == -1
            if !filereadable(fname)
                return
            endif
        endif

        call s:MRU_LoadList()
        call filter(s:MRU_files, 'v:val !=# fname')
        call insert(s:MRU_files, fname, 0)

        "let s:MRU_Max_Entries = 100
        "if len(s:MRU_files) > s:MRU_Max_Entries
        " call remove(s:MRU_files, s:MRU_Max_Entries, -1)
        "endif

        call s:MRU_SaveList()

        let bname = '__MRU_Files__'
        let winnum = bufwinnr(bname)
        if winnum != -1
            let cur_winnr = winnr()
            call s:MRU_Create_Window()
            if winnr() != cur_winnr
                exe cur_winnr . 'wincmd w'
            endif
        endif
    endfunction

    function! s:MRU_RemoveList()
        call s:MRU_LoadList()
        let lnum = line('.')
        call remove(s:MRU_files, line('.')-1)
        call s:MRU_SaveList()
        close
        call s:MRU_Create_Window()
        call cursor(lnum, 1)
    endfunction

    function! s:MRU_Open_File() range
        for f in getline(a:firstline, a:lastline)
            if f == ''
                continue
            endif

            let file = substitute(f, '^.*| ','','')

            let winnum = bufwinnr('^' . file . '$')
            silent quit
            if winnum != -1
                return
            else
                if &filetype ==# 'mru'
                    silent quit
                endif
            endif

            exe 'edit ' . fnameescape(substitute(file, '\\', '/', 'g'))
        endfor
    endfunction

    function! s:MRU_Create_Window()
        if &filetype == 'mru' && bufname("%") ==# '__MRU_Files__'
            quit
            return
        endif

        call s:MRU_LoadList()
        if empty(s:MRU_files)
            echohl WarningMsg | echo 'MRU file list is empty' | echohl None
            return
        endif

        let bname = '__MRU_Files__'
        let winnum = bufwinnr(bname)
        if winnum != -1
            if winnr() != winnum
                exe winnum . 'wincmd w'
            endif

            setlocal modifiable
            " Delete the contents of the buffer to the black-hole register
            silent! %delete _
        else
            " If the __MRU_Files__ buffer exists, then reuse it. Otherwise open
            " a new buffer
            let bufnum = bufnr(bname)
            if bufnum == -1
                let wcmd = bname
            else
                let wcmd = '+buffer' . bufnum
            endif
            let wcmd = bufnum == -1 ? bname : '+buffer' . bufnum
            let s:MRU_Window_Height = &lines / 3
            exe 'silent! botright ' . s:MRU_Window_Height . 'split ' . wcmd
        endif

        " Mark the buffer as scratch
        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal noswapfile
        setlocal nowrap
        setlocal nobuflisted
        setlocal filetype=mru
        setlocal winfixheight
        setlocal modifiable

        let old_cpoptions = &cpoptions
        set cpoptions&vim

        " Create mappings to select and edit a file from the MRU list
        nnoremap <buffer> <silent> <CR>   :call <SID>MRU_Open_File()<CR>
        vnoremap <buffer> <silent> <CR>   :call <SID>MRU_Open_File()<CR>
        nnoremap <buffer> <silent> <S-CR> :call <SID>MRU_Open_File_Tab()<CR>
        vnoremap <buffer> <silent> <S-CR> :call <SID>MRU_Open_File_Tab()<CR>
        nnoremap <buffer> <silent> K      :call <SID>MRU_RemoveList()<CR>
        nnoremap <buffer> <silent> S      :setlocal modifiable<CR>:sort<CR>:setlocal nomodifiable<CR>

        " Restore the previous cpoptions settings
        let &cpoptions = old_cpoptions

        let output = copy(s:MRU_files)
        let idx = 0
        for file in output
            if !filereadable(file)
                call remove(output, idx)
                continue
            endif
            let idx += 1
        endfor

        silent! 0put =output

        " Delete the empty line at the end of the buffer
        silent! $delete _
        let glist = getline(1, '$')
        let max = 0
        let max_h = 0
        for idx in range(0, len(glist)-1)
            if strlen(fnamemodify(glist[idx], ':t')) > max
                let max = strlen(fnamemodify(glist[idx], ':t'))
            endif
            if strlen(substitute(fnamemodify(glist[idx], ':p:h'), '^.*\/', '', '')) > max_h
                let max_h = strlen(substitute(fnamemodify(glist[idx], ':p:h'), '^.*\/', '', ''))
            endif
        endfor
        for idx in range(0, len(glist)-1)
            let glist[idx] = printf("%-" . max .  "s | %-" . max_h . "s | %s" ,
                        \ fnamemodify(glist[idx], ':t'), substitute(fnamemodify(glist[idx], ':p:h'), '^.*\/', '', ''), glist[idx])
        endfor
        silent! %delete _
        call setline(1, glist)
        if glist[idx] == '| '
            silent! $delete _
        endif

        exe 'syntax match Directory display ' . '"'. '|\zs[^|]*\ze|'. '"'
        exe 'syntax match Constant  display ' . '"' . '[^|]*[\/]' . '"'

        " Move the cursor to the beginning of the file
        normal! gg

        setlocal nonumber cursorline nomodifiable
    endfunction

    " MRU Essentials
    let s:mru_list_locked = 0
    call s:MRU_LoadList()
    command! MRU call s:MRU_Create_Window()
    augroup mru-files-vimrc
        autocmd!
        autocmd BufRead      * call s:MRU_AddList(expand('<abuf>'))
        autocmd BufNewFile   * call s:MRU_AddList(expand('<abuf>'))
        autocmd BufWritePost * call s:MRU_AddList(expand('<abuf>'))
        autocmd QuickFixCmdPre  *grep* let s:mru_list_locked = 1
        autocmd QuickFixCmdPost *grep* let s:mru_list_locked = 0
    augroup END

    " MRU within the vimrc
    "if !g:plug.is_installed('mru.vim')
    if exists('*s:MRU_Create_Window')
        nnoremap <silent> [Space]j :<C-u>call <SID>MRU_Create_Window()<CR>
    endif
    "endif
endif

if g:plug.is_installed('')
endif

" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Go
if executable('bingo')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'bingo',
        \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    au FileType go nnoremap <buffer><silent> <Leader>d :<C-u>LspDefinition<CR>
    au FileType go nnoremap <buffer><silent> <Leader>r :<C-u>LspReferences<CR>
    au FileType go nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType go nnoremap <buffer><silent> <Leader>t :<C-u>LspRename<CR>
    au FileType go nnoremap <buffer><silent> <Leader>ds  :<C-u>LspDocumentSymbol<CR>
    au FileType go nnoremap <buffer><silent> <Leader>ws :<C-u>LspWorkspaceSymbol<CR>
    au FileType go nnoremap <buffer><silent> <Leader>df :<C-u>LspDocumentFormat<CR>
    au FileType go vnoremap <buffer><silent> <Leader>rs :LspDocumentRangeFormat<CR>
    au FileType go nnoremap <buffer><silent> <Leader>h :<C-u>LspHover<CR>
    au FileType go setlocal foldmethod=marker
endif
