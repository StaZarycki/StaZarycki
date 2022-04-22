" Put inside ~/.config/nvim/

call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'leafgarland/typescript-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf','do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdcommenter'
call plug#end()

" Coc plug-in
let g:coc_global_extensions = ['coc-eslint','coc-emmet','coc-css','coc-html','coc-json','coc-prettier','coc-tsserver']

set cursorline
set number

" Support system clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).'|'.s:clip)
    augroup END
end

set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

if (has("termguicolors"))
  set termguicolors
endif
syntax enable
colorscheme dracula

" NERDTree config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ' '
let g:NERDTreeIgnore = ['node_modules']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <silent> <C-b> :NERDTreeToggle<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Configure the integration terminal
set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal(a)
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
augroup TerminalStuff
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" Configure file search
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Configure prettier
let g:prettier#config#config_precedence = 'cli-override'
let g:prettier#config#print_width = 120
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
nnoremap <silent> <C-Space> :Prettier<CR>

"Configuration comment
filetype plugin on
let g:NERDSpaceDelims = 2
let g:ft = ' '

nnoremap <silent> <C-_> :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap <silent> <C-_> :call nerdcommenter#Comment(0,"toggle")<CR>
