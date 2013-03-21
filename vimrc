if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocp  " close vi compatible mode
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread
set linebreak
set whichwrap=b,s,<,>,[,]       " 光标从行首和行末时可以跳到另一行去
set listchars=tab:./,trail:.   " 将制表符显示为.

set hlsearch
set incsearch

set smartindent
set autoindent

set ai! "自动缩进
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2    " always show the status line
set ruler           " 在编辑过程中，在右下角显示光标位置的状态行

"代码折叠
set foldmarker={,}
set foldmethod=syntax
set foldlevel=100       " Don't autofold anything (but I can still fold manually)
set foldopen-=search
set foldopen-=undo


filetype plugin indent on
set completeopt=longest,menu "关闭自动补全时的预览窗口

" Only do this part when compiled with support for autocommands
if has("autocmd")
	filetype plugin indent on
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

"删除末尾的空格，对python等很有用  
func! DeleteTrailingWS()  
	exe "normal mz"  
	%s/\s\+$//ge  
    exe "normal `z"  
endfunc  

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
"cscope shortcut, almost have conflict with vi commands, 'cs find' is recommanded
nmap <C-m>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-m>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-m>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-m>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-m>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-m>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-m>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-m>d :cs find d <C-R>=expand("<cword>")<CR><CR>


nmap <C-v>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-v>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-v>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-v>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-v>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-v>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-v>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-v>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on
filetype plugin indent on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cindent
set tags=tags
set tags+=./tags "add current directory's generated tags file

colorscheme desert

"short cut for search the cur word
nmap <S-f> /<C-R>=expand("<cword>")<CR><CR>

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Sort_Type = "name"	"tag以名字排序	
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Left_Window = 1         "在右侧窗口中显示taglist窗口 
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Process_File_Always = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Auto_Open = 0    "autoopen taglist => 1; not => 0
let Tlist_Auto_Update = 1    "自动更新taglist
let Tlist_Highlight_Tag = 1    "自动高亮当前的tag
map <silent> <F9> :TlistToggle<cr>

" short cut for change sub window
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"let g:ctags_path = '/usr/bin/ctags'   " 设置ctags.exe的路径
let g:ctags_statusline = 1            " 在状态栏显示函数名
let g:ctags_title = 1

" omin  mapping
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" c-x x-o 启动不全
" c-n 下翻 c-p上翻
inoremap <S-Tab> <C-x><C-o>

"open and close the quickfix window
nmap <C-c>c :cclose<cr>
nmap <C-c>v :copen<cr>

"直接按下<F3>键来查找光标所在的字符串
nnoremap <silent> <F3> :Rgrep<CR> 

nnoremap <silent> <F12> :A<CR>

"winManager
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <C-w>m :WMToggle<cr>

"miniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMoreThanOne=0

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936

set foldmethod=syntax
