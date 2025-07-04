CREATE TABLE rangers (
     ranger_id SERIAL PRIMARY KEY NOT NULL,
     name VARCHAR(100) NOT NULL,
     region varchar(100) NOT NULL   
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY NOT NULL,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status  VARCHAR(30) NOT NULL
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY NOT NULL,
    species_id INT REFERENCES species (species_id),
    ranger_id INT REFERENCES rangers (ranger_id),
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

SELECT * from rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings;

-- problem-1 
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');

-- problem-2 
SELECT count(DISTINCT species_id) as unique_species_count FROM sightings;

-- problem-3 
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- problem-4
SELECT name, count(*) as total_sightings 
FROM rangers 
INNER JOIN sightings
ON rangers.ranger_id = sightings.ranger_id
GROUP BY name
ORDER BY name;

-- problem-5
SELECT common_name
FROM species 
LEFT JOIN sightings
ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;

-- problem-6
SELECT common_name, sighting_time, name 
FROM species 
JOIN sightings
ON species.species_id = sightings.species_id
JOIN rangers
ON rangers.ranger_id = sightings.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problem-7
UPDATE species 
SET conservation_status='Historic'
WHERE EXTRACT(year FROM discovery_date::date) < 1800

-- problem-8
SELECT sighting_id,
    CASE 
        WHEN EXTRACT(hour from sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(hour from sighting_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening' 
    END AS time_of_day
FROM sightings;

-- problem-9
DELETE
FROM rangers 
WHERE NOT EXISTS (
    SELECT 1
    FROM sightings
    WHERE rangers.ranger_id = sightings.ranger_id
);
