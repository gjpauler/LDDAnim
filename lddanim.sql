-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2019. Sze 30. 07:38
-- Kiszolgáló verziója: 10.1.30-MariaDB
-- PHP verzió: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `lddanim`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewAnim` (IN `titleIN` VARCHAR(32) CHARSET utf8, IN `authorIN` VARCHAR(32) CHARSET utf8, IN `versionIN` INT(4), IN `frameCountIN` INT(4))  NO SQL
INSERT INTO `anim`
(
    `anim`.`title`,
    `anim`.`author`,
    `anim`.`version`,
    `anim`.`frameCount`
)
VALUES
(
	titleIN,
    authorIN,
    versionIN,
    frameCountIN
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewFrame` (IN `animIDIN` INT(8), IN `frameSeqIN` INT(3), IN `camFieldIN` DOUBLE, IN `camDistIN` DOUBLE, IN `camXIN` DOUBLE, IN `camYIN` DOUBLE, IN `camZIN` DOUBLE, IN `camRXIN` DOUBLE, IN `camRYIN` DOUBLE, IN `camRZIN` DOUBLE, IN `commandIN` VARCHAR(16) CHARSET utf8, IN `param1IN` DOUBLE, IN `param2IN` DOUBLE, IN `param3IN` DOUBLE)  NO SQL
INSERT INTO `frame`
(
    `frame`.`animID`,
    `frame`.`frameSeq`,
    `frame`.`camField`,
    `frame`.`camDist`,
    `frame`.`camX`,
    `frame`.`camY`,
    `frame`.`camZ`,
    `frame`.`camRX`,
    `frame`.`camRY`,
    `frame`.`camRZ`,
    `frame`.`command`,
    `frame`.`param1`,
    `frame`.`param2`,
    `frame`.`param3`
)
VALUES
(
    animIDIN,
    frameSeqIN,
    camFieldIN,
    camDistIN,
    camXIN,
    camYIN,
    camZIN,
    camRXIN,
    camRYIN,
    camRZIN,
    commandIN,
    param1IN,
    param2IN,
    param3IN
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewUser` (IN `userNameIN` VARCHAR(16) CHARSET utf8, IN `passwordIN` VARCHAR(64) CHARSET utf8, IN `emailIN` VARCHAR(64) CHARSET utf8, IN `givenNameIN` VARCHAR(32) CHARSET utf8, IN `surNameIN` VARCHAR(32) CHARSET utf8, IN `addressIN` VARCHAR(64) CHARSET utf8, IN `cityIN` VARCHAR(32) CHARSET utf8, IN `zipIN` VARCHAR(16) CHARSET utf8, IN `countryIN` VARCHAR(32) CHARSET utf8)  NO SQL
INSERT INTO `user`
(
    `user`.`userName`,
    `user`.`password`,
    `user`.`email`,
    `user`.`givenName`,
    `user`.`surName`,
    `user`.`address`,
    `user`.`city`,
    `user`.`zip`,
    `user`.`country`
)
VALUES
(
    userNameIN,
    SHA1(passwordIN),
    emailIN,
    givenNameIN,
    surNameIN,
    addressIN,
    cityIN,
    zipIN,
    countryIN
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAnim` (IN `animIDIN` INT(8))  NO SQL
DELETE FROM `anim` WHERE `anim`.`animID` = animIDIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFrame` (IN `frameIDIN` INT(8))  NO SQL
DELETE FROM `frame` WHERE `frame`.`frameID` = frameIDIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAnim` ()  NO SQL
SELECT * FROM `anim`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFrame` ()  NO SQL
SELECT * FROM `frame`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFrameOfAnim` (IN `animIDIN` INT(8))  NO SQL
SELECT * FROM `frame` WHERE `frame`.`animID` = animIDIN
ORDER BY `frame`.`frameSeq`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAnim` (IN `animIDIN` INT(8))  NO SQL
SELECT * FROM `anim` WHERE `anim`.`animID` = animIDIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFrame` (IN `frameIDIN` INT)  NO SQL
SELECT * FROM `frame` WHERE `frame`.`frameID` = frameIDIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isRegistered` (IN `userNameIN` VARCHAR(32) CHARSET utf8, IN `passwordIN` VARCHAR(64) CHARSET utf8, IN `emailIN` VARCHAR(64) CHARSET utf8, OUT `registeredUserCountOUT` INT(8))  NO SQL
SELECT COUNT(`user`.`userID`)
INTO registeredUserCountOUT
FROM `user`
WHERE 
(`user`.`userName` = userNameIN AND `user`.`password` = SHA1(passwordIN) ) OR (`user`.`email` = emailIN)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `userNameIN` VARCHAR(16) CHARSET utf8, IN `passwordIN` VARCHAR(64) CHARSET utf8, OUT `userIDOUT` INT(8))  NO SQL
SELECT `user`.`userID`
INTO userIDOUT
FROM `user`
WHERE `user`.`userName` = userNameIN AND `user`.`password` = SHA1(passwordIN)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAnim` (IN `titleIN` VARCHAR(32) CHARSET utf8, IN `versionIN` INT(4), IN `frameCountIN` INT(4), IN `animIDIN` INT(8))  NO SQL
UPDATE `anim`
SET
	`anim`.`title` = titleIN,
    `anim`.`version` = versionIN,
    `anim`.`frameCount` = frameCountIN
WHERE `anim`.`animID` = animIDIN$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFrame` (IN `animIDIN` INT(8), IN `frameSeqIN` INT(3), IN `camFieldIN` DOUBLE, IN `camDistIN` DOUBLE, IN `camXIN` DOUBLE, IN `camYIN` DOUBLE, IN `camZIN` DOUBLE, IN `camRXIN` DOUBLE, IN `camRYIN` DOUBLE, IN `camRZIN` DOUBLE, IN `commandIN` VARCHAR(16) CHARSET utf8, IN `param1IN` DOUBLE, IN `param2IN` DOUBLE, IN `param3IN` DOUBLE, IN `frameIDIN` INT(8))  NO SQL
UPDATE `frame`
SET
	`frame`.`animID`= animIDIN,
    `frame`.`frameSeq`= frameSeqIN,
    `frame`.`camField`= camFieldIN,
    `frame`.`camDist`= camDistIN,
    `frame`.`camX`= camXIN,
    `frame`.`camY`= camYIN,
    `frame`.`camZ`= camZIN,
    `frame`.`camRX`= camRXIN,
    `frame`.`camRY`= camRYIN,
    `frame`.`camRZ`= camRZIN,
    `frame`.`command`= commandIN,
    `frame`.`param1`= param1IN,
    `frame`.`param2`= param2IN,
    `frame`.`param3`= param3IN
WHERE `frame`.`frameID` = frameIDIN$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `anim`
--

CREATE TABLE `anim` (
  `animID` int(8) NOT NULL,
  `title` varchar(32) NOT NULL,
  `author` varchar(32) NOT NULL,
  `version` int(4) NOT NULL,
  `frameCount` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `anim`
--

INSERT INTO `anim` (`animID`, `title`, `author`, `version`, `frameCount`) VALUES
(1, 'Test', 'Gábor', 1, 3),
(2, 'Helikopter leszáll', 'Gábor', 1, 9),
(3, 'Hajó', 'Gábor', 1, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `frame`
--

CREATE TABLE `frame` (
  `frameID` int(8) NOT NULL,
  `animID` int(8) NOT NULL,
  `frameSeq` int(3) NOT NULL,
  `camField` double NOT NULL,
  `camDist` double NOT NULL,
  `camX` double NOT NULL,
  `camY` double NOT NULL,
  `camZ` double NOT NULL,
  `camRX` double NOT NULL,
  `camRY` double NOT NULL,
  `camRZ` double NOT NULL,
  `command` varchar(16) NOT NULL,
  `param1` double NOT NULL,
  `param2` double NOT NULL,
  `param3` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `frame`
--

INSERT INTO `frame` (`frameID`, `animID`, `frameSeq`, `camField`, `camDist`, `camX`, `camY`, `camZ`, `camRX`, `camRY`, `camRZ`, `command`, `param1`, `param2`, `param3`) VALUES
(1, 1, 1, 80, 16.855321884155273, 13.137144088745117, 9.894624710083008, 5.213019847869873, 0, -33.419628148488094, 34.90796299354021, 'ImportBase', 0, 0, 0),
(2, 1, 2, 80, 16.855321884155273, 13.137144088745117, 9.894624710083008, 5.213019847869873, 0, -33.419628148488094, 34.90796299354021, 'Synchronize', 0, 0, 0),
(4, 1, 3, 80, 16.855321884155273, 13.137144088745117, 9.894624710083008, 5.213019847869873, 0, -33.419628148488094, 34.90796299354021, 'Synchronize', 0, 0, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `userID` int(8) NOT NULL,
  `userName` varchar(16) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `givenName` varchar(32) NOT NULL,
  `surName` varchar(32) NOT NULL,
  `address` varchar(64) NOT NULL,
  `city` varchar(32) NOT NULL,
  `zip` varchar(16) NOT NULL,
  `country` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`userID`, `userName`, `password`, `email`, `givenName`, `surName`, `address`, `city`, `zip`, `country`) VALUES
(1, 'gjpauler', '7c222fb2927d828af22f592134e8932480637c0d', 'pauler@t-online.hu', 'Gabor', 'Pauler', '1st Szechenyi str.', 'Pogany', '7666', 'Hungary'),
(3, 'probajeno', '7c222fb2927d828af22f592134e8932480637c0d', 'proba@proba.net', 'Jeno', 'Proba', 'Proba str 1', 'Probavar', '1111', 'Hungary');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `anim`
--
ALTER TABLE `anim`
  ADD PRIMARY KEY (`animID`);

--
-- A tábla indexei `frame`
--
ALTER TABLE `frame`
  ADD PRIMARY KEY (`frameID`),
  ADD KEY `FKanimID` (`animID`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `anim`
--
ALTER TABLE `anim`
  MODIFY `animID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `frame`
--
ALTER TABLE `frame`
  MODIFY `frameID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `frame`
--
ALTER TABLE `frame`
  ADD CONSTRAINT `frame_ibfk_1` FOREIGN KEY (`animID`) REFERENCES `anim` (`animID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
