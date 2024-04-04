<?php

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    try {
        // Require necessary files
        require_once '../../DB/dbconfig.php';
        require_once '../../includes/config_session.inc.php';
        require_once '../../includes/logger.inc.php'; // Include logger script
        require_once '../../includes/login/login.contr.inc.php';
        require_once '../../includes/login/login.model.inc.php';

        // Check for empty fields
        if (isEmpty($username, $password)) {
            $_SESSION['login_errors'] = ["empty_inputs" => "Please fill in all fields!"];
            header("Location: ../../index.php");
            exit();
        }

        // Attempt to log in the user
        $usertype = loginUser($conn, $username, $password);
        if ($usertype) {
            // Successful login
            switch ($usertype) {
                case "admin":
                    header("Location: ../views/admin.php?login=success");
                    exit();
                case "superadmin":
                    header("Location: ../views/superadmin.php?login=success");
                    exit();
                case "parent":
                    header("Location: ../views/home.php?login=success");
                    exit();
                default:
                    // Handle unknown user types
                    $_SESSION['login_errors'] = ["unknown_type" => "Unknown user type!"];
                    header("Location: ../../index.php");
                    exit();
            }
        } else {
            // Failed login attempt
            $_SESSION['login_errors'] = ["incorrect_password" => "Incorrect username or password!"];
            header("Location: ../../index.php");
            exit();
        }
    } catch (PDOException $e) {
        // Handle database errors
        die("Query failed! " . $e->getMessage());
    }
} else {
    // Redirect if accessed directly
    header("Location: ../../index.php");
    exit();
}

?>
