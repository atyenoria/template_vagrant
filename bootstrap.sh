#!/bin/sh

service iptables stop
chkconfig iptables off

rpm -ivh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
yum install -y vim

echo << TIME > /etc/sysconfig/clock
ZONE="Asia/Tokyo"
UTC="false"
TIME
source /etc/sysconfig/clock
/bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


#rbenv インストール
if [ ! -e '/home/vagrant/.rbenv' ]; then
    sudo yum -y install gcc-c++
    sudo yum -y install openssl-devel
    sudo yum -y install git
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    exec $SHELL -l
fi


# #ruby インストール
# if [ ! -e '/home/vagrant/.rbenv/plugins/ruby-build' ]; then
#     sudo yum -y install openssl-devel
#     sudo yum -y install ImageMagick-devel
#     sudo yum -y install libxml2-devel
#     sudo yum -y install libxslt-devel

#     echo 'gem: --no-ri --no-rdoc' > ~/.gemrc

#     source ~/.bashrc
#     git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#     rbenv install 2.0.0-p481
#     rbenv global 2.0.0-p481

#     git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
#     gem install bundler
#     gem install reditor
#     gem install execjs
# fi

#ruby インストール
git clone https://github.com/riywo/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
exec $SHELL -l
anyenv install rbenv
exec $SHELL -l

rbenv install -v 2.1.2
sudo yum -y install openssl openssl-devel
rbenv global 2.1.2

gem update --system
gem install rails --no-ri --no-rdoc -V
rbenv rehash
rails -v

