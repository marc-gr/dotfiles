set nocompatible
filetype off

set rtp+=~/.vim_go/bundle/Vundle.vim

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :Pluginupdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'fatih/vim-go'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/neocomplete.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tomasr/molokai'
Plugin 'christoomey/vim-sort-motion'

call vundle#end()
" Put your non-Plugin stuff after this line

" General 
filetype plugin indent on
syntax on
set encoding=utf-8
set number
set relativenumber
set nobackup
set noswapfile
" this enables wrapping
set wrap linebreak nolist
set showbreak=…
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0
set hidden
let mapleader = "\<Space>"
set guifont=Source_Code_Pro_For_Powerline:h12
" Disables autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
colorscheme molokai
" use 256 colors in terminal
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" Split windows 
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers
map <leader><right> <Esc>:bn<CR>
map <leader><left> <Esc>:bp<CR>

" VimGo 
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_play_open_browser = 0
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>e <Plug>(go-rename)

" AgVim 
let g:ag_working_path_mode="r"

" Neocomplete
let g:neocomplete#enable_at_startup = 1
set completeopt-=preview

" NerdTree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeMinimalUI=1
let g:nerdtree_tabs_open_on_gui_startup=0
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Airline 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode

" CTRLP 
let g:ctrlp_working_path_mode = "ra"
map <C-f> :CtrlPBuffer<CR>

" Arrow keys setup
function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^s*$'
        let l:colsave = col(".")
        .-1d
        silent normal! <C-y>
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" Arrow key remapping: up/Dn = move line up/dn; left/right = indent/unindent
function! SetArrowKeysAsTextShifters()
    " normal mode
    nmap <silent> <left> <<
    nmap <silent> <right> >>
    nnoremap <silent> <up> <Esc>:call DelEmptyLineAbove()<CR>
    nnoremap <silent> <down> <Esc>:call AddEmptyLineAbove()<CR>
    nnoremap <silent> <leader><up> <Esc>:call DelEmptyLineBelow()<CR>
    nnoremap <silent> <leader><down> <Esc>:call AddEmptyLineBelow()<CR>

    " visual mode
    vmap <silent> <left> <
    vmap <silent> <right> >
    vnoremap <silent> <up> <Esc>:call DelEmptyLineAbove()<CR>gv
    vnoremap <silent> <down> <Esc>:call AddEmptyLineAbove()<CR>gv
    vnoremap <silent> <leader><up> <Esc>:call DelEmptyLineBelow()<CR>gv
    vnoremap <silent> <leader><down> <Esc>:call AddEmptyLineBelow()<CR>gv

    " insert mode
    imap <silent> <left> <C-D>
    imap <silent> <right> <C-T>
    inoremap <silent> <up> <Esc>:call DelEmptyLineAbove()<CR>a
    inoremap <silent> <down> <Esc>:call AddEmptyLineAbove()<CR>a
    inoremap <silent> <leader><up> <Esc>:call DelEmptyLineBelow()<CR>a
    inoremap <silent> <leader><down> <Esc>:call AddEmptyLineBelow()<CR>a

    " disable modified versions we are not using
    nnoremap  <S-up>     <NOP>
    nnoremap  <S-down>   <NOP>
    nnoremap  <S-left>   <NOP>
    nnoremap  <S-right>  <NOP>
    vnoremap  <S-up>     <NOP>
    vnoremap  <S-down>   <NOP>
    vnoremap  <S-left>   <NOP>
    vnoremap  <S-right>  <NOP>
    inoremap  <S-up>     <NOP>
    inoremap  <S-down>   <NOP>
    inoremap  <S-left>   <NOP>
    inoremap  <S-right>  <NOP>
endfunction

call SetArrowKeysAsTextShifters()
