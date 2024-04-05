<?php

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userna = $_POST['userna'];
    $pass = $_POST['pass'];

    try {
        // Require necessary files
        require_once '../../DB/dbconfig.php';
        require_once '../../includes/config_session.inc.php';
        require_once '../../includes/logger.inc.php';
        require_once '../../includes/login/login.contr.inc.php';
        require_once '../../includes/login/login.model.inc.php';

        // Check for empty fields
        if (isEmpty($userna, $pass)) {
            $_SESSION['login_errors'] = ["empty_inputs" => "Please fill in all fields!"];
            header("Location: ../../index.php");
            exit();
        }

        // Attempt to log in the user
        $usertype = loginUser($conn, $userna, $pass);       ;

        if ($usertype == "superadmin") {
            header('Location: ../../views/superadmin.php');
            exit();
        } elseif ($usertype == "admin") { // Changed $userType to $usertype
            header('Location: ../../views/admin.php');
            exit();
        } elseif ($usertype == "parent") { // Changed $userType to $usertype
            header('Location: ../../views/home.php');
            exit();
        } else {
            // Failed login attempt
            $_SESSION['login_errors'] = ["incorrect_password" => "Incorrect username or password!"];
            header("Location: index.php");
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
