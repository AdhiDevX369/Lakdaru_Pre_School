<?php
$hash = '$2y$10$N3hrskYfhQ4i9OOJGgSEK.2OTV6G5d78YVYBZ0JklH8RChjoBV3qS'; // Replace with your actual hash
$password = 'adminpassword'; // Replace with the password you want to verify

if (password_verify($password, $hash)) {
    echo 'Password is valid';
} else {
    echo 'Password is invalid';
}
?>
