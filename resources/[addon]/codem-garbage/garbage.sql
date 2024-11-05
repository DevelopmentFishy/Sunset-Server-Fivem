
-- tablo yapısı dökülüyor qbcoreframework_dfae89.codem_busjob
CREATE TABLE IF NOT EXISTS `codem_garbage` (
  `identifier` char(50) DEFAULT NULL,
  `profiledata` longtext DEFAULT NULL,
  `historydata` longtext DEFAULT NULL,
  `dailymission` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
