CREATE TABLE genre (
	`genreID` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`type` VARCHAR(255),
	`description` TEXT
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE review (
	`reviewID` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`gameID` INT(11),
	`score` INT(11),
	`description` TEXT,
	FOREIGN KEY(`gameID`) REFERENCES `game`(`gameID`)
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE platform (
	`platformID` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`make` VARCHAR(255),
	`name` VARCHAR(255),
	`year` INT(11)
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE publisher (
	`publisherID` INT(11) PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(255),
	`location` VARCHAR(255),
	`yearEstab` INT(11)
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE game_platform (
	`platformID` INT(11), 
	`gameID` INT(11),
	PRIMARY	KEY (`platformID`, `gameID`),
	FOREIGN KEY(`platformID`) REFERENCES `platform`(`platformID`),
	FOREIGN KEY(`gameID`) REFERENCES `game`(`gameID`)
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE game_genre (
	`genreID` INT(11), 
	`gameID` INT(11),
	PRIMARY	KEY (`genreID`, `gameID`),
	FOREIGN KEY(`genreID`) REFERENCES `genre`(`genreID`),
	FOREIGN KEY(`gameID`) REFERENCES `game`(`gameID`)
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;

CREATE TABLE `game` (
	`gameID` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255),
	`releasedate` VARCHAR(255),
	`publisherID` INT(11),
	FOREIGN KEY(`publisherID`) REFERENCES `publisher`(`publisherID`),
) ENGINE = 'innoDB' COLLATE=UTF8_unicode_ci;


INSERT INTO game(name, releasedate, publisherID) VALUES ('Call of Duty: WWII', '2017-11-04', '5');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Warcraft 3', '2002-03-07', '26');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Call of Duty: Modern Warfare', '2007-11-05', '20');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Super Mario Galaxy', '2007-11-01', '1');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Grand Theft Auto 5', '2013-09-17', '3');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Street Fighter', '1987-08-30', '12');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Halo', '2001-11-15', '14');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Destiny 2', '2017-10-28', '13');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Donkey Kong 64', '1999-11-22', '1');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Starcraft', '1998-11-30', '26');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Super Mario World', '1990-11-021', '1');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Assassins Creed', '2007-11-13', '7');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Madden 14', '2013-08-27', '4');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Battlefield 1', '2016-10-21', '4');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Pokemon: Fire Red', '2004-01-29', '18');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Diablo 3', '2012--05-15', '26');
INSERT INTO game(name, releasedate, publisherID) VALUES ('The Last of Us', '2013-06-14', '10');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Super Mario Bros.', '1985-09-13', '1');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Kingdom Hearts II', '2005-12-22', '11');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Assassins Creed: Origins', '2017-10-27', '7');
INSERT INTO game(name, releasedate, publisherID) VALUES ('Sonic the Hedgehog', '1991-06-23', '8');


INSERT INTO genre(type, description) 
	VALUES ('Action', 'Action games emphasize physical challenges that require eye-hand coordination and motor skill to overcome. They center around the player, who is in control of most of the action. Most of the earliest video games were considered action games; today, it is still a vast genre covering all games that involve physical challenges.');
INSERT INTO genre(type, description) 
	VALUES ('Action-Adventure', 'Action-adventure games combine elements of their two component genres,typically featuring long-term obstacles that must be overcome using a tool or item as leverage (which is collected earlier), as well as many smaller obstacles almost constantly in the way, that require elements of action games to overcome. Action-adventure games tend to focus on exploration and usually involve item gathering, simple puzzle solving, and combat. "Action-adventure" has become a label which is sometimes attached to games which do not fit neatly into another well known genre.');
INSERT INTO genre(type, description) 
	VALUES ('Adventure', 'Adventure games were some of the earliest games created, beginning with the text adventure Colossal Cave Adventure in the 1970s. That game was originally titled simply "Adventure," and is the namesake of the genre. Over time, graphics have been introduced to the genre and the interface has evolved.Unlike adventure films, adventure games are not defined by story or content. Rather, adventure describes a manner of gameplay without reflex challenges or action. They normally require the player to solve various puzzles by interacting with people or the environment, most often in a non-confrontational way. It is considered a "purist" genre and tends to exclude anything which includes action elements beyond a mini game.');
