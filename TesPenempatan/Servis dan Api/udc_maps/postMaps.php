<?php
include 'koneksi.php';
 
$nama= $_POST['nama'];
$lokasi= $_POST['lokasi'];
$no_hp = $_POST['no_hp'];
$lat_kampus = $_POST['lat_kampus'];
$long_kampus = $_POST['long_kampus'];

$gambar_kampus = date('dmYHis') . str_replace(" ", "", basename($_FILES['gambar_kampus']['name']));
$imagePath = "gambar_kampus/" . $gambar_kampus;
 
if (move_uploaded_file($_FILES['gambar_kampus']['tmp_name'], $imagePath)) {
    $sql = "INSERT INTO maps (gambar_kampus,nama,lokasi,no_hp,lat_kampus,long_kampus) VALUES ('$gambar_kampus', '$nama', '$lokasi',$no_hp,$lat_kampus,$long_kampus)";
    
    if(mysqli_query($koneksi, $sql)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil Insert Data";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal Insert Data";
        echo json_encode($response);
    }
} else {
    $response['value'] = 0;
    $response['message'] = "Image upload failed";
    echo json_encode($response);
}
return

?>
