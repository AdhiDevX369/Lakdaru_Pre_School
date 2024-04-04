<?php

declare(strict_types=1);

// Function to get user type
function getUserType(object $conn, string $username): int {
    $stmt = $conn->prepare("SELECT type_id FROM users WHERE username = :username");
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $type_id = (int)$row['type_id'];
        return ($type_id >= 1 && $type_id <= 3) ? $type_id : 0;
    } else {
        return 0;
    }
}

// Function to authenticate user login
function login(object $conn, string $username, string $password) {
    $stmt = $conn->prepare("SELECT username, password FROM users WHERE username = :username");
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();
    $user_exists = $stmt->rowCount() > 0;

    if ($user_exists) {
        $hashedPassword = getPassword($conn, $username);
        if ($hashedPassword !== null && password_verify($password, $hashedPassword)) {
            // Log the successful login attempt
            $message = "Successful login for username: $username";
            logMessage($message, 'INFO');
            
            $user_type = getUserType($conn, $username);
            switch ($user_type) {
                case 1:
                    return "superadmin";
                    break;
                case 2:
                    return "admin";
                    break;
                case 3:
                    return "parent";
                    break;
                default:
                    return 0;
                    break;
            }
        }
    }
    // Log the failed login attempt
    $message = "Failed login attempt for username: $username";
    logMessage($message, 'ERROR');

    return false;
}

// Function to retrieve hashed password from database
function getPassword(object $conn, string $username): ?string {
    $stmt = $conn->prepare("SELECT password FROM users WHERE username = :username");
    $stmt->bindParam(':username', $username, PDO::PARAM_STR);
    $stmt->execute();

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    return $row ? $row['password'] : null;
}
