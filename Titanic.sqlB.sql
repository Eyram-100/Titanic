
CREATE DATABASE Titanic;
USE Titanic;

-- Nombre de pasagers ayant survecus
SELECT 
	COUNT(*) AS nombre_survivants
FROM
	titanic
WHERE
	Survived = 1;

-- Repartition en genre des passagers
SELECT
	Sex,
	COUNT(*) AS nombre,
	ROUND(COUNT(*) *100/ (SELECT COUNT(*) FROM titanic), 2) AS pourcentage
FROM 
    titanic
GROUP BY sex;

-- passagers ayant payé les tickets au prix les plus élevés
SELECT 
	TOP 5 name, CONVERT(NVARCHAR(50), Fare) --pas marche
FROM titanic
ORDER BY CONVERT(NVARCHAR(50), fare) DESC;

SELECT 
    TOP 5 Name, CONVERT(varchar(50), Fare) AS FareText
FROM titanic 
ORDER BY CONVERT(varchar(50), Fare) DESC;

SELECT 
	TOP 5 name, Fare FROM titanic
ORDER BY  fare DESC;

-- Repartition des survivants par genre
SELECT
	Sex,
	COUNT(*) AS nombre_survivants
FROM
	titanic
WHERE
	Survived = 1
GROUP BY Sex;

-- Repartition des survivants selon la classe de leur tickets
SELECT
	Pclass,
	COUNT(*) AS nombre_survivants
FROM titanic
WHERE Survived = 1
GROUP BY Pclass;  --je veux les survivants, de la table titanic, tu me les regrupe par class et tu compte toytes les lignes de la colonne Pclass et tu me les affiche

-- Profil des famille à bords
SELECT
	Parch AS Profil,
	COUNT(*) AS nombre
FROM titanic
WHERE Parch > 0
GROUP BY Parch;

-- Mise à jour des lieux d'embarcation
-- on ne veut pas avoir les C, S, Q dans le résultt don...
UPDATE titanic
SET 
	Embarked = CASE
	WHEN CONVERT(VARCHAR, Embarked) = 'C' THEN 'Cherbourg'
	WHEN CONVERT(VARCHAR, Embarked) = 'Q' THEN 'Queenstown'
	WHEN CONVERT(VARCHAR, Embarked) = 'S'THEN 'Southamoton'
	ELSE CONVERT(VARCHAR, Embarked)
END; 
-- Comment sont répartis les passagers selon le lieu d'embarcation
SELECT 
	CONVERT(VARCHAR, Embarked),
	COUNT(*) AS nombre_passagers
FROM titanic
GROUP BY CONVERT(VARCHAR, Embarked);

-- COmbien de survivants avaient une cabine
SELECT
	COUNT(*) AS survived_with_cabine
FROM titanic
WHERE survived = 1 AND Cabin IS NOT NULL;

-- QUel était le prix moyen d'un ticket
SELECT
	AVG(fare) AS prix_moyen
FROM titanic;

-- QUel était le prix moyen d'un ticket par classe
SELECT
	Pclass,
	AVG(fare) AS prix_moyen
FROM titanic
GROUP BY Pclass;  --pas marche

-- Combien d'enfants ont survécus (passagers de moins de 18 ans)
SELECT 
	COUNT(*) AS nombre_survecus
FROM titanic
WHERE Survived = 1 AND Age < 18; --pas marche

-- Passagers ayant plus de 70 ans
SELECT 
    Name, 
    CONVERT(varchar(50), Age) AS AgeText
FROM titanic 
WHERE TRY_CAST(CAST(Age AS varchar(max)) AS float) >= 70;
