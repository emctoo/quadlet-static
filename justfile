default_os := "linux"
default_arch := "amd64"

# list commands
default:
    @just --list

# clone podman
clone:
    #!/usr/bin/env bash

    if [[ -d podman ]]; then
        rm -rf podman
    fi
    git clone https://github.com/containers/podman.git
    # cd podman && git submodule update --init

# static compile for different arch
build arch="amd64":
    #!/usr/bin/env bash
    cd podman/cmd/quadlet
    export CGO_ENABLED=0
    export GOOS={{default_os}} 
    export GOARCH={{arch}} 
    go build -a -ldflags '-extldflags "-static"' -o quadlet_{{arch}}
    cp quadlet_{{arch}} ../../../../

# compile all
build-all:
    just build amd64
    just build arm64

# cleanup 
clean:
    rm -rf podman
    rm -f quadlet_*


# create release
release version:
    gh release create {{version}} quadlet_* --generate-notes
