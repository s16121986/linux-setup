## Setup installer

```shell
sudo apt -y install wget

wget -qO- https://raw.githubusercontent.com/s16121986/web-server-installer/wsl-debian/setup.sh | bash

alias wsi="/tmp/web-server-installer/wsi.sh"

wsi help
```

## WSL Setup

### 1. Install Debian (Windows Terminal)

```shell
 wsl --install debian
```

### 1. Disable sudo password

```shell
sudo visudo

# add rule for dev user
# dev ALL=(ALL) NOPASSWD: ALL
```

### 2. Enable systemd

```shell
[ -s /etc/wsl.conf ] || echo -e "[boot]\nsystemd=true" | sudo tee -a /etc/wsl.conf
```

### 3. Restart WSL (Windows Terminal)

```shell
wsl -t debian
```

### 4. Настройка редактора VIM

```vim
# create ~/.vimrc file in home directory with content:
"General
filetype plugin indent on
set nocompatible
set hidden
syntax enable

"Splits
set splitbelow
set splitright

"Mouse
set mouse=a
set mousehide

"Encoding
scriptencoding utf-8
set encoding=utf-8

"Indent
set smartindent
set copyindent

"Tabs
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"Visual
set number relativenumber
set wrap linebreak nolist
set showtabline=0
set cursorline

"Searching
set ignorecase
set smartcase

"Folding
set foldnestmax=10
set foldlevel=2
set nofoldenable
set foldlevelstart=0

"More CLI
set t_Co=256
set vb
set t_ut=""

```
