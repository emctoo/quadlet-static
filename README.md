# Static Quadlet Builder

This project provides a way to build static binaries of the `quadlet` tool from the Podman project for both amd64 and arm64 architectures.

You can download pre-built binary and install it by this:

```shell
curl -fsSL https://raw.githubusercontent.com/emctoo/quadlet-static/refs/heads/main/install.sh | sudo bash
```

## Prerequisites

- Go 1.17 or later
- [just](https://github.com/casey/just)

## Building

To build the static binaries locally:

```bash
# Clone the repository
git clone https://github.com/emctoo/static-quadlet.git
cd static-quadlet

# Build for all supported architectures
just build-all

# Or build for a specific architecture
just build amd64
just build arm64
```

## Installing

```bash
export ARCH="amd64" # or arm64
curl -L https://github.com/emctoo/quadlet-static/releases/latest/download/quadlet-${ARCH} -o quadlet
chmod +x quadlet
sudo mv quadlet /usr/local/bin/quadlet

mkdir -p /etc/systemd/{user,system}-generators/
ln -sf /usr/local/bin/quadlet /etc/systemd/system-generators/podman-system-generator
ln -sf /usr/local/bin/quadlet /etc/systemd/user-generators/podman-user-generator
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

BSD
