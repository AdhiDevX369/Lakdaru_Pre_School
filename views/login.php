<?php
require_once '../includes/login/login.view.inc.php';
require_once '../includes/config_session.inc.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="../css/style.css">    
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="../includes/login/login.inc.php" method="post">--->
        <!--<form action="../test.php" method="post">-->
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="userna" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="pass" required>
            </div>
            <div class="form-group">
                <button type="submit">Login</button>
            </div>
        </form>
        <?php
    checkLoginError();
    ?>
    </div>
</body>
</html>