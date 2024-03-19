# bazzite-custom

## Overview

This is my slightly tweaked version of [Bazzite](https://github.com/ublue-os/bazzite/), specifically this is "desktop" version running KDE Plasma.


## Detail

In addition to all the goodies provided by Bazzite...

Installs:
- chezmoi - for managing my dotfiles
- gh - github client
- ipcalc - for network testing
- iperf3 - for network testing
- libvirtd - qemu backend for running kvm VMs plus virt-manager
- netcat - for network testing
- nmap - for network testing
- sunshine - for moonlight compatible streaming
- wezterm - my preferred terminal
- xpadneo - Xbox controller bluetooth driver (built in [ublue-os/akmods](https://github.com/ublue-os/akmods))

Versions Built:
- Bazzite based on Fedora 39

Installation:

I assume you've installed using Bazzite's instructions, or at the least, you've installed  [Silverblue](https://fedoraproject.org/silverblue/download/).

Rebase to 39 with the following command:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:39
