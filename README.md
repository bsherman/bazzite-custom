# bazzite-custom

## Overview

This is my slightly tweaked version of [Bazzite](https://github.com/ublue-os/bazzite/), specifically this is "deck" version running GNOME. 

It can run directly on the [Steam Deck](https://www.steamdeck.com/) in gaming mode.

When run in desktop mode, it uses the [GNOME](https://www.gnome.org/) desktop environment.


## Detail

In addition to all the goodies provided by Bazzite...

Installs:
- chezmoi - for managing my dotfiles
- iperf3 - for network testing
- moby-engine / docker-compose - docker (disabled by default)
- wezterm - my preferred terminal
- xwaylandvideobridge - for sharing wayland apps/screen in Xwayland apps (like Discord)

Versions Built:
- Bazzite based on Fedora 38
- Bazzite based on Fedora 39

Installation:

I assume you've installed using Bazzite's instructions, or at the least, you've installed  [Silverblue](https://fedoraproject.org/silverblue/download/).

Rebase to either 38 or 39 with one of the following commands:

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:38
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bsherman/bazzite-custom:39
