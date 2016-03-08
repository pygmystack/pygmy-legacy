# dory

[Dory](https://github.com/FreedomBen/dory) wraps [codekitchen/dinghy-http-proxy](https://github.com/codekitchen/dinghy-http-proxy) and makes it easily
available for use on Linux.  This way you can work comfortably
side by side on [docker](https://github.com/docker/docker)/[docker-compose](https://github.com/docker/compose) with your colleagues
who run OS X.

Specifically, dory will:

* Fire up the nginx proxy in a daemonized docker container for you
* Configure and start a local dnsmasq to forward DNS queries for
your local domain to the nginx proxy
* Configure your local DNS resolver to point to the local dnsmasq

## Installation

```bash
gem install dory
```

## Usage

Dory has a small selection of commands that are hopefully intuitive.  To customize and fine-tune dory's behavior, it can be configured with a yaml config file.


### Commands
```
Commands:
  dory config-file     # Write a default config file
  dory down            # Stop all dory services
  dory help [COMMAND]  # Describe available commands or one specific command
  dory restart         # Stop and restart all dory services
  dory status          # Report status of the dory services
  dory up              # Bring up dory services (nginx-proxy, dnsmasq, resolv)
  dory version         # Check current installed version of dory

Options:
  v, [--verbose], [--no-verbose]  
```

### Config file

Default config file which should be placed at `~/.dory.yml` (can be generated with `dory config-file`):

```yaml
---
:dory:
  # Be careful if you change the settings of some of
  # these services.  They may not talk to each other
  # if you change IP Addresses.
  # For example, resolv expects a nameserver listening at
  # the specified address.  dnsmasq normally does this,
  # but if you disable dnsmasq, it
  # will make your system look for a name server that
  # doesn't exist.
  :dnsmasq:
    :enabled: true
    :domain: docker      # domain that will be listened for
    :address: 127.0.0.1  # address returned for queries against domain
    :container_name: dory_dnsmasq
  :nginx_proxy:
    :enabled: true
    :container_name: dory_dinghy_http_proxy
  :resolv:
    :enabled: true
    :nameserver: 127.0.0.1
```

## Is this dinghy for Linux?

No. Well, maybe sort of, but not really.  [Dinghy](https://github.com/codekitchen/dinghy) has a lot of responsibilities on OS X, most of which are not necessary on Linux since docker runs natively.  Something it does that can benefit linux users however, is the setup and management of an [nginx reverse HTTP proxy](https://www.nginx.com/resources/admin-guide/reverse-proxy/).  Using full dinghy on Linux for local development doesn't really make sense to me, but using a reverse proxy does.  Furthermore, if you work with other devs who run Dinghy on OS X, you will have to massage your (docker-compose)[https://docs.docker.com/compose/] files to avoid conflicting.  By using  [dory](https://github.com/FreedomBen/dory), you can safely use the same `VIRTUAL_HOST` setup without conflict.  And because dory uses [dinghy-http-proxy](https://github.com/codekitchen/dinghy-http-proxy) under the hood, you will be as compatible as possible.

## Are there any reasons to run full dinghy on Linux?

Generally speaking, IMHO, no.  The native experience is superior.  However, for some reason maybe you'd prefer to not have docker on your local machine?  Maybe you'd rather run it in a VM?  If that describes you, then maybe you want full dinghy.

I am intrigued at the possibilities of using dinghy on Linux to drive a cloud-based docker engine.  For that, stay tuned.

## Why didn't you just fork dinghy?

That was actually my first approach, and I considered it quite a bit.  As I went through the process in my head tho, and reviewed the dinghy source code, I decided that it was just too heavy to really fit the need I had.  I love being able to run docker natively, and I revere [the Arch Way](https://wiki.archlinux.org/index.php/The_Arch_Way).  Dinghy just seemed like too big of a hammer for this problem (the problem being that I work on Linux, but my colleagues use OS X/Dinghy for docker development).

## What if I'm developing on a cloud server?

You do this too!?  Well fine hacker, it's your lucky day because dory has you covered.  You can run the nginx proxy on the cloud server and the dnsmasq/resolver locally.  Here's how:

* Install dory on both client and server:
```
gem install dory
```
* Gen a base config file:
```
dory config-file
```
* On the local machine, disable the nginx-proxy, and set the dnsmasq address to that of your cloud server:
```
  :dnsmasq:
    :enabled: true
    :domain: docker      # domain that will be listened for
    :address: <cloud-server-ip>  # address returned for queries against domain
    :container_name: dory_dnsmasq
  :nginx_proxy:
    :enabled: false
    :container_name: dory_dinghy_http_proxy
```
* On the server, disable resolv and dnsmasq:
```
  :dnsmasq:
    :enabled: false
    :domain: docker      # domain that will be listened for
    :address: 127.0.0.1  # address returned for queries against domain
    :container_name: dory_dnsmasq
  :resolv:
    :enabled: false
    :nameserver: 127.0.0.1
```
* Profit!

## Built on:

* [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) (Indirectly but worthy of mention)
* [codekitchen/dinghy-http-proxy](https://github.com/codekitchen/dinghy-http-proxy)
* [erikhuda/thor](https://github.com/erikhuda/thor)
