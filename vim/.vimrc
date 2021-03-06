"set nocompatible               " be iMproved
"filetype off                   " required!
set nocompatible | filetype indent plugin on | syn on

" Install vim-plug if it isn't installed and call plug#begin() out of box
function! s:download_vim_plug()
  if !empty(&rtp)
    let vimfiles = split(&rtp, ',')[0]
  else
    echohl ErrorMsg
    echomsg 'Unable to determine runtime path for Vim.'
    echohl NONE
  endif
  if empty(glob(vimfiles . '/autoload/plug.vim'))
    let plug_url =
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if executable('curl')
      let downloader = '!curl -fLo '
    elseif executable('wget')
      let downloader = '!wget -O '
    else
      echohl ErrorMsg
      echomsg 'Missing curl or wget executable'
      echohl NONE
    endif
    if !isdirectory(vimfiles . '/autoload')
      call mkdir(vimfiles . '/autoload', 'p')
    endif
    if has('win32')
      silent execute downloader . vimfiles . '\\autoload\\plug.vim ' . plug_url
    else
      silent execute downloader . vimfiles . '/autoload/plug.vim ' . plug_url
    endif

    " Install plugins at first
    autocmd VimEnter * PlugInstall | quit
  endif
  call plug#begin(vimfiles . '/plugged')
endfunction

call s:download_vim_plug()

Plug 'rust-lang/rust.vim'
Plug 'jwalton512/vim-blade'
Plug 'scrooloose/nerdtree'
Plug 'yous/vim-open-color'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/ctrlp.vim'
Plug 'vim-scripts/EasyMotion'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/vim-coffee-script', { 'for': 'coffee' }
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/hgrev'
Plug 'tpope/vim-rails'
Plug 'vim-scripts/tComment'
Plug 'vim-scripts/xmledit'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'khwon/Vim-Tomorrow-Theme'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'vim-scripts/indenthtml.vim'
Plug 'vim-scripts/vim-javascript'
Plug 'vim-scripts/vim-eco'
Plug 'khwon/cscope_maps.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-dispatch'
Plug 'jiangmiao/auto-pairs'
Plug 'khwon/vim-conflicted'
" Provide CamelCase motion through words
Plug 'bkad/CamelCaseMotion'
" Provides insert mode auto-completion for quotes, parens, brackets, etc
Plug 'Raimondi/delimitMate'
" ANSI escape
Plug 'vim-scripts/AnsiEsc.vim', { 'for': 'railslog' }
Plug 'dag/vim-fish'
Plug 'sainnhe/sonokai'
Plug 'bluz71/vim-nightfly-guicolors'

if has('mac') || has('macunix')
  " Add plist editing support to Vim
  Plug 'darfink/vim-plist'
endif

call plug#end()
"vim-eunuch AutoComplPopup pythoncomplete rubycomplete

"set bg=dark " background를 dark로 설정한다
syntax enable
set ai "set autoindent
set ts=4
set sw=4 " tab 관련 설정
set et
set nu " show line number
set nobackup "do not make backup files
set title " windows title을 현재 편집중인 파일이름으로 한다.
set incsearch "incremental search
set hlsearch "search를 할때 highlight를 해준다.
set smartcase "소문자로 검색시 대소문자 무시, 대문자로 검색시 대문자만 검색
filet plugin indent on " filetype에 따른 plugin, indetation을 켠다.
set fencs=ucs-bom,utf-8,cp949 "try this encodings when open files
set showmatch "match brakets
set autowrite "auto save when :make or :next
set foldmethod=syntax " syntax에 따라 folding을 한다.
set foldlevel=9999999 "open all fold
set km-=stopsel " ctrl+f & ctrl+b don't stop visual mode
set showcmd
set backspace=2
"set cscopetag "use cscope for tag commands
set dy+=uhex "show unprintable characters as a hex number
"set transparency = 3 "macvim only
set clipboard=unnamed "share clipboard with register
"set statusline=%F%m%r%h%w\ \:\ %{&ff},%Y\ %=[\%03.3b,0x\%02.2B]\ \ \ %l,%c%V\ (%p%%)
set laststatus=2
set scrolloff=3  " 커서의 위아래로 항상 세줄의 여유가 있게끔.
set completeopt=menu,menuone,longest " do not show preview window on omnicompletion
"let g:acp_behaviorKeywordLength = 5
"let g:acp_behaviorRubyOmniMethodLength = 5
"let g:acp_behaviorRubyOmniSymbolLength = 5
command! W w " :W로 저장
command! E Explore

au BufRead,BufNewFile *.cc set filetype=cpp "*.cc를 c++로 인식
if has("win32")
       set makeprg=nmake "windows 환경에선 make대신 nmake사용
endif
if !filereadable("Makefile") && !filereadable("makefile") " makefile이 없을시에 자동 컴파일 설정
       if has("unix") " unix계열의 경우에 gcc, g++을 사용한다.
        autocmd FileType c set makeprg=gcc\ -o\ %<\ -O2\ -W\ -Wall\ -g\ %
        autocmd FileType cpp set makeprg=g++\ -o\ %<\ -O2\ -W\ -Wall\ -g\ %
       elseif has("win32") " windows의 경우에 cl을 사용한다.
               autocmd FileType c set makeprg=cl\ /O2\ %
               autocmd FIleType cpp set makeprg=cl\ /O2\ %
       endif
       autocmd FileType java set makeprg=javac\ % "java의 경우에는 javac를 사용한다.
