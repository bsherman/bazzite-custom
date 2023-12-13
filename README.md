# bazzite-custom

## Overview

This is my slightly tweaked version of [Bazzite](https://github.com/ublue-os/bazzite/), specifically this is "desktop" version running GNOME.


## Detail

In addition to all the goodies provided by Bazzite...

Installs:
- chezmoi - for managing my dotfiles
- iperf3 - for network testing
- libvirtd and qemu backend for running kvm VMs (use a client from distrobox, etc)
- nmap - for network testing
- wezterm - my preferred terminal

Versions Built:
- Bazzite based on Fedora 38
- Bazzite based on Fedora 39

Installation:

I assume you've installed using Bazzite's instructions, or at the least, you've installed  [Silverblue](https://fedoraproject.org/silverblue/download/).

Rebase to either 38 or 39 with one of the following commands:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:38
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:39
