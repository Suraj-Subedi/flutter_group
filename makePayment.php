<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';

if (isset($_POST['token'])) {

    $user_id = getUserWithToken($_POST['token']);

    if (!$user_id) {
        echo json_encode([
            "status" => 400,
            "message" => "Invalid token"
        ]);
        exit;
    }

    if (
        isset($_POST['order_id']) &&
        isset($_POST['amount']) &&
        isset($_POST['other_data'])
    ) {
        $order_id = $_POST['order_id'];
        $amount = $_POST['amount'];
        $other_data = $_POST['other_data'];



        $sql = "insert into payments (order_id, amount,user_id, other_data) values ('$order_id', '$amount','$user_id', '$other_data')";
        $result = mysqli_query($con, $sql);

        $sql = "update orders set status = 'paid' where order_id = '$order_id'";

        $result = mysqli_query($con, $sql);

        if ($result) {
            echo json_encode([
                "status" => 200,
                "message" => "Payment made successfully"
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
            "message" => "Please fill all the fields (order_id, amount, other_data)"
        ]);
    }
} else {
    echo json_encode([
        "status" => 400,
        "message" => "Please provide token"
    ]);
}
