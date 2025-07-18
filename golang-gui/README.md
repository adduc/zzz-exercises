# Cross-Platform Golang GUI Counter

A simple counter application built with Go that provides both native GUI and web-based interfaces.

## Features

- **Increment/Decrement/Reset Counter**: Interactive buttons to manipulate a counter value
- **Cross-Platform**: Builds for AMD64 and ARM64 architectures
- **musl Compatibility**: Static binaries work on Alpine Linux and other musl-based systems
- **Two UI Options**:
  - Native GUI using Fyne (for desktop environments)
  - Web-based interface (for headless/server environments)

## Screenshots

### Web Interface
![Counter App Screenshot](https://github.com/user-attachments/assets/41daaacc-367f-45d1-8a36-01d51a5c343a)

## Building

### Prerequisites
- Go 1.24.4 or later
- For native GUI builds: OpenGL development libraries
  ```bash
  sudo apt install -y libgl1-mesa-dev libxrandr-dev libxcursor-dev libxinerama-dev libxi-dev libx11-dev libxxf86vm-dev
  ```
- For ARM64 cross-compilation: ARM64 GCC cross-compiler
  ```bash
  sudo apt install -y gcc-aarch64-linux-gnu
  ```

### Build Commands

```bash
# Build all targets (AMD64 native + web versions for both architectures)
make all

# Build specific targets
make amd64           # Native GUI for AMD64
make amd64-web       # Web GUI for AMD64 (static, musl compatible)
make arm64-web       # Web GUI for ARM64 (static, musl compatible)

# Build for current platform
make local           # Native GUI for current platform
make local-web       # Web GUI for current platform

# Other commands
make test            # Run tests and validation
make clean           # Remove build artifacts
make deps            # Install/update dependencies
make help            # Show all available targets
```

## Usage

### Native GUI Version
```bash
./build/counter-gui-amd64
```
Opens a desktop window with increment/decrement buttons.

### Web Version
```bash
# Start on default port 8080
./build/counter-gui-amd64-web

# Start on custom port
./build/counter-gui-amd64-web 3000
```
Then open your browser to `http://localhost:8080` (or your custom port).

## Architecture Support

| Target | Architecture | Linking | musl Compatible | GUI Type |
|--------|-------------|---------|-----------------|----------|
| `counter-gui-amd64` | AMD64 | Dynamic | No | Native (Fyne) |
| `counter-gui-amd64-web` | AMD64 | Static | Yes | Web |
| `counter-gui-arm64-web` | ARM64 | Static | Yes | Web |

## musl Compatibility

The web versions (`*-web`) are statically linked and work on:
- Alpine Linux
- Other musl-based distributions
- Minimal container images

## Development

### Project Structure
```
golang-gui/
├── main.go              # Native GUI application (Fyne)
├── main_test.go         # Unit tests
├── cmd/web/main.go      # Web-based application
├── go.mod               # Go module definition
└── go.sum               # Go module checksums
```

### Running Tests
```bash
make test
```

### Dependencies
- **Fyne v2.6.1**: Cross-platform GUI toolkit
- **Go standard library**: HTTP server and HTML templating