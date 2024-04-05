<?php

declare(strict_types=1);

// Function to get user type
function getUserType(object $conn, string $uname): int
{
    $stmt = $conn->prepare("SELECT type_id FROM users WHERE username = :username");
    $stmt->bindParam(':username', $uname, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $type_id = (int)$row['type_id'];
        return $type_id;
        logMessage("User type retrieved successfully: " . $type_id, 'INFO');
    } else {
        return 0;
       
    }
}

// Function to authenticate user login
function login(object $conn, string $uname, string $password): bool
{
    $stmt = $conn->prepare("SELECT username, password FROM users WHERE username = :username");
    $stmt->bindParam(':username', $uname, PDO::PARAM_STR);
    $stmt->execute();
    $user_exists = $stmt->rowCount() > 0;

    if ($user_exists) {
        $hashedPassword = getPassword($conn, $uname);
        if ($hashedPassword !== null && password_verify($password, $hashedPassword)) {
            // Log the successful login attempt
            return true;
        } else {
            return false;
        }
    } else {
        // Log the failed login attempt
        $message = "Failed login attempt for username: $uname";
        logMessage($message, 'ERROR');

        return false;
    }
}


// Function to retrieve hashed password from database
function getPassword(object $conn, string $uname): ?string
{
    $stmt = $conn->prepare("SELECT password FROM users WHERE username = :username");
    $stmt->bindParam(':username', $uname, PDO::PARAM_STR);
    $stmt->execute();

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    return $row ? $row['password'] : null;
}

function getUsername(object $conn, string $uname): ?bool
{
    $stmt = $conn->prepare("SELECT username FROM users WHERE username = :username");
    $stmt->bindParam(':username', $uname, PDO::PARAM_STR);
    $stmt->execute();

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if( $row['username'] == $uname){
        return true;
    }else{
        return false;
    }        
}