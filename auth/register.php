<?php

//function for registering a user
include_once '../helper_functions/AuthenicationFunction.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['fullname']) && isset($_POST['email']) && isset($_POST['password'])) {
        $result =  register($_POST['fullname'], $_POST['email'], $_POST['password']);

        if ($result) {
            echo "User registered successfully";
        } else {
            echo "User registration failed";
        }
    } else {
        echo "Please fill all the fields";
    }
}
