-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 13, 2019 at 04:08 PM
-- Server version: 5.5.62-0+deb8u1
-- PHP Version: 5.6.40-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Table structure for table `zm_data`
--

CREATE TABLE IF NOT EXISTS `zm_data` (
`id` int(11) NOT NULL,
  `nick` varchar(32) NOT NULL,
  `auth` varchar(34) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `playtime` int(11) NOT NULL,
  `primary` int(11) NOT NULL,
  `secondary` int(11) NOT NULL,
  `knife` int(11) NOT NULL,
  `offensivegrenade` int(11) NOT NULL,
  `defensivegrenade` int(11) NOT NULL,
  `tacticalgrenade` int(11) NOT NULL,
  `special` int(11) NOT NULL,
  `ammo` int(11) NOT NULL,
  `zclass` int(11) NOT NULL,
  `hclass` int(11) NOT NULL,
  `xp` int(11) NOT NULL,
  `ammopacks` float NOT NULL DEFAULT '0',
  `upgrades` varchar(512) DEFAULT NULL,
  `zombies_killed` int(11) NOT NULL DEFAULT '0',
  `humans_infected` int(11) NOT NULL DEFAULT '0',
  `rounds_won` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `zm_data`
--
ALTER TABLE `zm_data`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `auth` (`auth`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `zm_data`
--
ALTER TABLE `zm_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
