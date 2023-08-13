<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';


if (isset($_POST['token'])) {
    $isAdmin = isAdmin($_POST['token']);

    $sql = 'select user_id,full_name,email,role from users';


    $result = mysqli_query($con, $sql);

    $orders = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $orders[] = $row;
    }

    if ($result) {
        echo json_encode([
            "status" => 200,
            "message" => "Users fetched successfully",
            "data" => $orders
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
