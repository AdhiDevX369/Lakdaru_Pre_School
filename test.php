<?php
require_once './includes/config_session.inc.php';
require_once './includes/login/login.model.inc.php';
require_once './includes/login/login.contr.inc.php';
require_once './DB/dbconfig.php';

// test usertype retrieve
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userna = $_POST['userna'];
    $pass = $_POST['pass'];
    verifyInput($userna, $pass);
    $usertype = loginUser($conn, $userna, $pass);
    $isAvailableUserName = getUsername($conn, $userna);
    $isUserLogged = login($conn, $userna, $pass);
       
    if ($usertype == "superadmin") {
        header('Location: views/superadmin.php');
        exit();
    } elseif ($usertype == "admin") { // Changed $userType to $usertype
        header('Location: views/admin.php');
        exit();
    } elseif ($usertype == "parent") { // Changed $userType to $usertype
        header('Location: views/parent.php');
        exit();
    } else {
        // Failed login attempt
        $_SESSION['login_errors'] = ["incorrect_password" => "Incorrect username or password!"];
        header("Location: index.php");
        exit();
    }
}
