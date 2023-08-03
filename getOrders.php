<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';


if (isset($_POST['token'])) {
    $isAdmin = isAdmin($_POST['token']);
    $user_id = getUserWithToken($_POST['token']);

    $sql = '';

    if ($isAdmin) {
        $sql = "select orders.*,users.user_id, users.full_name,users.email from orders join users on orders.user_id = users.user_id";
    } else {
        $sql = "select * from orders where user_id = '$user_id'";
    }

    $result = mysqli_query($con, $sql);

    $orders = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $orders[] = $row;
    }

    if ($result) {
        echo json_encode([
            "status" => 200,
            "message" => "Orders fetched successfully",
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
