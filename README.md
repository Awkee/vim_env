# VIM 部署过程
> 使用VIM进行Python开发的IDE环境配置版本管理.

## 用户环境配置

1. 在root用户下新增一个用户 `gituser` 并切换为该用户下.

```
root:~# useradd -m -g users -s /usr/bin/zsh gituser
root:~# su - gituser
```

2. 安装`oh-my-zh` 环境.

```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## 更换主题为`agnoster`, 更多关于该主题使用参考链接 https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

sed  -i 's#^ZSH_THEME=.*$#ZSH_THEME="agnoster"#g' ~/.zshrc

## 安装主题使用的powerline字体 #

cd $HOME

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# 手工修改终端字体设置为 `Hack` 或 `DejaVu Sans Mono`
Konsole->设置->编辑配置方案->外观->选择字体-> "Hack" -> 确定 -> 完成.

## 备份 .zshrc 文件
cp ~/.zshrc.old ~/.zshrc

## 修改默认编辑器为vim
echo "set -o vi" >> ~/.zshrc

## 修改 ${HOME}/.zshrc 文件, 增加 plugin插件配置
sed -i '/^plugins/,/)/s/*git*/git svn docker composer redis systemd python vi-mode/' ~/.zshrc


## 修改后,重新切换`gituser`用户即可生效.

```



## Vim 安装
> 源码安装环境


```
mkdir ~/github
cd ~/github
git clone https://github.com/vim/vim.git
cd vim
make distclean      ## 如果以前编译过需要执行此命令
./configure --enable-python3interp=yes  --prefix=$HOME/apps         ## 编译前的自动配置校验,会自动生成正确的Makefile , 如果需要支持python3则增加 --enable-python3interp=yes 选项


make -j$(nproc)
make install


echo 'export PATH=${HOME}/apps/bin:${PATH}' >> ~/.zshrc
echo 'export MANPATH=${HOME}/apps/share/man:${MANPATH}' >> ~/.zshrc

export PATH=${HOME}/apps/bin:${PATH}
export MANPATH=${HOME}/apps/share/man:${MANPATH}

which vim  <-- 将输出vim路径为'/home/gituser/apps/bin/vim'

```

**好的开始是成功的一半! 安装完毕VIM后我们可以开始一个简短的教程入门之旅了!**

`vimtutor` : 此命令会显示一份零基础vim的入门操作教程.


## Vim配置
> 通过自定义`.vimrc`文件我们可以更加容易根据自己的习惯使用Vim

先来看下初始状态下我们可以配置些什么吧

```
$ cat ~/.vimrc

```

## Vim插件管理
> 插件管理有多种选择(本次使用vundle进行使用介绍),例如: [vundle](http://github.com/gmarik/vundle) , [vim-update-bundles](http://github.com/bronson/vim-update-bundles), [Vimmer](https://github.com/densitypop/Vimmer),[vim-pathogen](http://github.com/tpope/vim-pathogen) and [tplugin_vim](http://github.com/tomtom/tplugin_vim).

### 安装vundle

```
mkdir -p $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

```

### 配置 .vimrc 文件

```
cat <<END >> ~/.vimrc
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
END

```

### 插件安装及配置
> 根据我们实际需要安装插件,并且按需配置变量及快捷键

安装插件方法: 先将插件名称添加到`.vimrc`文件中保存,再执行`:PluginInstall`命令即可自动安装新增插件名.

```
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""""""" 个性化选择插件列表 """"""""""
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Python-mode-klen'
Plugin 'taglist.vim'
Plugin 'flazz/vim-colorschemes'

:PluginInstall

cd $HOME/.vim/bundle/YouCompleteMe  && python3 install.py --clang-completer && cd -
```

## 更多快捷键操作

```
## 命令格式: operator + motion
c+i+) : Change Inside of parens(修改括号内的文本,不包括括号）, 查看更多方法`:help i)`
c+i+} : what ?

c+a+) : Change a parens(修改一对括号的文本,包括括号)
c+a+} : what ?

```

参考链接: http://vim-scripts.org/vim/tools.html

## 参考链接

- Konsole终端软件颜色方案设置: https://ciembor.github.io/4bit
- Vim脚本网站: http://vim-scripts.org


## 问题记录

如果安装Vim时提示如下错误时，我们需要安装下`ncurse`库即可。
```
checking for tgetent in -ltinfo... no
checking for tgetent in -lncurses... no
checking for tgetent in -ltermlib... no
checking for tgetent in -ltermcap... no
checking for tgetent in -lcurses... no
no terminal library found
checking for tgetent()... configure: error: NOT FOUND!
      You need to install a terminal library; for example ncurses.
      Or specify the name of the library with --with-tlib.
```




