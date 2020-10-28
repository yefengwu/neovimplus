#!/bin/bash

# 获取linux发行版名称
function get_linux_distro()
{
    if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
    elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
    elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
    elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
    elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
    elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
    elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
    elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
    elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
    elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
    elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
    else
        echo "Unknow"
    fi
}

# linux换源
function change_linux_mirror()
{
    current_mirror=`cat /etc/apt/sources.list | grep -oE "(http:\/\/|https:\/\/)((\w|=|\?|\.|&|-)+)" -m1`
    if [ $current_mirror != "https://mirrors.aliyun.com" ];then
       read -p 'Do you want to change to aliyun_mirror? y/n' ch
       case $ch in 
        N|n)
          echo 'Please make sure your network access is normal';;
        *)
          change_to_aliyun_mirror
       esac
    fi
}

#更换到阿里云源
function change_to_aliyun_mirror()
{
  version=$(get_ubuntu_version)
  case $version in 
    16)
      cp -f $PWD/repos/aliyun/sources.list-1604 /etc/apt/sources.list;;
    18)
      cp -f $PWD/repos/aliyun/sources.list-1804 /etc/apt/sources.list;;
    20)
      cp -f $PWD/repos/aliyun/sources.list-2004 /etc/apt/sources.list
  esac
}

# 获取日期
function get_datetime()
{
    time=$(date "+%Y%m%d%H%M%S")
    echo $time
}

# 判断文件是否存在
function is_exist_file()
{
    filename=$1
    if [ -f $filename ]; then
        echo 1
    else
        echo 0
    fi
}

# 判断目录是否存在
function is_exist_dir()
{
    dir=$1
    if [ -d $dir ]; then
        echo 1
    else
        echo 0
    fi
}

