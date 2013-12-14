" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off
filetype plugin indent off        " golang
set runtimepath+=$GOROOT/misc/vim " golang
filetype plugin indent on     " required! 

" Vundle bundle management
" see :h vundle for more details or wiki for FAQ
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
" sometiems ctrlp working dir gets hosed, this supposed to fix it
let g:ctrlp_working_path_mode = 0
" Let's ignore version control and compiled files
let g:ctrlp_custom_ignore = {
\ 'dir':    '\v[\/](\.(git|hg|svn)|node_modules)$',
\ }

Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-rails'
Bundle 'mileszs/ack.vim'
Bundle 'gregsexton/MatchTag'
Bundle 'sleistner/vim-jshint'

" Change the mapleader from \ to ,
let mapleader=","
let maplocalleader="\\"

" Editing behaviour {{{
set clipboard=unnamedplus       " make copy/paste work with system clipboard
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=2                   " a tab is four spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
"set relativenumber              " shows how far each line is from the other
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
"hi NonText ctermfg=7 guifg=gray
"these listchars are cool but sucknards in terminal
"set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

"set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

set nrformats=                  " make <C-a> and <C-x> play well with
                                "    zero-padded numbers (i.e. don't consider
                                "    them octal or hex)
" Set the directory of the swap file
" The // indicates that the swap name should be globally unique
set directory=~/.vim/tmp//,/tmp

" golang development
" set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim " register linter
" autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow " run linter on save
au BufRead,BufNewFile *.go set list noexpandtab syntax=go listchars=tab:\ \ ,trail:▓
autocmd FileType go autocmd BufWritePre <buffer> Fmt


" Highlighting {{{
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" Thanks to Steve Losh for this liberating tip to fix regexes in searches
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
" noremap <up> <nop>
" noremap <down> <nop>
" noremap <left> <nop>
" noremap <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" use netrw as badass file explorer, taken from http://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
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
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
"set autochdir

" Color Scheme
set t_Co=256
color tomorrow_night
hi Search term=reverse cterm=reverse gui=reverse ctermfg=237


"if &term =~ '^xterm'
  " solid underscore
  let &t_SI .= "\<Esc>[4 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
"endif

" set the cursor to a vertical line in insert mode and a solid block
" " in command mode
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"


"===============================================================================
" Custom tab line
"===============================================================================
function! MyTabLabel(n)

  let label   =  ''

  let label  .=  '['                            

  let label  .=  a:n                             " set tab page number

  let buflist = tabpagebuflist(a:n)
  
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')             " unsaved modified buffer?
      let label .= '*'
      break
    endif
  endfor
  
  let wincount = tabpagewinnr(a:n, '$')          " number of windows in tab
  if wincount > '1'
    let label .= ', ' . wincount                  " report how many windows
  endif

  let label  .=  '] '                            " close bracket

  let winnr    = tabpagewinnr(a:n)               " focused window number
  let fullname = bufname(buflist[winnr - 1])     " absolute file name
  let filename = fnamemodify(fullname, ':t')     " basename

  if filename == ''                              " empty buffers have No Name
    let filename = '[No Name]'
  endif

  let label   .= filename                        " add filename to label

  return label

endfunction

function! MyTabLine()

  let s = ''

  for i in range(tabpagenr('$'))                 " for each open tab..

    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'                   " make active tab stand out 
    else
      let s .= '%#TabLine#'                      
    endif

    let s .= '%{MyTabLabel(' . (i + 1) . ')}'    " add tab label

    let s .= '%#TabLine#'                        " reset highlight

    if i + 1 != tabpagenr('$')
      let s .= ' '                             " fancy tab separator
    else
      let s .= ' '                             " except for the last tab
    endif

  endfor

  let s .= '%#TabLineFill#%T'                    " :help statusline

  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'                " right align the final 'X'
  endif

  return s

endfunction

:set tabline=%!MyTabLine()
