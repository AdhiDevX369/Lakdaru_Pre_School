<?php

// Function to log messages
function logMessage(string $message, string $level)
{
    // Define the log file path
    $logFile = 'logs/login.log';

    // Compose the log entry
    $logEntry = "[" . date('Y-m-d H:i:s') . "] [$level]: $message\n";

    // Append the log entry to the log file
    file_put_contents($logFile, $logEntry, FILE_APPEND);
}

?>
