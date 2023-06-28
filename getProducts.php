<?php
include_once("./helpers/databaseConnection.php");


if ($_SERVER['REQUEST_METHOD'] == 'GET') {

    $sql = 'select * from products';

    $result = mysqli_query($con, $sql);

    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);

    echo json_encode($rows);
}
