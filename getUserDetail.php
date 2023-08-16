<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';


if (isset($_POST['token'])) {
    $user_id = getUserWithToken($_POST['token']);

    $sql = "select user_id,email,full_name,role from users where user_id = '$user_id'";


    $result = mysqli_query($con, $sql);

    $user = mysqli_fetch_assoc($result);

    if ($result) {
        echo json_encode([
            "status" => 200,
            "message" => "User fetched successfully",
            "data" => $user
        ]);
    } else {
        echo json_encode([
            "status" => 500,
            "message" => "Something went wrong"
        ]);
    }
} else {
    echo json_encode([
        "status" => 400,
        "message" => "Please provide token"
    ]);
}
