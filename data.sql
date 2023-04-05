INSERT INTO animals(
	name, date_of_birth,
	escape_attempts, neutered,
	weight_kg)

VALUES(
	'Agumon', '2020-02-03',
	'0', 'yes', '10.23'
)

INSERT INTO animals(
	name, date_of_birth,
	escape_attempts, neutered,
	weight_kg)
VALUES(
	'Gabumon', '2018-11-15',
	'2', 'yes', '8'
)

INSERT INTO animals(
	name, date_of_birth,
	escape_attempts, neutered,
	weight_kg)

VALUES(
	'Pikachu', '2021-01-07',
	'1', 'no', '15.04'
)

INSERT INTO animals(
	name, date_of_birth,
	escape_attempts, neutered,
	weight_kg)
    
VALUES(
	'Devimon', '2017-05-12',
	'5', 'yes', '11'
)

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', -11, 'no', 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2021-11-15', -5.7, 'yes', 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, 'yes', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45, 'no', 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, 'yes', 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17, 'yes', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22, 'yes', 4);

INSERT INTO owners(full_name, age)
VALUES  ('Sam Smith',34 ), 
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38)

INSERT INTO species(name)
VALUES  ('Pokemon' ), 
		('Digimon')


UPDATE animals
SET species_id =
CASE 
	WHEN name ILIKE '%mon' THEN(SELECT id FROM species WHERE name = 'Digimon')
	ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;


UPDATE animals SET owner_id = (
    CASE 
        WHEN name ILIKE '%Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name ILIKE '%Gabumon' OR name ILIKE '%Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name ILIKE '%Devimon' OR name ILIKE '%Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name ILIKE '%Charmander' OR name ILIKE '%Squirtle' OR name ILIKE '%Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name ILIKE '%Angemon' OR name ILIKE '%Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END
);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';





