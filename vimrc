""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 作者: awkee
" Email: xiaoyu0720@gmail.com
" Create Date: 2018/11/13 
" 源码地址: https://github.com/Awkee/awesome-shell-script.git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""" Vundle """"""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


""""""" 个性化选择插件列表 """"""""""
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Python-mode-klen'
Plugin 'taglist.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive' "Git Integration
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" Vundle


" tabs and spaces handling
"set expandtab  " <--此选项自动扩展tab为空格符号,建议不要默认开启
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tab length exceptions on some file types
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" 重定义<Leader>按键,默认为backslash(\) """"
" let mapleader = ","

set number
set colorcolumn=80
highlight ColorColumn ctermbg=3


" 语法高亮
syntax on

set hlsearch

" VIM 全局默认编码规则
set encoding=utf-8

" VIM 优先支持文件编码规则
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

"vim windows split navigations

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

set splitbelow
set splitright
map tsp :sp
map tsv :sv 
map tvs :vs 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab page navigation mappings
map tn :tabnext<CR>
map tp :tabprevious<CR>
map tc :tabclose<CR> 
map tm :tabmove 
map tt :tabnew 
map ts :tab split<CR>

map <C-Right> :tabn<CR>
imap <C-Right> <ESC>:tabn<CR>
map <C-Left> :tabp<CR>
imap <C-Left> <ESC>:tabp<CR>

""""""" 自动保存视图""""""""""""""""""""""""""""""""""""""""""""""
au BufWinLeave *.py silent mkview
au BufWinLeave *vimrc silent mkview
au BufWinEnter * silent loadview

map <Leader>l :loadview<CR>
map <Leader>m :mkview<CR>


""""""" 快捷键设置 shortcuts """""""""""""""""""""""""""""""""""""

"""""" 可视化模式下缩进 """""""""""""""""""""""""""""""""""""""""
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"""""" 更智能的 Home 按键 """"""""""""""""
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" 快捷查找 "
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>
"nnoremap <silent> <F3> :redir >>matches.tmp<CR>:g//<CR>:redir END<CR>:new matches.tmp<CR>

"""""" 斜线和反斜线快捷键""""""""""""""""""""
nnoremap <silent> <Leader>/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
nnoremap <silent> <Leader><Bslash> :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>

function! HTMLEncode()
perl << EOF
 use HTML::Entities;
 @pos = $curwin->Cursor();
 $line = $curbuf->Get($pos[0]);
 $encvalue = encode_entities($line);
 $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

function! HTMLDecode()
perl << EOF
 use HTML::Entities;
 @pos = $curwin->Cursor();
 $line = $curbuf->Get($pos[0]);
 $encvalue = decode_entities($line);
 $curbuf->Set($pos[0],$encvalue)
EOF
endfunction

nnoremap <Leader>h :call HTMLEncode()<CR>
nnoremap <Leader>H :call HTMLDecode()<CR>


" Enable folding
" manual,indent,expr,marker,syntax,diff
" shortcut , za:auto,zR:OpenAll,zM:CloseAll,zO:OpenAllInCursor,
" zC:CloseAllInCursor,zn:FoldingNone,zN:FoldingNormal .
" more help for fold-commands
set foldmethod=indent
set foldnestmax=10
set foldenable
set foldlevel=99
set foldcolumn=3
map <F10> :set foldmethod=manual<CR>

set magic
set confirm
set nobackup
set noswapfile

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)

" 高亮显示匹配的括号
set showmatch

" 增强模式中的命令行自动完成操作
set wildmenu

"代码补全
set completeopt=preview,menu

" 设置当文件被改动时自动载入
set autoread

" 自动重新加载 .vimrc 文件
" autocmd! bufwritepost .vimrc source %

set mouse=v
set selection=exclusive
set selectmode=mouse,key

map <F7> :set mouse=a<CR>
imap <F7> <ESC>:set mouse=a<CR>
map <F6> :set mouse=v<CR>
imap <F6> <ESC>:set mouse=v<CR>



"""""""""""""""""" Plugin Options """"""""""""""""""""""""""""""""

""""""  YouCompleteMe """""  自动补全
" let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


""""""  Python-mode """""""""""""""""""""""""""""
" for more :help python-mode

let g:pymode_run = 1
let g:pymode_python = 'python3'
let g:pymode_run_bind = '<F5>'
let g:pymode_motion = 1  " <--- Enable Python-mode motions-keys ,like [[,]],[M,]M,aC,iC,aM,iM

" python with virtualenv support
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion_bind = '<C-Space>'



"""""" NERDTree ----------------------------- 

" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" toggle nerdtree display
map <F9> :NERDTreeToggle<CR>


"""""" taglist.vim """""""""""""""""""""""
" show pending Tag list
map <F2> :Tlist<CR>
imap <F2> <ESC>:Tlist<CR>

nnoremap <silent> <F4> :!ctags 
"nnoremap <silent> <F4> :redir >>matches.tmp<CR>:g//<CR>:redir END<CR>:new matches.tmp<CR>

let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Sort_Type = "name"    " 按照名称排序
let Tlist_Show_One_File = 1     "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口
let Tlist_Compart_Format = 1    " 压缩方式
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_File_Fold_Auto_Close = 1  " 不要关闭其他文件的tags
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树
"默认打开Taglist
"let Tlist_Auto_Open=1

autocmd FileType h,cpp,cc,c,java,py set tags+=./tags


""""""  flazz/vim-colorschemes """""""""""""""
colorscheme wombat



""""""""""""""""""新文件标题""""""""""""""""""""""""""""""""""""""
" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.py,*.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
autocmd BufEnter *.pc,*.cp exec ":set syn=c"

""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\# File Name: ".expand("%"))
        call append(line(".")+2, "\# Author: zwker")
        call append(line(".")+3, "\# mail: xiaoyu0720@gmail.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")

    elseif &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python3")
        call append(line("."),"# -*- coding: utf-8 -*-")
        call append(line(".")+1, "\#########################################################################")
        call append(line(".")+2, "\# Author: zwker")
        call append(line(".")+3, "\# mail: xiaoyu0720@gmail.com")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")

    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: zwker")
        call append(line(".")+2, "    > Mail: xiaoyu0720@gmail.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif

    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc


"""""""""""""""" 自定义tags文件操作函数 """""""""""""""""""""""""
" Read file and search each line for all occurrences of pattern.
" Return list of search hits.
" Each item in list is a list: [linenr, colnr, match]
" 使用方法: new call setline(1, MakeTags('*.txt', '\<\h\w*'))
"
function! SearchFile(file, pattern)
  let results = []
  let lines = readfile(a:file)
  for linenr in range(len(lines))
    let line = lines[linenr]
    let i = 1
    while 1
      let p1 = match(line, a:pattern, 0, i)
      if p1 < 0
        break
      endif
      let p2 = matchend(line, a:pattern, 0, i)
      call add(results, [linenr+1, p1+1, strpart(line, p1, p2-p1)])
      let i += 1
    endwhile
  endfor
  return results
endfunction

" Search each file in filespec (e.g. '*.txt') for all occurrences of pattern.
" Return list of lines suitable for a tags file.
function! MakeTags(filespec, pattern)
  let tags = []
  for file in glob(a:filespec, 0, 1)
    for hit in SearchFile(file, a:pattern)
      call add(tags, printf("%s\t%s\t/\\%%%dl\\%%%dc/", hit[2], file, hit[0], hit[1]))
    endfor
  endfor
  return sort(tags)
endfunction


" End of .vimrc
