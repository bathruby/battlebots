# Battlebots

Setup for an AI-based tank game based on [RTanque](https://github.com/awilliams/RTanque)

## Requirements

- Ruby 2.1 or greater
- Bundler
- Gosu dependencies
  - Mac: https://github.com/jlnr/gosu/wiki/Getting-Started-on-OS-X
  - Linux: https://github.com/jlnr/gosu/wiki/Getting-Started-on-Linux
  - Windows: https://github.com/jlnr/gosu/wiki/Getting-Started-on-Windows

## Setup

```
$ git clone git@github.com:bathruby/battlebots.git
$ cd battlebots
$ bundle install
```

## Vagrant
If you don't have the dependencies installed or you are running on Windows, you can use Vagrant to create a Virtual Machine with all dependencies set up automatically. Install [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/), then run `vagrant up` from the root of this repository and you should see the VM start up & dependencies be downloaded and installed.

```
$ git clone git@github.com:bathruby/battlebots.git
$ cd battlebots
$ vagrant up
```

Once you see the GUI login menu appear (after a VM restart), log in with the "Vagrant" user, password "vagrant", open a terminal, `cd /vagrant` and start playing as below:

## How to play

Generate a new bot with:

`$ bundle exec rtanque new_bot my_deadly_bot`

Run a test match with:

`$ bundle exec rtanque start bots/my_deadly_bot sample_bots/keyboard sample_bots/camper:x2`

Then fork the project on GitHub and add your bot to the `bot` folder and send it back as a pull request.

Check out the RTanque documentation: http://www.rubydoc.info/github/awilliams/RTanque/ and existing bots: https://github.com/awilliams/RTanque/wiki/bot-gists
