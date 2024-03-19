### 1. BUILD ARGS
## These enable the produced image to be different by passing different build args.
## They are provided on the commandline when building in a terminal, but the github
## workflow provides them when building in Github Actions. Changes to the workflow
## build.xml will override changes here.

## SOURCE_IMAGE arg can be anything from ublue upstream: silverblue, kinoite, sericea, vauxite, mate, lxqt, base
ARG SOURCE_IMAGE="bazzite"
## SOURCE_SUFFIX arg should be "main", nvidia users should use "nvidia"
ARG SOURCE_SUFFIX=""
## FEDORA_VERSION arg must be a version built by ublue: 37 or 38 as of today
ARG FEDORA_VERSION="39"
## NVIDIA_VERSION should only be changed if the user needs a specific nvidia driver version
##   if needing driver 535, this should be set to "-535". It is important to include the hyphen
ARG NVIDIA_VERSION=""


### 2. SOURCE IMAGE
## this is a standard Containerfile FROM using the build ARGs above to select the right upstream image
#FROM ghcr.io/bsherman/${SOURCE_IMAGE}-${SOURCE_SUFFIX}:${FEDORA_VERSION}${NVIDIA_VERSION}
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${FEDORA_VERSION}${NVIDIA_VERSION}

ARG FEDORA_VERSION="39"


### 3. PRE-MODIFICATIONS
## this directory is needed to prevent failure with some RPM installs
RUN mkdir -p /var/lib/alternatives
# needed to install github rpms directly
ADD github-release-install.sh /tmp/

# akmods can be main (if bsherman custom bazzite) or 6.7.9-204.fsync (if official bazzite)
COPY --from=ghcr.io/ublue-os/akmods:6.7.9-204.fsync-${FEDORA_VERSION} /rpms/kmods/*xpadneo*.rpm /tmp/akmods-rpms/


### 4. MODIFICATIONS
# install custom akmods packages
RUN curl https://negativo17.org/repos/fedora-multimedia.repo -o /etc/yum.repos.d/negativo17-fedora-multimedia.repo && \
    rpm-ostree install /tmp/akmods-rpms/*.rpm && \
    rm /etc/yum.repos.d/negativo17-fedora-multimedia.repo

# install custom packages
RUN rpm-ostree install --idempotent \
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
   qemu-kvm
   #gnome-shell-extension-dash-to-dock \
   #gnome-shell-extension-no-overview \

### github direct installs
RUN /tmp/github-release-install.sh twpayne/chezmoi x86_64 && \
    /tmp/github-release-install.sh LizardByte/Sunshine fedora-${FEDORA_VERSION}-amd64 && \
    /tmp/github-release-install.sh wez/wezterm fedora${FEDORA_VERSION}.x86_64

### post install customization
RUN systemctl enable sunshine-workaround.service

# static binaries can sometimes by added using a COPY directive like these below. 
COPY --from=docker.io/docker/compose-bin:latest /docker-compose /usr/bin/docker-compose


### 5. POST-MODIFICATIONS
## these commands leave the image in a clean state after local modifications
RUN rm -rf /tmp/* /var/* && \
    ostree container commit && \
    mkdir -p /tmp /var/tmp && \
    chmod 1777 /tmp /var/tmp
