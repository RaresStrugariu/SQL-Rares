CREATE DATABASE Movie

CREATE TABLE Director (
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirthDate date,

);


INSERT INTO Director
VALUES

('Quentin','Tarantino','USA','1963-03-27'),
('Steven','Spielberg','USA','1946-12-18'),
('Martin','Scorsese','USA','1942-11-17'),
('Alfred','Hitchcock','UK','1899-08-13'),
('Stanley','kubrick','USA','1928-06-26');


DELETE FROM Director WHERE Id=3



CREATE TABLE Movie (
ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
DirectorID INT CONSTRAINT fk_DirectorID REFERENCES Director(ID),
Title nvarchar(MAX),
ReleaseDate Date,
Rating int,
Duration time,
GenreName nvarchar(MAX)
);


INSERT INTO Movie
VALUES
(1,'Pulp Fiction','1994-09-10','5','1:05:50'),
(2,'Schindler"s List','1994-02-4','6','4:04:22'),
(3,'The Taxi Driver','1976-02-08','7','3:14:51'),
(3,'Psycho','1960-09-8', '8','3:33:05'),
(2,'A Space Odyssey','1968-05-12','9','2:04:22');


UPDATE Movie SET Title='MovieUpdated' WHERE Rating<10;

Select * from Movie


CREATE TABLE Actor (
ActorId int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirthDate date,
PopularityRating int
);


INSERT INTO Actor
VALUES
('Liam','Nelson','UK','1952-06-07','1'),
('Robert','DeNiro','Spania','1945-07-17','2'),
('Anthony','perkins','USA','1932-04-04','3')

SELECT MIN(Rating) AS SmallestRating FROM Movie;


SELECT MAX(Id) AS MostMovieDirected FROM Director;


SELECT * FROM Director ORDER BY LastName ASC;
SELECT * FROM Director ORDER BY BirthDate DESC;


UPDATE Movie SET Rating = Rating + 1 WHERE DirectorId=5;

CREATE TABLE MovieActor (
    MovieId int IDENTITY(1,1) PRIMARY KEY,
	DirectorId int CONSTRAINT fk_director REFERENCES Director(Id),
	ActorId int CONSTRAINT fk_actor REFERENCES Actor(ActorId)
);

INSERT INTO MovieActor(DirectorId,ActorId) VALUES(1,5);

CREATE TABLE Genre(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(MAX) NOT NULL
);

CREATE TABLE MovieGenre(
	MovieId int CONSTRAINT fk_movieId REFERENCES Movie(Id),
	GenreId int CONSTRAINT fk_genreId REFERENCES Genre(Id)
);

INSERT INTO Genre(Name) VALUES('Horror');
INSERT INTO Genre(Name) VALUES('Drama');
SELECT * FROM Genre;

INSERT INTO MovieGenre(MovieId,GenreId) VALUES(2,1);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(5,2);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(1,2);

SELECT A.ActorId, COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId 
INNER JOIN Movie m ON ma.MovieId =m.Id 
INNER JOIN Director d ON m.DirectorId=d.Id
GROUP BY A.ActorId
HAVING COUNT(d.Id) >= (SELECT COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId 
INNER JOIN Movie m ON ma.MovieId =m.Id 
INNER JOIN Director d ON m.DirectorId=d.Id
GROUP BY A.ActorId)


SELECT A.FirstName, A.LastName,g.Name
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId 
INNER JOIN Movie m ON ma.MovieId =m.Id 
INNER JOIN MovieGenre mg ON m.Id=mg.MovieId 
INNER JOIN Genre g ON mg.GenreId=g.Id