<?php
include_once 'DatabaseConfig.php';

//function for registering a user 


function register($fullname, $email, $password)
{
    global $con;
    $encrypted_password = password_hash($password, PASSWORD_BCRYPT);

    $sql = "INSERT INTO users (full_name, email, password,role) VALUES ('$fullname', '$email', '$encrypted_password','user')";
    $result = mysqli_query($con, $sql);
    if ($result) {
        return true;
    } else {
        return false;
    }
}