INSERT INTO genre(type, description) 
	VALUES ('Role-playing', 'Role-playing video games draw their gameplay from traditional [not always] role-playing games like Dungeons & Dragons. Most of these games cast the player in the role of one or more "adventurers" who specialize in specific skill sets (such as melee combat or casting magic spells) while progressing through a predetermined storyline. Many involve manoeuvring these character(s) through an overworld, usually populated with monsters, that allows access to more important game locations, such as towns, dungeons, and castles. Since the emergence of affordable home computers coincided with the popularity of paper and pencil role-playing games, this genre was one of the first in video games and continues to be popular today. Gameplay elements strongly associated with RPG, such as statistical character development through the acquisition of experience points, have been widely adapted to other genres such as action-adventure games. Though nearly all of the early entries in the genre were turn-based games, manymodern role-playing games progress in real-time. ');
INSERT INTO genre(type, description) 
	VALUES ('Simulation', 'Simulation video games is a diverse super-category of games, generally designed to 
					closely simulate aspects of a real or fictional reality.');
INSERT INTO genre(type, description) 
	VALUES ('Strategy', 'Strategy video games focus on gameplay requiring careful and skillful thinking and planning in order to achieve victory and the action scales from world domination to squad-based tactics. In most strategy video games, says Andrew Rollings, "the player is given a godlike view of the game world, indirectly controlling the units under his command."[28] Rollings also notes that "The origin of strategy games is rooted in their close cousins, board games."[28] Strategy video games generally take one of four archetypal forms, depending on whether the game is turn-based or real-time and whether the games focus is upon strategy or tactics.'
INSERT INTO genre(type, description) 
	VALUES ('Sports',' Sports are video games that simulate sports. This opposing team(s) can be controlled by other real life people or artificial intelligence.');

INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'Nintendo Entertainment System', 1983);
INSERT INTO platform(make, name, year) VALUES ('Sega', 'Master System', 1985);
INSERT INTO platform(make, name, year) VALUES ('Commodore', 'Commodore 64', 1990);
INSERT INTO platform(make, name, year) VALUES ('Sega', 'Genesis/Mega Drive', 1988);
INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'Super NES', 1990);
INSERT INTO platform(make, name, year) VALUES ('Sony', 'PlayStation', 1994);
INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'Nintendo 64', 1996);
INSERT INTO platform(make, name, year) VALUES ('Sega', 'Saturn', 1994);
INSERT INTO platform(make, name, year) VALUES ('Atari', 'Jaguar', 1993);
INSERT INTO platform(make, name, year) VALUES ('Sega', 'Dreamcast', 1998);
INSERT INTO platform(make, name, year) VALUES ('Sony',	'PlayStation 2', 2000);
INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'GameCube', 2001);
INSERT INTO platform(make, name, year) VALUES ('Microsoft', 'Xbox', 2001);
INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'Wii', 2006);
INSERT INTO platform(make, name, year) VALUES ('Microsoft', 'Xbox 360', 2005);
INSERT INTO platform(make, name, year) VALUES ('Sony', 'PlayStation 3', 2006);
INSERT INTO platform(make, name, year) VALUES ('Nintendo', 'Wii U', 2012);
INSERT INTO platform(make, name, year) VALUES ('Sony', 'PlayStation 4', 2013);
INSERT INTO platform(make, name, year) VALUES ('Microsoft', 'Xbox One', 2013);
INSERT INTO platform(make, name, year) VALUES ('Various', 'PC', NULL);
INSERT INTO platform(make, name, year) VALUES ('Apple', 'MAC-OS', NULL);

INSERT INTO publisher(name, location, yearEstab) VALUES ('Nintendo', 'Kyoto, Japan', 1889);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Valve Corporation', 'Bellevue, WA', 1996);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Rockstar Games', 'New York City, NY', 1998);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Electronic Arts', 'Redwood City', 1982);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Activision Blizzard', 'Santa Monica, CA', 2007);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Sony Computer Entertainment', 'Tokyo, Japan', 1993);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Ubisoft', 'Montreuil, France', 1986);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Sega Games', 'Tokyo, Japan', 1940);
INSERT INTO publisher(name, location, yearEstab) VALUES ('BioWare', 'Edmonton, Alberta, Canada', 1995);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Naughty Dog Inc', 'Santa Monica, CA', 1984);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Square-Enix', 'Toyo, Japan', 1975);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Capcom Company', 'Osaka, Japan', 1979);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Bungie', 'Bellevue, WA', 2000);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Microsoft', 'Redmon, WA', 1975);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Bandai Namco Entertainment', 'Tokyo, Japan', 1955);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Mojang', 'Stockholm, Sweden', 2009);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Epic Games', 'Cary, North Carolina', 1991);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Game Freak', 'Tokyo, Japan', 1989);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Insomniac Games', 'Burbank, CA', 1994);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Infinity Ward', 'Woodland Hills, LA', 2002);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Take-Two Interactive', 'New York City, NY and Windsor, UK', 1993);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Gameloft', 'Paris, France', 2000);
INSERT INTO publisher(name, location, yearEstab) VALUES ('ZeniMax Media', 'Rockville, MD', 1999);
INSERT INTO publisher(name, location, yearEstab) VALUES ('NCSOFT', 'Seoul, South Kora', 1997);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Blizzard Entertainment', 'Irvine, CA', 1991);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Zynga', 'San Francisco, CA', 2007);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Nexon Co.', 'Tokyo, Japan', 1994);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Konami', 'Tokyo, Japan', 1969);
INSERT INTO publisher(name, location, yearEstab) VALUES ('Bethesda', 'Rockville, MD', 2002);



