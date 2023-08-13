<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';


if (isset($_POST['token'])) {
    $isAdmin = isAdmin($_POST['token']);

    if (!$isAdmin) {
        echo json_encode([
            "status" => 401,
            "message" => "You are not authorized!"
        ]);
        exit();
    }

    $sql = 'select count(*) as total_orders from orders';

    $result = mysqli_query($con, $sql);

    $total_orders = mysqli_fetch_assoc($result)['total_orders'];


    $sql = 'select count(*) as total_users from users';

    $result = mysqli_query($con, $sql);

    $total_users = mysqli_fetch_assoc($result)['total_users'];

    $sql = 'select sum(total) as total_income from orders where status = "paid"';

    $result = mysqli_query($con, $sql);

    $total_income = mysqli_fetch_assoc($result)['total_income'];



    if ($result) {
        echo json_encode([
            "status" => 200,
            "message" => "Stats fetched successfully",
            "data" => [
                "total_orders" => $total_orders,
                "total_users" => $total_users,
                "total_income" => $total_income
            ]
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
