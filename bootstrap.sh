#!/bin/bash
set -x; #echo on

#Ideally would use Ansible to do this stuff instead of a shell script. But the Ansible Controller-server can't be windows, so direct provisioning using vagrant doesn't work.
# Possible workaround here boots VM then runs ansible locally to complete the rest of the setup: https://groups.google.com/forum/#!topic/vagrant-up/3fNhoow7mTE

apt-get update;
apt-get install -q -y htop git jq;

#Add a GUI
sudo apt-get install -q -y xorg gnome-core gnome-system-tools gnome-app-install


#Ruby dependencies (https://gorails.com/setup/ubuntu/14.04):
apt-get install -q -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
#Gosu dependencies (): 
apt-get install -q -y build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libfreeimage-dev libopenal-dev libsndfile-dev;
#texplay dependencies:
apt-get install -q -y freeglut3-dev

apt-get install -q -y ruby-dev;

gem install bundler

cd /vagrant;
bundler install;