<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data
    $childname = $_POST['childname'];
    $dob = $_POST['dob'];
    $gender = $_POST['gender'];
    $language = $_POST['language'];
    $parentname = $_POST['parentname'];
    $nic = $_POST['nic'];
    $contact = $_POST['contact'];
    $address = $_POST['address'];

    try {
        // Require files
        require_once '../../DB/dbconfig.php';
        require_once '../../includes/config_session.inc.php';
        require_once '../../includes/logger.inc.php';
        require_once '../../includes/register/register.contr.inc.php';
        require_once '../../includes/register/register.model.inc.php';
        
        echo $childname;
        echo "<br>";
        echo $dob;
        echo "<br>";
        echo $gender;
        echo "<br>";
        echo $language;
        echo "<br>";
        echo $parentname;
        echo "<br>";
        echo $nic;
        echo "<br>";
        echo $contact;
        echo "<br>";
        echo $address;
        echo "<br>";
        
    } catch (PDOException $e) {
        // Handle database errors
        die("Query failed! " . $e->getMessage());
    }
} else {
    // Redirect if accessed directly
    header("Location: ../../index.php");
    exit();
}