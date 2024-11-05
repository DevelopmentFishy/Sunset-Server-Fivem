CREATE TABLE IF NOT EXISTS `m_fishing` (
  `citizenid` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `experience` int DEFAULT NULL,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;