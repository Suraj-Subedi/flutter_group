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
        isset($_POST['title'])
        && isset($_POST['id'])

    ) {
        $id = $_POST['id'];
        $title = $_POST['title'];

        $sql = "select * from categories where title='$title'";

        $result = mysqli_query($con, $sql);
        $count = mysqli_num_rows($result);

        if ($count > 0) {
            echo json_encode([
                "status" => 400,
                "message" => "Category already exists"
            ]);
            die();
        }


        $sql = "UPDATE categories SET title='$title' WHERE id='$id'";
        $result = mysqli_query($con, $sql);

        if ($result) {
            echo json_encode([
                "status" => 200,
                "message" => "Category updated successfully"
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
            "message" => "Please fill all the fields (id, title)"
        ]);
    }
} else {
    echo json_encode([
        "status" => 400,
        "message" => "Please provide token"
    ]);
}
