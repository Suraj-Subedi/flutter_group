<?php
include 'helper_functions\DatabaseConfig.php';
include 'helper_functions\AuthenicationFunction.php';


if (isset($_POST['token'])) {
    $isAdmin = isAdmin($_POST['token']);
    if (!$isAdmin) {
        echo json_encode([
            "status" => 403,
            "message" => "You are not authorized to perform this action"
        ]);
        die();
    }
    if (
        isset($_POST['id']) &&
        isset($_POST['name']) &&
        isset($_POST['price']) &&
        isset($_POST['description']) &&
        isset($_POST['category'])

    ) {
        $id = $_POST['id'];
        $name = $_POST['name'];
        $price = $_POST['price'];
        $description = $_POST['description'];
        $category = $_POST['category'];
        $image = "";
        if (isset($_POST['image'])) {
            $image = $_POST['image'];
        }

        $sql = "UPDATE products SET title='$name', price='$price', description='$description', category_id='$category', image_url='$image' WHERE product_id=" . $id;


        $result = mysqli_query($con, $sql);

        if ($result) {
            echo json_encode([
                "status" => 200,
                "message" => "Product updated  successfully",

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
            "message" => "Please fill all the fields (id,name, price, description, category and imageUrl(Optional))"
        ]);
    }
} else {
    echo json_encode([
        "status" => 400,
        "message" => "Please provide token"
    ]);
}
