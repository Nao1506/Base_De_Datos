CREATE DATABASE pokemonP;
USE pokemonP;

CREATE TABLE Entrenadores (
    id_entrenador INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Ciudad VARCHAR(20),
    FOREIGN KEY (id_gimnasio) REFERENCES Gimnasios(id_gimnasio)
);

CREATE TABLE Gimnasios (
    id_gimnasio INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Ciudad VARCHAR(50),
    Lider VARCHAR(20)
);

CREATE TABLE Tipos (
    id_tipo INT PRIMARY KEY,
    Nombre_tipo VARCHAR(50)
);

CREATE TABLE Pokemons (
    id_pokemon INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Nivel VARCHAR(50),
    Poder VARCHAR(20),
    FOREIGN KEY (id_tipo) REFERENCES Tipos(id_tipo),
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador)
);

CREATE TABLE Batalla (
    id_batalla INT PRIMARY KEY,
    fecha DATE,
    pokemon1 INT,
    pokemon2 INT,
    ganador INT,
    FOREIGN KEY (pokemon1) REFERENCES Pokemon(id_pokemon),
    FOREIGN KEY (pokemon2) REFERENCES Pokemon(id_pokemon),
    FOREIGN KEY (ganador) REFERENCES Pokemon(id_pokemon)
);

SELECT e.nombre, e.ciudad, g.nombre AS gimnasio
FROM Entrenador e
JOIN Gimnasio g ON e.id_gimnasio = g.id_gimnasio;

SELECT p.nombre, t.nombre_tipo
FROM Pokemon p
JOIN Tipo t ON p.id_tipo = t.id_tipo;

SELECT *
FROM Pokemon
WHERE nivel > 50;

SELECT p.nombre, p.poder, e.nombre AS entrenador
FROM Pokemon p
JOIN Tipo t ON p.id_tipo = t.id_tipo
JOIN Entrenador e ON p.id_entrenador = e.id_entrenador
WHERE t.nombre_tipo = 'Fuego'
ORDER BY p.poder ASC;

SELECT p.nombre
FROM Pokemon p
WHERE id_entrenador IN (
    SELECT id_entrenador
    FROM Entrenador
    WHERE ciudad = 'Celadon'
);

SELECT nombre, nivel
FROM Pokemon
WHERE nivel > (
    SELECT AVG(nivel)
    FROM Pokemon
);

SELECT nombre
FROM Pokemon
WHERE id_pokemon IN (
    SELECT ganador
    FROM Batalla
);

CREATE PROCEDURE SubirNivel
    @IdEntrenador INT
AS
BEGIN
    UPDATE Pokemon
    SET nivel = nivel + 1
    WHERE id_entrenador = @IdEntrenador;
END;

CREATE PROCEDURE RegistrarBatalla
    @Pokemon1 INT,
    @Pokemon2 INT,
    @Ganador INT,
    @Fecha DATE
AS
BEGIN
    INSERT INTO Batalla(fecha, pokemon1, pokemon2, ganador)
    VALUES(@Fecha, @Pokemon1, @Pokemon2, @Ganador);
END;