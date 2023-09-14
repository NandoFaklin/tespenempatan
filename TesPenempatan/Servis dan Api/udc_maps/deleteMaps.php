<?php
include "koneksi.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $id = $_POST['id'];


    $insert = "DELETE FROM maps WHERE id='$id'";
    if (mysqli_query($koneksi, $insert)) {
        $response['value'] = 1;
        $response['message'] = "Delete Successfully";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Delete not Successfully";
        echo json_encode($response);
    }
}
?>
