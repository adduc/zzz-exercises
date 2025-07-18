# Makefile for cross-platform Golang GUI application

# Application name
APP_NAME := counter-gui

# Output directory
BUILD_DIR := build

# Go build flags for GUI applications (CGO required for OpenGL)
BUILD_FLAGS := -ldflags "-s -w" -a

# Default target
.PHONY: all
all: amd64 arm64

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build for AMD64 (x86_64)
.PHONY: amd64
amd64: $(BUILD_DIR)
	@echo "Building for AMD64..."
	cd golang-gui && \
	GOOS=linux GOARCH=amd64 \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-amd64 .
	@echo "AMD64 build completed: $(BUILD_DIR)/$(APP_NAME)-amd64"

# Build for ARM64
.PHONY: arm64
arm64: $(BUILD_DIR)
	@echo "Building for ARM64..."
	cd golang-gui && \
	CC=aarch64-linux-gnu-gcc GOOS=linux GOARCH=arm64 \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-arm64 .
	@echo "ARM64 build completed: $(BUILD_DIR)/$(APP_NAME)-arm64"

# Build for current platform (for testing)
.PHONY: local
local: $(BUILD_DIR)
	@echo "Building for current platform..."
	cd golang-gui && \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME) .
	@echo "Build completed: $(BUILD_DIR)/$(APP_NAME)"

# Clean build artifacts
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	@echo "Build artifacts cleaned"

# Test the application (build and basic validation)
.PHONY: test
test:
	@echo "Running Go tests..."
	cd golang-gui && go test ./...
	@echo "Running build validation..."
	$(MAKE) local
	@echo "Checking binary exists..."
	ls -la $(BUILD_DIR)/$(APP_NAME)
	@echo "All tests passed"

# Install dependencies
.PHONY: deps
deps:
	@echo "Installing dependencies..."
	cd golang-gui && go mod download
	cd golang-gui && go mod tidy
	@echo "Dependencies installed"

# Display help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all     - Build for both AMD64 and ARM64"
	@echo "  amd64   - Build for AMD64 (x86_64)"
	@echo "  arm64   - Build for ARM64"
	@echo "  local   - Build for current platform"
	@echo "  test    - Run tests and build validation"
	@echo "  deps    - Install/update dependencies"
	@echo "  clean   - Remove build artifacts"
	@echo "  help    - Show this help message"