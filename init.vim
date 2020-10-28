" === Auto load for first time uses
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"{{{设置代码缩进与排版
set autoindent               " 设置自动缩进
set cindent                  " 设置使用C/C++语言的自动缩进方式
                             " 设置使用C/C++语言的具体缩进方式
set cinoptions=g0,:0,N-s,(0)
set smartindent              " 智能选择对齐方式
filetype indent on           " 自适应不同语言的智能缩进
set expandtab                " 将制表符扩展为空格
set tabstop=2                " 设置编辑时制表符所占的空格数
set shiftwidth=2             " 设置格式化时制表符占用的空格数
set softtabstop=2            " 设置4个空格为制表符
set smarttab                 " 在行和段开始处使用制表符
set wrap                     " 折行
set backspace=2              " 使用回车键正常处理indent.eol,start等
set scrolloff=5
set cursorline               "高亮光标所在行
hi CursorLine   cterm=NONE ctermbg=240 ctermfg=white guibg=darkred guifg=white
set number      "开启行号显示
set relativenumber "开启相对行号
let mapleader = "," "定义<leader>键
"}}}

"{{{缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup        "设置不备份
set noswapfile      "禁止生成临时文件
set autoread        "文件在vim之外修改过，自动重新载入
set autowrite       "设置自动保存
set confirm         "在处理未保存或只读文件时，弹出确认
"}}}

"{{{ 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
"}}}

"{{{ 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "," "定义<leader>键
filetype plugin on  "加载对应文件类型插件
filetype indent on
filetype plugin indent on
set nocompatible    "设置不兼容原始vi模式
filetype on     "设置开启文件类型侦测
set noeb        "关闭错误提示
syntax enable       "开启语法高亮功能
syntax on       "自动语法高亮
set t_Co=256        "开启256色支持
set showcmd     "select模式下显示选中的行数
set ruler       "总是显示光标的位置
set laststatus=2    "总是显示状态栏
set number      "开启行号显示
set relativenumber "开启相对行号
set ignorecase   "忽略大小写"
set whichwrap+=<,>,h,l  "设置光标键跨行
set virtualedit=block,onemore   "允许光标出现在最后一个字符的后面
set guifont=DroidSansMono_Nerd_Font:h11   "设置字体
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "保留上次打开文件的位置"
hi MatchParen ctermbg=DarkRed guibg=lightblue
"set list
"set listchars=tab:▸\ ,trail:▫
set mouse=a
inoremap <leader>a :set mouse=a<cr>
nnoremap <leader>a :set mouse=a<cr>
inoremap <leader>v :set mouse=v<cr>
nnoremap <leader>v :set mouse=v<cr>
set backspace=indent,eol,start
let loaded_matchparen=1 "关闭括号自动高亮
nnoremap <space>v <c-v>
"}}}


"{{{Tab management
" Create a new tab with tu
map te :tabe<CR>
" Move around tabs with tn and ti
map tn :-tabnext<CR>
map tp :+tabnext<CR>
" Move the tabs with tmn and tmi
map tmn :-tabmove<CR>
map tmi :+tabmove<CR>
"Close the tab
map tc :+tabc<CR>   "close current tab
map to :+tabo<CR>   "close all other tab
map ts :+tabs<CR>   "close all open tab
"}}}

"{{{优化设置
"设置y从vim复制到剪切板
set clipboard+=unnamed 
"映射 esc 键为 jj
imap jj <Esc>
"快速打开vim配置文件：_vimrc
nnoremap <leader>e :e $HOME/.config/nvim/init.vim<cr>
"刷新配置
nnoremap <leader>r :source $MYVIMRC<cr>
" 插入模式、正常模式按 Ctrl+u 快速转换为大写
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
" 插入模式、正常模式按 Ctrl+u+u 快速转换为小写
inoremap <c-u><c-u> <esc>viwuea
nnoremap <c-u><c-u> viwue

"Ctrl+d 复制本行并粘贴到一下行
nnoremap <c-d> yyp

