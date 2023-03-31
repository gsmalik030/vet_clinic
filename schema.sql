CREATE DATABASE vet_clinic

CREATE TABLE animals(
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL
)

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(55),
  age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(55) NOT NULL
);

ALTER TABLE animals 
ADD COLUMN owner_id INTEGER REFERENCES owners(id),
ADD COLUMN species_id INTEGER REFERENCES species(id),
DROP COLUMN species

Id is already a primary key and its auto increament. So dont need to add it again.


CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INTEGER NOT NULL,
  date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets (id),
    species_id INT REFERENCES species (id)
);

CREATE TABLE visits (
    animal_id INT REFERENCES animals (id),
    vet_id INT REFERENCES vets (id),
    date_of_visit DATE
);