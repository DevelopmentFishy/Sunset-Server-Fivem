
DROP TABLE IF EXISTS `flight_atmrobbery`;
CREATE TABLE IF NOT EXISTS `flight_atmrobbery` (
  `id` varchar(50) NOT NULL,
  `x` varchar(50) DEFAULT NULL,
  `y` varchar(50) DEFAULT NULL,
  `z` varchar(50) DEFAULT NULL,
  `heading` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) DEFAULT NULL,
  `step` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
