<?php
require_once '../includes/login/login.view.inc.php';
require_once '../includes/config_session.inc.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Register Page</title>
    <link rel="stylesheet" href="../css/style.css">    
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="../includes/register/register.inc.php" method="post">
            <div class="form-group">
                <label for="childname">Child Name:</label>
                <input type="text" id="childname" name="childname" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <input type="radio" name="gender" value="male" required> Male
                <input type="radio" name="gender" value="female" required> Female
            </div>
            <div class="form-group">
                <label for="language">Language:</label>
                <select id="language" name="language" required>
                    <option value="Sinhala">Sinhala</option>
                    <option value="Tamil">Tamil</option>
                    <option value="English">English</option>
                </select>
            </div>
            <div class="form-group">
                <label for="parentname">Parent Name:</label>
                <input type="text" id="parentname" name="parentname" required>
            </div>
            <div class="form-group">
                <label for="nic">NIC:</label>
                <input type="text" id="nic" name="nic" required>
            </div>
            <div class="form-group">
                <label for="contact">Contact:</label>
                <input type="text" id="contact" name="contact" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address" required></textarea>
            </div>            
            <div class="form-group">
                <button type="submit">Register</button>
            </div>
        </form>
        <?php      
        ?>
    </div>
</body>
</html>