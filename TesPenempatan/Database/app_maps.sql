-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Sep 2023 pada 13.32
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app_maps`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `maps`
--

CREATE TABLE `maps` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `lokasi` text NOT NULL,
  `no_hp` int(25) NOT NULL,
  `gambar_kampus` text NOT NULL,
  `lat_kampus` varchar(255) NOT NULL,
  `long_kampus` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `maps`
--

INSERT INTO `maps` (`id`, `nama`, `lokasi`, `no_hp`, `gambar_kampus`, `lat_kampus`, `long_kampus`) VALUES
(6, 'unp', 'padang , pantai puruih , kec padang timur , sumatra barat', 852556325, '14092023111759unp.png', '-0.8969582110644859', '100.35073289531368'),
(7, 'Stikes', 'Surau Gadang, Kec. Nanggalo, Kota Padang, Sumatera Barat 25173', 823255255, '14092023112124stikes.png', '-0.8982045635327955', '100.37483603911453'),
(8, 'update', 'tes', 2151515, '14092023112248stikes.png', '-0.8982045635327955', '100.37483603911453'),
(9, 'pnp', 'limau manih', 25585520, '14092023114126pnp.png', '-0.9143533472737793', '100.46617242655354'),
(10, 'pnp2', 'padang', 25525665, '14092023123121pnp.png', '1', '1'),
(16, 'tes', 'tes', 8555445, '14092023124120pnp.png', '1', '1'),
(17, 'kampus', 'padang', 85533224, '14092023124209pnp.png', '0', '0');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `maps`
--
ALTER TABLE `maps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
