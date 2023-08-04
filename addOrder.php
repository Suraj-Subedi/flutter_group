<?php

include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';

if (!isset($_POST['token'])) {
    echo json_encode([
        "status" => 400,
        "message" => "Token not found"
    ]);
    exit;
}
$token = $_POST['token'];
$userId = getUserWithToken($token);
if (!$userId) {
    echo json_encode([
        "status" => 400,
        "message" => "Invalid token"
    ]);
    exit;
}


if (!isset($_POST['orders'])  || !isset($_POST['amount'])) {
    echo json_encode([
        "status" => 400,
        "message" => "Orders and amount is  required"
    ]);
    exit;
}



$orders = $_POST['orders'];
$amount = $_POST['amount'];

if (!is_numeric($amount)) {
    echo json_encode([
        "status" => 400,
        "message" => "Amount should be numeric"
    ]);
    exit;
}

$sql = "insert into orders (user_id, total) values ('$userId', '$amount')";

$result = mysqli_query($con, $sql);

$orderId = mysqli_insert_id($con);

$cart_items = json_decode($orders, true);


foreach ($cart_items as $cart_item) {
    $product_id = $cart_item['product_id'];
    $quantity = $cart_item['quantity'];
    $lineTotal = $cart_item['price'] * $quantity;

    $sql = "insert into order_details (order_id, product_id, quantity, line_total) values ('$orderId', '$product_id', '$quantity', '$lineTotal')";
    $result = mysqli_query($con, $sql);
}

if ($result) {
    echo json_encode([
        "status" => 200,
        "message" => "Order placed successfully",
        "order_id" => $orderId
    ]);
} else {
    echo json_encode([
        "status" => 500,
        "message" => "Something went wrong"
    ]);
}
