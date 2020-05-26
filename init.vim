let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin('~/.config/nvim/plugins')
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'fatih/vim-go'
    Plug 'SirVer/ultisnips'
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'kylef/apiblueprint.vim'
    Plug 'scrooloose/syntastic'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-rhubarb'
    Plug 'itchyny/lightline.vim'
call plug#end()

" ### gruvbox
colorscheme gruvbox

" ### Coc

set nocompatible

"command-line completion
set wildmenu
set wildmode=list:longest

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set number

set tabstop=4
set expandtab
set shiftwidth=4

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
" nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>

" nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ### fzf
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:previewShell = "$HOME/.config/nvim/plugins/fzf.vim/bin/preview.sh"
let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline --bind ctrl-b:page-up,ctrl-f:page-down,ctrl-u:up+up+up,ctrl-d:down+down+down"
let g:fzf_custom_options = ['--preview', previewShell.' {}']

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': fzf_custom_options}, <bang>)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, {'options': fzf_custom_options}, <bang>)

command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers({'options': fzf_custom_options}, <bang>)

command! -bang -nargs=? History
    \ call fzf#vim#history({'options': fzf_custom_options}, <bang>)

command! -bang -nargs=? SearchHistory
    \ call fzf#vim#search_history({'options': fzf_custom_options}, <bang>)

command! -bang -nargs=? CommandHistory
    \ call fzf#vim#command_history({'options': fzf_custom_options}, <bang>)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

let g:fzf_history_dir = '~/.local/share/fzf-history'

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent> <space>f :<C-u>Files<CR>
nnoremap <silent> <C-p>    :<C-u>Files<cr>
nnoremap <silent> <space>h :<C-u>History<CR>
nnoremap <silent> <space>r :<C-u>Rg<CR>
nnoremap <silent> <space>g :<C-u>GFiles?<CR>
nnoremap <silent> <space>b :<C-u>GBrowse<CR>
nnoremap <silent> <space>s :<C-u>Gstatus<CR>
nnoremap <silent> <space>d :<C-u>Gdiff<CR>
nnoremap <silent> <C-_>    :<C-u>SearchHistory<CR>
nnoremap <silent> <space>l :<C-u>BLines<CR>
nnoremap <silent> <space>L :<C-u>Commits<CR>
nnoremap <silent> <space>c :<C-u>CommandHistory<CR>
nnoremap          <space>/ :<C-u>nohlsearch<CR>
nnoremap <silent> <space>: :<C-u>Commands<CR>
nnoremap <silent> <space>w :<C-u>Windows<CR>
nnoremap <silent> <space>m :<C-u>Marks<CR>

nnoremap <silent> <C-n> :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <leader>n :<C-u>NERDTreeFind<CR>

autocmd FileType go nmap <leader>run <Plug>(go-run-vertical)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>a <Plug>(go-alternate-vertical)
autocmd FileType go nmap <leader>d <Plug>(go-diagnostics)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-browser)
autocmd FileType go nmap <leader>s <Plug>(go-decls)
autocmd FileType go nmap <leader>f <Plug>(go-decls-dir)
autocmd FileType go nmap <leader>im :<C-u>GoImpl<CR>
autocmd FileType go nmap <leader>if <Plug>(go-iferr)

let g:go_fmt_command = "goimports"

nnoremap <leader>ve :<C-u>e $MYVIMRC<CR>
nnoremap <leader>vs :<C-u>so $MYVIMRC<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set clipboard=unnamedplus

for n in range(1, 9)
  execute 'nnoremap <silent> <space>'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> <space>t :<C-u>tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> <space>] :<C-u>tabnext<CR>
" tn 次のタブ
map <silent> <space>[ :<C-u>tabprevious<CR>
" tp 前のタブ

nnoremap <space>u :<C-u>GitGutterUndoHunk<CR>
nnoremap <space>n :<C-u>GitGutterNextHunk<CR>
nnoremap <space>p :<C-u>GitGutterPrevHunk<CR>

command! Q q
command! W w

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>

" nnoremap <C-w>e :<C-u>WinResizerStartResize<CR>

let g:winresizer_start_key = "<C-w>e"

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:lightline = { 'colorscheme': 'seoul256' }
