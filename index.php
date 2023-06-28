<?php

include_once('./helpers/databaseConnection.php');

if ($con) {
    echo "Connection Successful";
} else {
    echo "Connection failed";
}
