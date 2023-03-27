CREATE DATABASE vet_clinic

CREATE TABLE animals(
	id integer PRIMARY KEY,
	name INTEGER NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL
)