" <leader>+q 快速退出vim
nmap <leader>q :q!<cr>
nmap <leader>w :w!<cr>
imap <leader>q <Esc>:q!<cr>
imap <leader>w <Esc>:w!<cr>

"insert move
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

"复制模式进入和退出
nnoremap <leader><leader>v :set paste<cr>
inoremap <leader><leader>v <Esc>:set paste<cr>
"插入模式快速到另一个字符右边，对于配对的符号（如括号）很有用
imap <c-a> <Esc>LA
"插入模式移动到下一行
imap <c-o> <Esc>o
"移动到末尾
imap <c-e> <Esc>A
"关闭record
map q <nop>
"若打开分割窗口，可快速切换窗口
"快捷键提示：Ctrl+w w 切换窗口; Ctrl+w s 水平分割; Ctrl+w v 竖直分割
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"buffer change
nnoremap <c-n> :bn<cr>
"nnoremap <c-p> :bp<cr>
nnoremap <leader>d :bd<cr>

"设置跳出自动补全的括号
func SkipBracker()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc


" 将tab键绑定为跳出括号
inoremap <leader><tab> <c-r>=SkipBracker()<CR>
"}}}

"设置特殊文件格式的语法高亮，格式之间使用逗号隔开
"例如 *.txt,*.conf
if has("autocmd")
       autocmd BufNewFile,Bufread *.conf,*.txt set syntax=vim
endif

"{{{插件安装区---------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'                       "简单状态栏
Plug 'tmhedberg/SimpylFold'                        " 代码折叠
Plug 'scrooloose/nerdtree',{'on':'NERDTreeToggle'} " 文件管理器
Plug 'Xuyuanp/nerdtree-git-plugin'                 " 显示 git 管理的项目文件变更状态
Plug 'machakann/vim-highlightedyank'               " 高亮复制区域
Plug 'flazz/vim-colorschemes'                      " 主题颜色
Plug 'chxuan/change-colorscheme'
Plug 'jiangmiao/auto-pairs'                        " 自动引号括号补全
Plug 'terryma/vim-multiple-cursors'                " 多点编辑
Plug 'scrooloose/nerdcommenter'                    " 注释插件
Plug 'haya14busa/incsearch.vim'                    " 搜索插件
Plug 'rhysd/clever-f.vim'                          " 强化f/t
"Plug 'vim-scripts/LargeFile'                       " 快速打开大文件
Plug 'easymotion/vim-easymotion'                   " 强化版检索式移动
Plug 'terryma/vim-expand-region'                   " 区域选中
Plug 'majutsushi/tagbar'                           " 阅读项目
Plug 'tpope/vim-endwise'                           " 自动补全end关键字
Plug 'vim-syntastic/syntastic'                     " 语法检查
Plug 'godlygeek/tabular'                           " 文本对齐
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }       "模糊搜索
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'   "彩色显示括号对
Plug 'mileszs/ack.vim'    "在项目中全局搜索某个词   
Plug 'https://gitee.com/yefengwu/markdown-preview.nvim',{ 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}     "markdown preview
Plug 'dhruvasagar/vim-table-mode'         "markdown table
Plug 'SirVer/ultisnips'           "片段
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'

" 加载自定义插件
if filereadable(expand("$HOME/.config/nvim/init.vim.custom.plugins"))
    source $HOME/.config/nvim/init.vim.custom.plugins
endif

call plug#end()
" ******************************END******************************
" VimPlug快捷键：安装、更新、删除插件
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>u :PlugUpdate<cr>
nnoremap <leader><leader>c :PlugClean<cr>
"}}}

"加载配置
if filereadable(expand($NVIM_CONFIG_PATH . '/init.vim.custom.conf'))
    source $NVIM_CONFIG_PATH/init.vim.custom.conf
endif
if filereadable(expand($NVIM_CONFIG_PATH . '/init.vim.plugin.conf'))
    source $NVIM_CONFIG_PATH/init.vim.plugin.conf
endif
if filereadable(expand($NVIM_CONFIG_PATH . '/init.vim.author.conf'))
    source $NVIM_CONFIG_PATH/init.vim.author.conf
endif


