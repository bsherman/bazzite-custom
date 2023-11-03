### 1. BUILD ARGS
## These enable the produced image to be different by passing different build args.
## They are provided on the commandline when building in a terminal, but the github
## workflow provides them when building in Github Actions. Changes to the workflow
## build.xml will override changes here.

## SOURCE_IMAGE arg can be anything from ublue upstream: silverblue, kinoite, sericea, vauxite, mate, lxqt, base
ARG SOURCE_IMAGE="bazzite-deck"
## SOURCE_SUFFIX arg should be "main", nvidia users should use "nvidia"
ARG SOURCE_SUFFIX="gnome"
## FEDORA_VERSION arg must be a version built by ublue: 37 or 38 as of today
ARG FEDORA_VERSION="38"
## NVIDIA_VERSION should only be changed if the user needs a specific nvidia driver version
##   if needing driver 535, this should be set to "-535". It is important to include the hyphen
ARG NVIDIA_VERSION=""


### 2. SOURCE IMAGE
## this is a standard Containerfile FROM using the build ARGs above to select the right upstream image
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}-${SOURCE_SUFFIX}:${FEDORA_VERSION}${NVIDIA_VERSION}


### 3. PRE-MODIFICATIONS
## this directory is needed to prevent failure with some RPM installs
RUN mkdir -p /var/lib/alternatives


### 4. MODIFICATIONS
# install packages
RUN rpm-ostree install iperf3 moby-engine strace xwaylandvideobridge

### github direct installs
RUN /tmp/github-release-install.sh twpayne/chezmoi x86_64 && \
    /tmp/github-release-install.sh wez/wezterm fedora38.x86_64

# static binaries can sometimes by added using a COPY directive like these below. 
COPY --from=docker.io/docker/compose-bin:latest /docker-compose /usr/bin/docker-compose

# disable docker by default
RUN systemctl disable docker.service && \
    systemctl disable docker.socket


### 5. POST-MODIFICATIONS
## these commands leave the image in a clean state after local modifications
RUN rm -rf /tmp/* /var/* && \
    ostree container commit && \
    mkdir -p /tmp /var/tmp && \
    chmod 1777 /tmp /var/tmp
