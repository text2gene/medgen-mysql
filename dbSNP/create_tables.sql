DROP TABLE IF EXISTS `hgvs2dbSNP`;

CREATE TABLE `hgvs2dbSNP` (
  `hgvs` varchar(63) DEFAULT NULL,
  `snp` int(11) DEFAULT NULL,
  KEY `hgvs` (`hgvs`),
  KEY `snp` (`snp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
