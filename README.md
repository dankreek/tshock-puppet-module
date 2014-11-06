# terraria

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with terraria](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A module that downloads and installs the TShock Terraria server.

## Module Description

Intalls the TShock Terraria server as well as an Upstart config file to allow for starting and stopping the service.

This module deploys a script in the TShock installation directory called `start.sh` which contains all the configurable command line options. The Upstart configuration runs `GNU Screen` as the `root` user and then launches the TShock server inside of it as the service user specified by configuration.

## Setup

To use this module you will simply need a machine running Ubuntu 14.04. TShock will be installed as an Upstart service so the `start`, `stop`, and `restart` commands all work.

## Usage

Adding the `tshock` class to a node definition should be all you need to get going with the defaults. 

```
    class { 'tshock': }
```

Parameters which control how the server is started. If the parameter is not specified then the default is used. 


| Parameter   | Default     | Description
| ----------- | ----------- | ------------------------------------
| install_loc | /opt/tshock | The location where TShock is installed
| user        | tshock      | The user that TShock precess is run as
| ip          | 0.0.0.0     | The IP address that the server is bound to, `0.0.0.0` indicates to bind to all available interfaces.
| port        | 7777        | The port that the server will listen on
| maxplayers  | 8           | The maximum number of players that can join the server
| world       | default.wld | The file name of the world to start. It will be created if it doesn't currently exist
| world_path  | `$install_loc`/Terraria/Worlds | The absolute path to where world files are to be stored
| world_size  | 1           | The size of the world if one it to be created. 1=small, 2=medium and 3=large. If the world already exists then this parameter is ignored
| language    | English     | The language that is spoken on the server
| conn_per_ip | 8           | The number of connections allowed per IP address

## Reference

For more information on TShock see their site at at http://tshock.co/xf/index.php . This module installs TSHock version 4.2.3.0720.

## Limitations

This module has only been tested on Ubuntu Server 14.04, but should work on any version of Ubuntu based on upstart. 

In this early version of the module I wasn't able to smartly send a signal to the TShock server to shut down, so currently when the stop signal is sent to the TShock upstart job, the _exit_ command is pushed into the screen session along with the _enter_ key to simulate a user typing _exit_ in the TShock console. Hopefully in a future version I will be able to capture the TShock PID and be more intelligent about this.

## Development

Please see the [Github repository](https://github.com/dankreek/tshock-puppet-module) to contribute or raise issues.

## Release Notes/Contributors/Etc 

* Version 0.0.1
  * November 5, 2014
  * Initial release to the Puppet Forge.
* Version 0.0.2
  * November 5, 2014
  * Documentation added.

