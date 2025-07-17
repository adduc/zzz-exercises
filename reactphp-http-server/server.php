<?php
/**
 * Simple ReactPHP-style HTTP Server
 * This implementation serves:
 * - GET / returns "^_^"
 * - GET /ping returns "pong"
 */

// Simple HTTP response helper
function sendResponse($statusCode, $body, $headers = []) {
    $protocol = $_SERVER['SERVER_PROTOCOL'] ?? 'HTTP/1.1';
    $statusText = match($statusCode) {
        200 => 'OK',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        default => 'Unknown'
    };
    
    header("$protocol $statusCode $statusText");
    
    // Set default headers
    header('Content-Type: text/plain');
    header('Content-Length: ' . strlen($body));
    
    // Set additional headers
    foreach ($headers as $name => $value) {
        header("$name: $value");
    }
    
    echo $body;
}

// Get request method and path
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);

// Handle routes
if ($method === 'GET') {
    switch ($path) {
        case '/':
            sendResponse(200, '^_^');
            break;
        case '/ping':
            sendResponse(200, 'pong');
            break;
        default:
            sendResponse(404, 'Not Found');
    }
} else {
    sendResponse(405, 'Method Not Allowed');
}