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

Id is already a primary key and its auto increament. So don't need to add it again.
