# Makefile for cross-platform Golang GUI application

# Application name
APP_NAME := counter-gui

# Output directory
BUILD_DIR := build

# Go build flags for GUI applications (CGO required for OpenGL)
BUILD_FLAGS := -ldflags "-s -w" -a
# Go build flags for static linking (for web version)
STATIC_BUILD_FLAGS := -ldflags "-s -w -extldflags=-static" -a -installsuffix cgo

# Default target
.PHONY: all
all: amd64 arm64-web amd64-web

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build native GUI for AMD64 (x86_64)
.PHONY: amd64
amd64: $(BUILD_DIR)
	@echo "Building native GUI for AMD64..."
	cd golang-gui && \
	GOOS=linux GOARCH=amd64 \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-amd64 .
	@echo "AMD64 build completed: $(BUILD_DIR)/$(APP_NAME)-amd64"

# Build web-based GUI for AMD64 (statically linked, musl compatible)
.PHONY: amd64-web
amd64-web: $(BUILD_DIR)
	@echo "Building web-based GUI for AMD64 (static, musl compatible)..."
	cd golang-gui && \
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
	go build $(STATIC_BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-amd64-web ./cmd/web
	@echo "AMD64 web build completed: $(BUILD_DIR)/$(APP_NAME)-amd64-web"

# Build web-based GUI for ARM64 (statically linked, musl compatible)
.PHONY: arm64-web
arm64-web: $(BUILD_DIR)
	@echo "Building web-based GUI for ARM64 (static, musl compatible)..."
	cd golang-gui && \
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 \
	go build $(STATIC_BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-arm64-web ./cmd/web
	@echo "ARM64 web build completed: $(BUILD_DIR)/$(APP_NAME)-arm64-web"

# Build for ARM64 native (may fail due to cross-compilation complexity)
.PHONY: arm64
arm64: $(BUILD_DIR)
	@echo "Building native GUI for ARM64..."
	@echo "Note: ARM64 cross-compilation may require additional system dependencies"
	cd golang-gui && \
	(CC=aarch64-linux-gnu-gcc GOOS=linux GOARCH=arm64 \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-arm64 . && \
	echo "ARM64 build completed: $(BUILD_DIR)/$(APP_NAME)-arm64") || \
	(echo "ARM64 native build failed - use 'make arm64-web' for cross-platform ARM64 support")

# Build for current platform (for testing)
.PHONY: local
local: $(BUILD_DIR)
	@echo "Building for current platform..."
	cd golang-gui && \
	go build $(BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME) .
	@echo "Build completed: $(BUILD_DIR)/$(APP_NAME)"

# Build web version for current platform
.PHONY: local-web
local-web: $(BUILD_DIR)
	@echo "Building web version for current platform..."
	cd golang-gui && \
	CGO_ENABLED=0 go build $(STATIC_BUILD_FLAGS) -o ../$(BUILD_DIR)/$(APP_NAME)-web ./cmd/web
	@echo "Web build completed: $(BUILD_DIR)/$(APP_NAME)-web"

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
	$(MAKE) local-web
	@echo "Checking binary exists..."
	ls -la $(BUILD_DIR)/$(APP_NAME)-web
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
	@echo "  all        - Build for AMD64 and ARM64 (web versions)"
	@echo "  amd64      - Build native GUI for AMD64 (x86_64)"
	@echo "  amd64-web  - Build web GUI for AMD64 (static, musl compatible)"
	@echo "  arm64      - Build native GUI for ARM64 (may fail)"
	@echo "  arm64-web  - Build web GUI for ARM64 (static, musl compatible)"
	@echo "  local      - Build native GUI for current platform"
	@echo "  local-web  - Build web GUI for current platform"
	@echo "  test       - Run tests and build validation"
	@echo "  deps       - Install/update dependencies"
	@echo "  clean      - Remove build artifacts"
	@echo "  help       - Show this help message"