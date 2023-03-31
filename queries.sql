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

ORDER BY COUNT(vet_clinic.animals.name) DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, visits.date_of_visit FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals
ON animals.id = visits.animal_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(DISTINCT visits.animal_id) FROM vets
JOIN visits
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets             
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name AS "VET NAME", animals.name AS "ANIMAL NAME", visits.date_of_visit AS "DATE OF VISIT" FROM vets
JOIN visits
ON vets.id = visits.vet_id
JOIN animals
ON visits.animal_id = animals.id                                                   
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS "ANIMAL NAME", COUNT(animals.id) AS "NUMBER OF VISITS TO VET" FROM visits
JOIN animals
ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS "NAME",
animals.date_of_birth AS "BIRTHDATE",
animals.escape_attempts AS "ESCAPE ATTEMPTS",
animals.neutered AS "NEUTERED",
animals.weight_kg AS "WEIGHT",
species.name AS "TYPE",
vets.name AS "VET NAME",
vets.age AS "VET AGE",
vets.date_of_graduation AS "DATE OF GRAD",
visits.date_of_visit AS "DATE OF VISIT" FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN species
ON animals.species_id = species.id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT animals.name AS "ANIMAL NAME",
COUNT(visits.animal_id) AS "NUMBER OF VISITS",
vets.name AS "VET NAME",
specializations.species_id AS "SPECIALTIES" FROM visits
JOIN animals
ON animals.id = visits.animal_id
FULL JOIN specializations
ON visits.vet_id = specializations.vet_id
JOIN vets
ON visits.vet_id = vets.id
GROUP BY visits.animal_id, visits.vet_id, animals.name,
specializations.species_id, vets.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS "SPECIES TYPE",
COUNT(visits.animal_id) AS "NUMBER OF VISITS",
vets.name AS "VET NAME" FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, animals.species_id, species.name
ORDER BY animals.species_id DESC
LIMIT 1;
