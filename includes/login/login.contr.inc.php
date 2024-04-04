<?php

declare(strict_types=1);

// Include the logger script
require_once '../../includes/logger.inc.php';

// check if the user is logged in
function isLoggedIn()
{
    // Start session if not already started
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    // Check if user is logged in
    if (isset($_SESSION['username'])) {
        return true;
    } else {
        // Log the attempt to access restricted content
        $message = "Attempt to access restricted content without logging in.";
        logMessage($message, 'WARNING');
        return false;
    }
}

// check empty fields
function isEmpty(string $username, string $password)
{
    if (empty($username) || empty($password)) {
        // Log the attempt with empty fields
        $message = "Empty username or password field during login attempt.";
        logMessage($message, 'WARNING');
        return true;
    } else {
        return false;
    }
}


// Function to handle user login
function loginUser(object $conn, string $username, string $password)
{
    // Check if username and password are provided
    if (empty($username) || empty($password)) {
        // Log the attempt with empty fields
        $message = "Empty username or password field during login attempt.";
        logMessage($message, 'WARNING');
        return "Please provide both username and password.";
    }

    // Call login function from the model to authenticate user
    $userType = login($conn, $username, $password);

    // Check the result of login attempt
    if ($userType === false) {
        // Log the failed login attempt
        $message = "Failed login attempt for username: $username";
        logMessage($message, 'ERROR');
        return "Invalid username or password.";
    } else {
        // Start a session and store user information if login is successful
        session_start();
        $_SESSION['username'] = $username;
        $_SESSION['userType'] = $userType;
        // Log the successful login attempt
        $message = "Successful login for username: $username";
        logMessage($message, 'INFO');
        return "Login successful.";
    }
}

// Function to handle user logout
function logoutUser()
{
    // Start session if not already started
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    // Unset all session variables
    $_SESSION = array();

    // Destroy the session
    session_destroy();
    // Log the logout action
    $message = "User logged out.";
    logMessage($message, 'INFO');
    return "Logout successful.";
}

?>
