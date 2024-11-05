CREATE TABLE IF NOT EXISTS `codem_taxijob` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` char(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `image` text DEFAULT '0',
  `level` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `totalmoney` int(11) DEFAULT 0,
  `totalmile` int(11) DEFAULT 0,
  `paytype` varchar(50) DEFAULT '0',
  `passenger` int(11) DEFAULT 0,
  `taximoney` int(11) DEFAULT 0,
  `position` longtext DEFAULT NULL,
  `history` longtext DEFAULT NULL,
  `achivements` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;
DELETE FROM `codem_taxijob`;