SELECT * FROM animals
WHERE name LIKE '%mon'

SELECT name FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals
WHERE neutered = 'Yes' AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = 'yes';

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;
SELECT * FROM animals;
-- Changes happend in the database



BEGIN TRANSACTION;
DELETE FROM animals
SELECT COUNT(*) FROM ANIMALS;

-- Deleted all the animals

ROLLBACK;

SELECT COUNT(*) FROM ANIMALS;


BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO my_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) as total_attempts
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
select name from animals a
JOIN owners o 
ON a.owner_id = o.id
WHERE full_name = 'Melody Pond'

-- List of all animals that are pokemon (their type is Pokemon).

select a.name, s.name AS type from animals a
JOIN species s 
USING(ID)
WHERE s.name = 'Pokemon'

    -- List all owners and their animals, remember to include those that don't own any animal.
select o.full_name, a.name AS type from owners o
LEFT JOIN animals a 
on a.owner_id = o.id

-- How many animals are there per species?
select s.name, count(a.name) from species s
JOIN animals a
USING(id)
GROUP BY s.name
-- List all Digimon owned by Jennifer Orwell.
select a.name from animals a
JOIN owners o
ON a.owner_id = o.id
JOIN species s
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals
WHERE owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
AND escape_attempts = 0;

-- Who owns the most animals?

SELECT owners.full_name, COUNT(animals.id) AS num_animals
FROM owners
INNER JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY num_animals DESC
LIMIT 1;


