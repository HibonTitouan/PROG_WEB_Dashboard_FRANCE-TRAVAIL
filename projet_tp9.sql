-- Base de données : projet_tp9
CREATE DATABASE IF NOT EXISTS `projet_tp9` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `projet_tp9`;

-- --------------------------------------------------------
-- Table : users
-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`)
);

-- --------------------------------------------------------
-- INSERTION DES UTILISATEURS AVEC MOTS DE PASSE HASHÉS
-- --------------------------------------------------------

INSERT INTO `users` (`username`, `password`, `role`) VALUES
  ('admin', '$2b$10$W9HsL36KpvtXqTE5OZDFpuY0y9quXgX9QXgP6mV8O0UmZ/nfHE5N.', 'admin'),
  ('user',  '$2b$10$xUUP2SWYXV7ec46bROZO2OCihiCKPXOhA0E/BvSN7DSfcjCLy97ay', 'user');
