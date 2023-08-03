<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';



$sql = "select * from products join categories on products.category_id = categories.category_id";
$result = mysqli_query($con, $sql);

if ($result) {
    $products = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $products[] = $row;
    }
    echo json_encode([
        "status" => 200,
        "message" => "Products fetched successfully",
        "data" => $products
    ]);
} else {
    echo json_encode([
        "status" => 500,
        "message" => "Something went wrong"
    ]);
}
