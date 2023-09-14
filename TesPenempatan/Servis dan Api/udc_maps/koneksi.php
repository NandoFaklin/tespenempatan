<?php

$koneksi = mysqli_connect("localhost", "root", "", "app_maps");

if($koneksi) {

	// echo "Berhasil konek ke database";
	
} else {
	echo "Gagal koneksi";
}

?>