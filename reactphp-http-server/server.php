#!/usr/bin/env php
<?php
/**
 * ReactPHP HTTP Server
 * This implementation serves:
 * - GET / returns "^_^"
 * - GET /ping returns "pong"
 */

require_once __DIR__ . '/vendor/autoload.php';

use Psr\Http\Message\ServerRequestInterface;
use React\Http\HttpServer;
use React\Http\Message\Response;
use React\Socket\SocketServer;

// Create HTTP server with request handler
$http = new HttpServer(function (ServerRequestInterface $request) {
    $method = $request->getMethod();
    $path = $request->getUri()->getPath();
    
    // Handle routes
    if ($method === 'GET') {
        switch ($path) {
            case '/':
                return new Response(200, ['Content-Type' => 'text/plain'], '^_^');
            case '/ping':
                return new Response(200, ['Content-Type' => 'text/plain'], 'pong');
            default:
                return new Response(404, ['Content-Type' => 'text/plain'], 'Not Found');
        }
    } else {
        return new Response(405, ['Content-Type' => 'text/plain'], 'Method Not Allowed');
    }
});

// Create socket server
$socket = new SocketServer('127.0.0.1:8080');

// Start server
$http->listen($socket);

echo "ReactPHP HTTP server running on http://127.0.0.1:8080\n";
echo "Routes:\n";
echo "  GET / -> ^_^\n";
echo "  GET /ping -> pong\n";
echo "\nPress Ctrl+C to stop the server\n\n";