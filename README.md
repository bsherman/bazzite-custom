# bazzite-custom

## Overview

This is my slightly tweaked version of [Bazzite](https://github.com/ublue-os/bazzite/), specifically this is "desktop" version running KDE Plasma.

The build is based on [ublue-os/image-template](https://github.com/ublue-os/image-template).

## Detail

In addition to all the goodies provided by Bazzite...

Installs:
- chezmoi - for managing my dotfiles
- gh - github client
- ipcalc - for network testing
- iperf3 - for network testing
- KDE PIM apps
- libvirtd - qemu backend for running kvm VMs plus virt-manager
- netcat - for network testing
- nmap - for network testing
- sunshine - for moonlight compatible streaming
- xpadneo - Xbox controller bluetooth driver (built in [ublue-os/akmods](https://github.com/ublue-os/akmods))

Versions Built:
- Bazzite based on Fedora 40

Installation:

I assume you've installed using Bazzite's instructions, or at the least, you've installed  [Kinoite](https://fedoraproject.org/kinoite/download/).

Rebase to 40 with the following command:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:40
