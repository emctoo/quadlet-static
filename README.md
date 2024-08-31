# Static Quadlet Builder

This project provides a way to build static binaries of the `quadlet` tool from the Podman project for both amd64 and arm64 architectures.

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

After building or downloading the binary:

1. Move the binary to a directory in your PATH:

```bash
sudo mv quadlet_amd64 /usr/local/bin/quadlet
```

2. Make it executable:

```bash
sudo chmod +x /usr/local/bin/quadlet
```

## Downloading

You can download pre-built binaries from the [Releases](https://github.com/your-username/static-quadlet-builder/releases) page.

## Usage

After installation, you can use `quadlet` like any other command-line tool:

```bash
quadlet --help
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

BSD