# 在linux上获取当前用户
function get_current_username_on_linux()
{
    current_path=$PWD
    array=(${current_path//// })

    if [ ${array[0]} == "root" ]; then 
        echo ${array[0]}
    else
        echo ${array[1]}
    fi
}

#备份原有的init.vim文件
function backup_init_vim_file()
{
    old_init_vim=$HOME"/.config/nvim/init.vim"
    is_exist=$(is_exist_file $old_init_vim)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vimrc=$old_init_vim"_bak_"$time
        read -p "Find "$old_init_vim" already exists,backup "$old_init_vim" to "$backup_init_vim"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_init_vim $backup_init_vim
        fi
    fi
}

#备份原有的init.vim.custom.plugins文件
function backup_init_vim_custom_plugins_file()
{
    old_init_vim_plugins=$HOME"/.config/nvim/.init.vim.custom.plugins"
    is_exist=$(is_exist_file $old_init_vim_plugins)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_init_vim_plugins=$old_init_vim_plugins"_bak_"$time
        read -p "Find "$old_init_vim_plugins" already exists,backup "$old_init_vim_plugins" to "$backup_init_vim_plugins"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_init_vim_plugins $backup_init_vim_plugins
        fi
    fi
}

#备份原有的.init.vim.custom.conf文件
function backup_init_vim_custom_config_file()
{
    old_init_vim_config=$HOME"/.config/nvim/.init.vim.custom.conf"
    is_exist=$(is_exist_file $old_init_vim_config)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_init_vim_config=$old_init_vim_config"_bak_"$time
        read -p "Find "$old_init_vim_config" already exists,backup "$old_init_vim_config" to "$backup_init_vim_config"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_init_vim_config $backup_init_vim_config
        fi
    fi
}


#备份原有的.init.vim.plugin.conf文件
function backup_init_vim_plugin_config_file()
{
    old_init_vim_config=$HOME"/.config/nvim/.init.vim.plugin.conf"
    is_exist=$(is_exist_file $old_init_vim_config)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_init_vim_config=$old_init_vim_config"_bak_"$time
        read -p "Find "$old_init_vim_config" already exists,backup "$old_init_vim_config" to "$backup_init_vim_config"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_init_vim_config $backup_init_vim_config
        fi
    fi
}

#备份原有的.local/share/nvim目录
function backup_nvim_dir()
{
    old_nvim=$HOME"/.local/share/nvim"
    is_exist=$(is_exist_dir $old_nvim)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vim=$old_nvim"_bak_"$time
        read -p "Find "$old_nvim" already exists,backup "$old_nvim" to "$backup_nvim"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp -R $old_nvim $backup_nvim
        fi
    fi
}

# 备份原有的init.vim和nvim
function backup_init_vim_and_nvim()
{
    backup_init_vim_file
    backup_init_vim_custom_plugins_file
    backup_init_vim_custom_config_file
    backup_init_vim_plugin_config_file
    backup_nvim_dir
}

# 获取ubuntu版本
function get_ubuntu_version()
{
    line=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    arr=(${line//=/ })
    version=(${arr[1]//./ })

    echo ${version[0]}
}

# 获取centos版本
function get_centos_version()
{
    version=`cat /etc/redhat-release | awk '{print $4}' | awk -F . '{printf "%s",$1}'`
    echo $version
}

# 判断是否是macos10.14版本
function is_macos1014()
{
    product_version=$(sw_vers | grep ProductVersion)
    if [[ $product_version =~ "10.14" ]]; then
        echo 1
    else
        echo 0
    fi
}

# 在ubuntu上源代码安装vim
function compile_vim_on_ubuntu()
{
    sudo apt-get install -y libncurses5-dev libncurses5 libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 lua5.1-dev

    rm -rf ~/vim82
    git clone https://gitee.com/chxuan/vim82.git ~/vim82
    cd ~/vim82
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 在debian上源代码安装vim
function compile_vim_on_debian()
{
    sudo apt-get install -y libncurses5-dev libncurses5 libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 lua5.1-dev

    rm -rf ~/vim82
    git clone https://gitee.com/chxuan/vim82.git ~/vim82
    cd ~/vim82
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 在centos上源代码安装vim
function compile_vim_on_centos()
{
    sudo yum install -y ruby ruby-devel lua lua-devel luajit \
        luajit-devel ctags git python python-devel \
        python34 python34-devel tcl-devel \
        perl perl-devel perl-ExtUtils-ParseXS \
        perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
        perl-ExtUtils-Embed libX11-devel ncurses-devel
    
    rm -rf ~/vim82
    git clone https://gitee.com/chxuan/vim82.git ~/vim82
    cd ~/vim82
    ./configure --with-features=huge \
        --enable-multibyte \
        --with-tlib=tinfo \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=/lib64/python2.7/config \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 安装mac平台必备软件
function install_prepare_software_on_mac()
{
    xcode-select --install

    brew install vim gcc cmake ctags-exuberant ack

    macos1014=$(is_macos1014)
    if [ $macos1014 == 1 ]; then
        open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg
    fi
}


# 安装ubuntu必备软件
function install_prepare_software_on_ubuntu()
{
  if [ -f $HOME/.bashrc ];then
    echo 'export NVIM_CONFIG_PATH=$HOME/.config/nvim' >> $HOME/.bashrc
    echo '[ -f ~/.aliases ] && source ~/.aliases' >> $HOME/.bashrc
  elif [ -f $HOME/.zshrc ];then
    echo 'export NVIM_CONFIG_PATH=$HOME/.config/nvim' >> $HOME/.zshrc
    echo '[ -f ~/.aliases ] && source ~/.aliases' >> $HOME/.bashrc
  fi

  username=$(get_current_username_on_linux)
  if [ $username == "root" ];then
    root_user_prepare_software_on_ubuntu
  else
    common_user_prepare_software_on_ubuntu
  fi
}

function some_other_config()
{
  wget https://raw.githubusercontent.com/yefengwu/profile/master/linux/aliases -O $HOME/.aliases
  wget https://nodejs.org/dist/v12.18.2/node-v12.18.2-linux-x64.tar.xz -P /opt/local &&
      tar xf /opt/local/node-v12.18.2-linux-x64.tar.xz -C /opt/local &&
      ln -s /opt/local/node-v12.18.2-linux-x64/bin/* /usr/local/bin
}

function common_user_prepare_software_on_ubuntu()
{
    sudo apt-get update

    version=$(get_ubuntu_version)
    if [ $version -eq 14 ];then
        sudo apt-get install -y cmake3
    else
        sudo apt-get install -y cmake
    fi

    sudo apt-get install -y exuberant-ctags wget curl build-essential python python-dev python3-dev fontconfig libfile-next-perl ack-grep git

    if [ $version -ge 20 ];then
        sudo apt-get install -y neovim
    else
        compile_vim_on_ubuntu
    fi
 
}

function root_user_prepare_software_on_ubuntu()
{
    apt-get update
    apt-get install -y exuberant-ctags curl wget build-essential python python-dev python3-dev fontconfig libfile-next-perl ack-grep git neovim
}

# 安装ubuntu系必备软件
function install_prepare_software_on_ubuntu_like()
{
    sudo apt-get update
    sudo apt-get install -y cmake exuberant-ctags build-essential python python-dev python3-dev fontconfig libfile-next-perl ack-grep git
    compile_vim_on_ubuntu
}

# 安装debian必备软件
function install_prepare_software_on_debian()
{
    sudo apt-get update
    sudo apt-get install -y cmake exuberant-ctags build-essential python python-dev python3-dev fontconfig libfile-next-perl ack git
    compile_vim_on_debian
}

# 安装centos必备软件
function install_prepare_software_on_centos()
{
    version=$(get_centos_version)
    if [ $version -ge 8 ];then
        sudo dnf install -y epel-release
        sudo dnf install -y vim ctags automake gcc gcc-c++ kernel-devel make cmake python2 python2-devel python3-devel fontconfig ack git
    else
        sudo yum install -y ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
        compile_vim_on_centos
    fi
}

# 安装fedora必备软件
function install_prepare_software_on_fedora()
{
    sudo dnf install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
}

# 安装archlinux必备软件
function install_prepare_software_on_archlinux()
{
    sudo pacman -S --noconfirm vim ctags automake gcc cmake python3 python2 ack git fontconfig
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

# 安装gentoo必备软件
function install_prepare_software_on_gentoo()
{
    install_software_on_gentoo app-editors/vim dev-util/ctags sys-devel/automake sys-devel/gcc dev-util/cmake sys-apps/ack dev-vcs/git media-libs/fontconfig
    su - -c "ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5" -s /bin/bash
}

function install_software_on_gentoo()
{
    pkgs=$*
    pkg_need_install=""
    for pkg in ${pkgs}
    do
        if qlist -I | grep -Eq $pkg; then
            echo "$pkg is already installed."
        else
            pkg_need_install="$pkg_need_install $pkg"
        fi
    done

    if sudo -l | grep -Eq "emerge"; then
        sudo emerge -v $pkg_need_install 
    else
        echo "Need Root password:"
        su - -c "emerge -v $pkg_need_install" -s /bin/bash
    fi
}

# 安装opensuse必备软件
function install_prepare_software_on_opensuse()
{
    sudo zypper install -y vim ctags gcc gcc-c++ cmake python-devel python3-devel ack fontconfig git ncurses5-devel
}

#创建相关的nvim目录
function create_directory_for_neovim()
{
  if [ ! -d ~/.config/nvim ] && [ ! -d ~/.local/share/nvim ];then
    mkdir -p ~/.config/nvim
    mkdir -p ~/.local/share/nvim
  fi
}

# 拷贝文件
function copy_files()
{
    rm -rf ~/.config/nvim/init.vim
    cp -rf ${PWD}/init.vim ~/.config/nvim

    rm -rf ~/.config/nvim/init.vim.custom.plugins
    cp ${PWD}/init.vim.custom.plugins ~/.config/nvim
    
    rm -rf ~/.config/nvim/init.vim.custom.conf
    cp ${PWD}/init.vim.custom.conf ~/.config/nvim
    
    rm -rf ~/.config/nvim/init.vim.plugin.conf
    cp ${PWD}/init.vim.plugin.conf ~/.config/nvim

    mkdir -p ~/.local/share/nvim/colors
    rm -rf ~/.local/share/nvim/colors
    cp -rf ${PWD}/colors ~/.local/share/nvim

    rm -rf ~/.local/share/nvim/ftplugin
    cp -rf ${PWD}/ftplugin ~/.local/share/nvim

    rm -rf ~/.local/share/nvim/site/autoload
    mkdir ~/.local/share/nvim/site
    cp -rf ${PWD}/autoload ~/.local/share/nvim/site
}

# 安装mac平台字体
function install_fonts_on_mac()
{
    rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/Library/Fonts
}

# 安装linux平台字体
function install_fonts_on_linux()
{
    mkdir -p ~/.local/share/fonts
    rm -rf ~/.local/share/fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/.local/share/fonts

    fc-cache -vf ~/.local/share/fonts
}

# 安装vim插件
function install_neovim_plugin()
{
    vim -c "PlugInstall" -c "q" -c "q"
}

# 安装ycm插件
function install_ycm()
{
    git clone https://gitee.com/chxuan/YouCompleteMe-clang.git ~/.vim/plugged/YouCompleteMe

    cd ~/.vim/plugged/YouCompleteMe

    read -p "Please choose to compile ycm with python2 or python3, if there is a problem with the current selection, please choose another one. [2/3] " version
    if [[ $version == "2" ]]; then
        echo "Compile ycm with python2."
        python2.7 ./install.py --clang-completer
    else
        echo "Compile ycm with python3."
        python3 ./install.py --clang-completer
    fi
}


# 打印logo
function print_logo()
{
    color="$(tput setaf 6)"
    normal="$(tput sgr0)"
    printf "${color}"
    echo '                          __                __          '
    echo '   ____  ___  ____ _   __/_/___ ___  ____  / /_  _______'
    echo '  / __ \/ _ \/ __ \ | / / / __ `__ \/ __ \/ / / / / ___/' 
    echo ' / / / /  __/ /_/ / |/ / / / / / / / /_/ / / /_/ /__  / ' 
    echo '/_/ /_/\___/\____/|___/_/_/ /_/ /_/ .___/_/\__,_/____/  ' 
    echo '                                 /_/						       	...is now installed '
    echo ''
    echo 'Just enjoy it!'
    echo 'p.s. Follow me at https://github.com/chxuan.'
    echo ''
    printf "${normal}"
}

# 在mac平台安装vimplus
function install_vimplus_on_mac()
{
    backup_vimrc_and_vim
    install_prepare_software_on_mac
    copy_files
    install_fonts_on_mac
    install_ycm
    install_vim_plugin
    print_logo
}


# 开始安装vimplus
function begin_install_neovimplus()
{
    copy_files
    install_fonts_on_linux
    install_neovim_plugin
    print_logo
}

# 在ubuntu上安装neovimplus
function install_neovimplus_on_ubuntu()
{
    change_linux_mirror
    backup_init_vim_and_nvim
    create_directory_for_neovim
    install_prepare_software_on_ubuntu
    #some_other_config
    begin_install_neovimplus
}

# 在ubuntu系上安装vimplus
function install_vimplus_on_ubuntu_like()
{
    backup_vimrc_and_vim
    install_prepare_software_on_ubuntu_like
    begin_install_vimplus
}

# 在debian上安装vimplus
function install_vimplus_on_debian()
{
    backup_vimrc_and_vim
    install_prepare_software_on_debian
    begin_install_vimplus
}

# 在centos上安装vimplus
function install_vimplus_on_centos()
{
    backup_vimrc_and_vim
    install_prepare_software_on_centos
    begin_install_vimplus
}

# 在fedora上安装vimplus
function install_vimplus_on_fedora()
{
    backup_vimrc_and_vim
    install_prepare_software_on_fedora
    begin_install_vimplus
}

# 在archlinux上安装vimplus
function install_vimplus_on_archlinux()
{
    backup_vimrc_and_vim
    install_prepare_software_on_archlinux
    begin_install_vimplus
}

# 在Gentoo上安装vimplus
function install_vimplus_on_gentoo()
{
    backup_vimrc_and_vim
    install_prepare_software_on_gentoo
    begin_install_vimplus
}

# 在opensuse上安装vimplus
function install_vimplus_on_opensuse()
{
    backup_vimrc_and_vim
    install_prepare_software_on_opensuse
    begin_install_vimplus
}

# 在linux平上台安装vimplus
function install_neovimplus_on_linux()
{
    distro=`get_linux_distro`
    echo "Linux distro: "${distro}

    if [ ${distro} == "Ubuntu" ]; then
        install_neovimplus_on_ubuntu
    elif [ ${distro} == "Deepin" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "LinuxMint" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "elementaryOS" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "Debian" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "UOS" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "Kali" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "CentOS" ]; then
        install_vimplus_on_centos
    elif [ ${distro} == "fedora" ]; then
        install_vimplus_on_fedora
    elif [ ${distro} == "openSUSE" ]; then
        install_vimplus_on_opensuse
    elif [ ${distro} == "ArchLinux" ]; then
        install_vimplus_on_archlinux
    elif [ ${distro} == "ManjaroLinux" ]; then
        install_vimplus_on_archlinux
    elif [ ${distro} == "Gentoo" ]; then
        install_vimplus_on_gentoo
    else
        echo "Not support linux distro: "${distro}
    fi
}

# 获取当前时间戳
function get_now_timestamp()
{
    cur_sec_and_ns=`date '+%s-%N'`
    echo ${cur_sec_and_ns%-*}
}

# main函数
function main()
{
    begin=`get_now_timestamp`

    type=$(uname)
    echo "Platform type: "${type}
    if [ ${type} == "Darwin" ]; then
        install_vimplus_on_mac
    elif [ ${type} == "Linux" ]; then
        install_neovimplus_on_linux
    else
        echo "Not support platform type: "${type}
    fi

    export NVIM_CONFIG_PATH=$HOME/.config/nvim
    end=`get_now_timestamp`
    second=`expr ${end} - ${begin}`
    min=`expr ${second} / 60`
    echo "It takes "${min}" minutes."
}

# 调用main函数
main
