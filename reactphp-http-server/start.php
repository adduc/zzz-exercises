#!/usr/bin/env php
<?php
/**
 * Start script for the ReactPHP HTTP server
 * Uses PHP's built-in server to serve the application
 */

echo "Starting ReactPHP HTTP server on http://localhost:8080\n";
echo "Routes:\n";
echo "  GET / -> ^_^\n";
echo "  GET /ping -> pong\n";
echo "\nPress Ctrl+C to stop the server\n\n";

// Start the built-in PHP server
$command = 'php -S localhost:8080 server.php';
$descriptorSpec = [
    0 => ['pipe', 'r'],  // stdin
    1 => ['pipe', 'w'],  // stdout
    2 => ['pipe', 'w']   // stderr
];

$process = proc_open($command, $descriptorSpec, $pipes);

if (is_resource($process)) {
    // Forward output
    while (!feof($pipes[1])) {
        $output = fread($pipes[1], 1024);
        if ($output) {
            echo $output;
        }
    }
    
    // Close pipes and process
    fclose($pipes[0]);
    fclose($pipes[1]);
    fclose($pipes[2]);
    proc_close($process);
} else {
    echo "Failed to start server\n";
}