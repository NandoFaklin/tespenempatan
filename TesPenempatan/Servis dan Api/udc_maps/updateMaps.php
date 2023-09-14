<?php
include 'koneksi.php';
 
$id = $_POST['id'];
$nama= $_POST['nama'];
$lokasi= $_POST['lokasi'];
$no_hp = $_POST['no_hp'];
$lat_kampus = $_POST['lat_kampus'];
$long_kampus = $_POST['long_kampus'];

$gambar_kampus = date('dmYHis') . str_replace(" ", "", basename($_FILES['gambar_kampus']['name']));
$imagePath = "gambar_kampus/" . $gambar_kampus;
 
if (move_uploaded_file($_FILES['gambar_kampus']['tmp_name'], $imagePath)) {
    $sql = "UPDATE maps SET gambar_kampus = '$gambar_kampus',nama= '$nama',lokasi = '$lokasi',no_hp = '$no_hp',lat_kampus = '$lat_kampus',long_kampus = '$long_kampus'  WHERE id='$id'";
    
    if(mysqli_query($koneksi, $sql)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil Update Data";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal Update Data";
        echo json_encode($response);
    }
} else {
    $response['value'] = 0;
    $response['message'] = "Image upload failed";
    echo json_encode($response);
}
return;
?>