--Select queries
SELECT * FROM game WHERE name LIKE "%'+req.query.search+'%"
SELECT * FROM game
SELECT * FROM publisher
SELECT * FROM genre
SELECT * FROM review
SELECT * FROM platform
SELECT gameID FROM game
SELECT type FROM genre
SELECT name FROM platform
SELECT * FROM game WHERE gameID = ' "+req.params.gameID+"'
SELECT * FROM publisher WHERE publisherID = ' "+req.params.publisherID+"'
SELECT * FROM genre WHERE genreID = ' "+req.params.genreID+"'
SELECT * FROM review WHERE reviewID = ' "+req.params.reviewID+" '
SELECT * FROM platform WHERE platformID = ' "+req.params.platformID+"'
SELECT * FROM game g INNER JOIN publisher p ON p.publisherID = g.publisherID
SELECT score FROM review r INNER JOIN game g ON g.gameID = r.gameID
SELECT type FROM genre g INNER JOIN game_genre gg ON gg.genreID = g.genreID
SELECT name FROM platform p INNER JOIN game_platform gp ON gp.platformID = p.platformID
SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_SCHEMA = 'cs340_phankhoa' AND TABLE_NAME = 'game'

--Insert queries
INSERT INTO game (`name`, `releasedate`, `publisherID`) 
	VALUES ([game.name], [game.releasedate], [game.publisherID])
INSERT INTO game_genre (`genreID`, `gameID`) 
	VALUES (genreID, [game_genre.gameID])
INSERT INTO game_platform (`platformID`, `gameID`) 
	VALUES (platformID, [game_platform.gameID])
INSERT INTO genre (`type`, `description`) 
	VALUES ([genre.type], [genre.description])
INSERT INTO review (`gameID`, `score`, `description`) 
	VALUES ([review.gameID], [review.score], [review.description])
INSERT INTO publisher (`name`, `location`, `yearEstab`) 
	VALUES ([publisher.name], [publisher.location], [publisher.yearEstab])
INSERT INTO platform (`make`, `name`, `year`) 
	VALUES ([platform.make], [platform.name], [platform.year])

--Update queries
UPDATE game SET name=[game.name], releasedate=[game.releasedate], publisherID=[game.publisherID] 
	WHERE gameID=' "+req.params.gameID+" '
UPDATE genre SET type=[genre.type], description=[genre.description] 
	WHERE genreID=' "+req.params.genreID+" '
UPDATE review SET score=[review.score], description=[review.description] 
	WHERE reviewID=' "+req.params.reviewID+" '
UPDATE publisher SET name=[publisher.name], location=[publisher.location], yearEstab=[publisher.yearEstab]
	WHERE publisherID=' "+req.params.publisherID+" '
UPDATE platform SET make=[platform.make], name=[platform.name], year=[platform.year] 
	WHERE platformID=' "+req.params.platformID+" '

--Delete queries
DELETE FROM game_genre WHERE gameID=' "+req.params.gameID+" ' AND genreID
DELETE FROM game_platform WHERE gameID=' "+req.params.gameID+" ' AND platformID
DELETE FROM game WHERE gameID=' "+req.params.gameID+" '
DELETE FROM review WHERE gameID=' "+req.params.gameID+" '
DELETE FROM genre WHERE genreID=' "+req.params.genreID+" '
DELETE FROM review WHERE reviewID=' "+req.params.reviewID+" '
DELETE FROM publisher WHERE publisherID=' "+req.params.publisherID+" '
DELETE FROM platform WHERE platformID=' "+req.params.platformID+" '

--Utility queries
SET FOREIGN_KEY_CHECKS=0
SET FOREIGN_KEY_CHECKS=1