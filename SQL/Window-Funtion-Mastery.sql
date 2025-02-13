--Window funtions advanced


--Total number of animals column with a filter
SELECT 
	Species,
	name,
	primary_color,
	count(*)  FILTER(WHERE admission_date >= '2017-01-01') OVER () As number_of_animals
FROM animals
ORDER BY admission_date

--Slightly faster way to do it. 
SELECT 
	Species,
	name,
	primary_color,
	count(*) OVER () As number_of_animals
FROM animals
WHERE admission_date >= '2017-01-01'
ORDER BY admission_date


--Looking at the days an anaimal has been there since the newest arrival of thier species.
SELECT 
	Species,
	name,
	admission_date,
	MAX(admission_date)OVER (PARTITION BY Species) as oldest_per_species,
	EXTRACT(DAY FROM AGE(MIN(admission_date)OVER (PARTITION BY Species) , admission_date)) +
	EXTRACT(MONTH FROM AGE(MIN(admission_date)OVER (PARTITION BY Species) , admission_date) * 30) +
	EXTRACT(YEAR FROM AGE(MIN(admission_date)OVER (PARTITION BY Species) , admission_date) * 365) * -1
	as days_older
FROM animals

--Running count of animals per species.
SELECT 
	Species,
	name,
	primary_color,
	count(*) OVER (PARTITION BY species ORDER BY name) As number_of_animals
FROM animals



