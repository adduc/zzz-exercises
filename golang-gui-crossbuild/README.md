# Cross-Platform Golang GUI Counter

A simple counter application built with Go and Fyne that provides a native GUI interface.

## Features

- **Increment/Decrement/Reset Counter**: Interactive buttons to manipulate a counter value
- **Cross-Platform**: Builds for AMD64 and ARM64 architectures
- **Native GUI**: Uses Fyne toolkit for desktop environments

## Screenshots

### Native GUI Interface
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
# Build all targets (AMD64 and ARM64 native versions)
make all

# Build specific targets
make amd64           # Native GUI for AMD64
make arm64           # Native GUI for ARM64

# Build for current platform
make local           # Native GUI for current platform

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

## Architecture Support

| Target | Architecture | Linking | GUI Type |
|--------|-------------|---------|----------|
| `counter-gui-amd64` | AMD64 | Dynamic | Native (Fyne) |
| `counter-gui-arm64` | ARM64 | Dynamic | Native (Fyne) |

## Development

### Project Structure
```
golang-gui-crossbuild/
├── main.go              # Native GUI application (Fyne)
├── main_test.go         # Unit tests
├── go.mod               # Go module definition
└── go.sum               # Go module checksums
```

### Running Tests
```bash
make test
```

### Dependencies
- **Fyne v2.6.1**: Cross-platform GUI toolkit
- **Go standard library**: Core functionality