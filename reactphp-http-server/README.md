# ReactPHP HTTP Server

A ReactPHP HTTP server implementation that serves specific endpoints.

## Features

- **GET /** - Returns "^_^"
- **GET /ping** - Returns "pong"
- **404 handling** - Returns "Not Found" for unknown routes
- **405 handling** - Returns "Method Not Allowed" for non-GET requests

## Installation

Install dependencies using Composer:
```bash
composer install
```

## Usage

### Starting the server

Start the server by running:
```bash
php server.php
```

The server will start on `http://127.0.0.1:8080`

### Testing the endpoints

Test the root endpoint:
```bash
curl http://127.0.0.1:8080/
# Returns: ^_^
```

Test the ping endpoint:
```bash
curl http://127.0.0.1:8080/ping
# Returns: pong
```

## Files

- `server.php` - Main ReactPHP server implementation
- `composer.json` - PHP project configuration with ReactPHP dependencies

## Implementation Notes

This implementation uses ReactPHP's HTTP server component to provide an asynchronous, event-driven HTTP server. The server properly handles:
- HTTP response codes (200, 404, 405)
- Content-Type headers
- Request method validation
- URL path parsing

The server runs on ReactPHP's event loop and can handle multiple concurrent requests efficiently.