endif

autocmd FileType ruby set makeprg=ruby\ -wc\ % "ruby의 경우에는 -c를 이용해서 syntax check를 한다.
autocmd FileType ruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby let g:rubycomplete_buffer_loading=1
"autocmd FileType ruby let g:rubycomplete_classes_in_global=1
autocmd FileType python set omnifunc=pythoncomplete#Complete " python completion

map <C-h> <C-W>h
map <C-l> <C-W>l

map <silent> <F7> :make<CR>:bo cw 5<CR> "set F7 to make & show compile error
imap <silent> <F7> <C-c>:make<CR>:bo cw 5<CR>
map <C-j> :cn<CR> " Ctrl + j로 다음 에러를 찾아간다.
imap <C-j> <esc>:cn<CR>
map <C-k> :cp<CR>
imap <C-k> <esc>:cp<CR> " Ctrl + k로 이전 에러를 찾아간다.
if has("unix")
       map <silent> <C-F5> :!./%<<CR>
       imap <silent> <C-F5> <C-c>:!./%<<CR>
elseif has("win32")
       map <silent> <C-F5> :make<CR>:!%<.exe<CR>
       imap <silent> <C-F5> <C-c>:!./%<.exe<CR>
endif
"Ctrl + F5에 실행을 할당한다.


" man page settings
autocmd FileType ruby set keywordprg=ri
autocmd FileType c,cpp set keywordprg=man

if has("gui_running")
	set go=gmr
	colorscheme slate
	hi Comment guifg=grey60
	set cursorline "highlight current line
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
endif
"---------------- Taglist ----------------------
" F4 : Switch on/off TagList
nnoremap <silent> <F4> :TlistToggle<CR>
"in console mode
let Tlist_Inc_Winwidth=0
let g:Tlist_Use_Right_Window=0
"------------------------------------------------

" http://stackoverflow.com/questions/6005874/opening-a-window-in-a-horizontal-split-of-a-vertical-split
fun! OpenNerdTag()
	if winnr('$')!=1
		only
	endif
	NERDTree
	TlistOpen
	wincmd J
	wincmd W
	wincmd L
	NERDTreeFocus
	normal AA
	wincmd p
endfun

let open_nerdtree=1

"vertical split & show git diff when git commit
autocmd FileType gitcommit DiffGitCached | wincmd L | wincmd p
autocmd FileType gitcommit let open_nerdtree=0

if &diff
  "do not open nerdtree and tlist when in diff mode
  let open_nerdtree=0
endif
autocmd VimEnter * if (open_nerdtree && exists(':NERDTree') && exists(':TlistOpen')) " | call OpenNerdTag() start nerdtree on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " exit vim if only nerdtree remains

let g:ctrlp_root_markers = ['Gemfile','Rakefile']

let g:EasyMotion_leader_key = '<Leader>'

" from github.com/astrails/dotvim
" ignore these files when completing names and in
" explorer
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc
set shell=/bin/bash     " use bash for shell commands
set autowriteall        " Automatically save before commands like :next and :make
set hidden              " enable multiple modified buffers
set history=1000
set autoread            " automatically read file that has been changed on disk and doesn't have changes in vim


" center display after searching
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#z

" show red bg for extra whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fixes glitch? in colors when using vim with tmux
set background=dark
set t_Co=256
set termguicolors
colorscheme miramare

let g:xml_use_xhtml = 1

nmap <C-c> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" I can type :help on my own, thanks.
noremap <F1> <Esc>


"Disable paste mode when leaving Insert Mode
au InsertLeave * set nopaste

"Disable some warnings on flake8
"let g:syntastic_python_flake8_args='--ignore=E111,E201,E202,E203,E231'
let g:syntastic_python_flake8_args='--select=E101,E112,E113,E721,W601,W602,W603,W604,F401,F402,F404,F811,F812,F821,F822,F823,F831,F841,N801,N802,N803,N804,N805,N806,N811,N812,N813,N814'

"airline configuration
let g:airline_left_sep=''
let g:airline_right_sep=''

" easytags configuration
"let g:easytags_async=1
"let g:easytags_syntax_keyword = 'always'
"let g:easytags_dynamic_files = 1

" delimitMate
let g:delimitMate_expand_cr = 2

" ANSI escape for Rails log
autocmd FileType railslog :AnsiEsc

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux or screen.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
" check and use tmux's 24-bit color support
" (<http://sunaku.github.io/tmux-24bit-color.html#usage> for more information.)
if empty($TMUX) && empty($STY)
  if has('nvim')
    " For Neovim 0.1.3 and 0.1.4 <https://github.com/neovim/neovim/pull/2198>
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  endif
  " For Neovim > 0.1.5 and Vim > patch 7.4.1799
  " <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
  " Based on Vim patch 7.4.1770 (`guicolors` option)
  " <https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
  " <https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
  if has('termguicolors')
  endif
endif

"colorscheme open-color

" Setting by kangmin 
set pastetoggle=<F3>
