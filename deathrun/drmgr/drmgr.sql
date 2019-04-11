-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 11, 2019 at 03:54 PM
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
-- Table structure for table `dr_donations`
--

CREATE TABLE IF NOT EXISTS `dr_donations` (
  `donator` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `lifes` int(11) NOT NULL DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dr_stats`
--

CREATE TABLE IF NOT EXISTS `dr_stats` (
`id` int(11) NOT NULL,
  `auth` varchar(34) NOT NULL,
  `lifes` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `nickname` varchar(32) NOT NULL,
  `vip_weapon` int(11) NOT NULL,
  `vip_weapon2` int(11) NOT NULL DEFAULT '25',
  `time_played` int(11) NOT NULL DEFAULT '0',
  `weapon_level` int(11) NOT NULL DEFAULT '6',
  `add_lifes` int(11) NOT NULL DEFAULT '0',
  `add_money` int(11) NOT NULL DEFAULT '0',
  `password` varchar(16) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=117211 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dr_top`
--

CREATE TABLE IF NOT EXISTS `dr_top` (
  `map` varchar(32) NOT NULL,
  `id` int(11) NOT NULL,
  `time` float NOT NULL,
  `date` int(11) NOT NULL,
  `scout` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dr_stats`
--
ALTER TABLE `dr_stats`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `auth` (`auth`);

--
-- Indexes for table `dr_top`
--
ALTER TABLE `dr_top`
 ADD PRIMARY KEY (`map`,`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dr_stats`
--
ALTER TABLE `dr_stats`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
