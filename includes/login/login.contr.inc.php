<?php

declare(strict_types=1);

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
function userType(object $conn, string $uname)
{
    $userType = getUserType($conn, $uname);
    if ($userType == 1) {
        return "superadmin";
    } elseif ($userType == 2) {
        return "admin";
    } elseif ($userType == 3) {
        return "parent";
    } else {
        return "false";
    }
}



// Function to handle user login
function loginUser(object $conn, string $uname,string $pass)
{
    // Check if username and password are provided
    if (empty($uname) || empty($pass)) {
        // Log the attempt with empty fields
        $message = "Empty username or password field during login attempt.";
        logMessage($message, 'WARNING');
        return "Please provide both username and password.";
    }

    // Call login function from the model to authenticate user
    $isUserLogged = login($conn, $uname, $pass);
    if($isUserLogged){
        $userType = userType($conn, $uname);
        if($userType){
            // Start session if not already started
            if (session_status() === PHP_SESSION_NONE) {
                session_start();
            }
            // Set session variables
            $_SESSION['username'] = $uname;
            $_SESSION['userType'] = $userType;
            
            return $userType;
        }else{
            // Log the failed login attempt
            $message = "Failed login attempt for username: $uname";
            logMessage($message, 'ERROR');
            return "Incorrect username or password!";
        }
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

function verifyInput(string $uname,string $password){
    echo $uname;
    echo $password;
}