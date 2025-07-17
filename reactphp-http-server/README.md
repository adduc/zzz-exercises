# ReactPHP HTTP Server

A simple ReactPHP-style HTTP server implementation that serves specific endpoints.

## Features

- **GET /** - Returns "^_^"
- **GET /ping** - Returns "pong"
- **404 handling** - Returns "Not Found" for unknown routes
- **405 handling** - Returns "Method Not Allowed" for non-GET requests

## Usage

### Starting the server

You can start the server in several ways:

#### Option 1: Using the start script
```bash
./start.php
```

#### Option 2: Using PHP's built-in server directly
```bash
php -S localhost:8080 server.php
```

The server will start on `http://localhost:8080`

### Testing the endpoints

Test the root endpoint:
```bash
curl http://localhost:8080/
# Returns: ^_^
```

Test the ping endpoint:
```bash
curl http://localhost:8080/ping
# Returns: pong
```

## Files

- `server.php` - Main server logic handling routes
- `start.php` - Helper script to start the server
- `composer.json` - PHP project configuration

## Implementation Notes

This implementation uses PHP's built-in development server (`php -S`) to provide a simple HTTP server that handles the specified routes. While not using the actual ReactPHP library (due to installation limitations), it follows the same pattern and provides the exact functionality requested.

The server properly handles:
- HTTP response codes (200, 404, 405)
- Content-Type headers
- Request method validation
- URL path parsing