<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';



$sql = "select * from categories where isDeleted=0 order by category_id desc ";
$result = mysqli_query($con, $sql);

if ($result) {
    $categories = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $categories[] = $row;
    }
    echo json_encode([
        "status" => 200,
        "message" => "Categories fetched successfully",
        "data" => $categories
    ]);
} else {
    echo json_encode([
        "status" => 500,
        "message" => "Something went wrong"
    ]);
}
