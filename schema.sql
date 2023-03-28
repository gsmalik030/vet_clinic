CREATE DATABASE vet_clinic

CREATE TABLE animals(
	id SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INTEGER NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL
)
