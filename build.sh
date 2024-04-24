#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#rpm-ostree install screen

# this would install a package from rpmfusion
#RUN rpm-ostree install vlc

# adds the xpadneo kmod for bluetooth xbox one controller support
curl https://negativo17.org/repos/fedora-multimedia.repo -o /etc/yum.repos.d/negativo17-fedora-multimedia.repo
rpm-ostree install /tmp/akmods-rpms/*.rpm
rm /etc/yum.repos.d/negativo17-fedora-multimedia.repo


# adds my custom packages
rpm-ostree install --idempotent \
  ipcalc \
  iperf3 \
  langpacks-en \
  libvirt-daemon \
  libvirt-daemon-config-network \
  libvirt-daemon-driver-interface \
  libvirt-daemon-driver-network \
  libvirt-daemon-driver-nwfilter \
  libvirt-daemon-driver-qemu \
  libvirt-daemon-driver-secret \
  libvirt-daemon-driver-storage-core \
  libvirt-daemon-driver-storage-disk \
  libvirt-daemon-driver-storage-scsi \
  netcat \
  nmap \
  qemu-kvm \
  virt-manager

# adds my kde specific packages
rpm-ostree install --idempotent \
  k3b \
  kdepim-runtime \
  kmail \
  libadwaita \
  libadwaita-qt5 \
  libadwaita-qt6 \
  merkuro

/tmp/github-release-install.sh twpayne/chezmoi x86_64
/tmp/github-release-install.sh LizardByte/Sunshine fedora-${RELEASE}-amd64

#### Change to System Configuration Files

systemctl enable sunshine-workaround.service
