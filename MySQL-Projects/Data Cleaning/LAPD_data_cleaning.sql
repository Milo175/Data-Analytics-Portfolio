SELECT *
FROM crime_data_from_2020_to_present

;
#1 check for duplicates - none found
SELECT 
	COUNT(DR_NO) as a,
    DR_NO
FROM crime_data_from_2020_to_present
GROUP BY DR_NO
HAVING a > 2

;
#2 clean the inconsistent use of multiple white spaces in location values
UPDATE crime_data_from_2020_to_present
SET LOCATION = TRIM(REGEXP_REPLACE(LOCATION, ' {2,}', ' '))

;
#3 clean the inconsistent use of multiple white spaces in cross street values
UPDATE crime_data_from_2020_to_present
SET `Cross Street` = TRIM(REGEXP_REPLACE(`Cross Street`, ' {2,}', ' '))

;
#4 check text for typo's & other inconsistencies
SELECT 
	DISTINCT(`Crm Cd Desc`) as a
FROM crime_data_from_2020_to_present
ORDER BY a

;
#5 separate the mocodes by each individual code, will help later analysis on mocodes 1/2
ALTER TABLE crime_data_from_2020_to_present
ADD COLUMN Mocodes_1 INT,
ADD COLUMN Mocodes_2 INT,
ADD COLUMN Mocodes_3 INT,
ADD COLUMN Mocodes_4 INT,
ADD COLUMN Mocodes_5 INT,
ADD COLUMN Mocodes_6 INT,
ADD COLUMN Mocodes_7 INT,
ADD COLUMN Mocodes_8 INT,
ADD COLUMN Mocodes_9 INT,
ADD COLUMN Mocodes_10 INT

;
#6 separate the mocodes by each individual code, will help later analysis on mocodes 2/2
UPDATE crime_data_from_2020_to_present
SET
  Mocodes_1 = TRIM(SUBSTRING_INDEX(Mocodes, ' ', 1)),
  Mocodes_2 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 4 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 2), ' ', -1))
    ELSE NULL
  END,
  Mocodes_3 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 9 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 3), ' ', -1))
    ELSE NULL
  END,
  Mocodes_4 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 14 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 4), ' ', -1))
    ELSE NULL
  END,
  Mocodes_5 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 19 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 5), ' ', -1))
    ELSE NULL
  END,
  Mocodes_6 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 24 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 6), ' ', -1))
    ELSE NULL
  END,
  Mocodes_7 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 29 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 7), ' ', -1))
    ELSE NULL
  END,
  Mocodes_8 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 34 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 8), ' ', -1))
    ELSE NULL
  END,
  Mocodes_9 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 39 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 9), ' ', -1))
    ELSE NULL
  END,
  Mocodes_10 = CASE
    WHEN CHAR_LENGTH(Mocodes) > 44 THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Mocodes, ' ', 10), ' ', -1))
    ELSE NULL
  END
WHERE Mocodes <> ''

;
#7 change the age to NULL where age = 0 or blank to prevent it from influencing analysis
UPDATE crime_data_from_2020_to_present
SET `VICT AGE` = NULL
WHERE `VICT AGE` = 0 OR `VICT AGE` = -4 OR `VICT AGE` = -1

;
#8 split the TIME OCC in Hours and Minutes for later analysis, to avoid confusing visualizations as minutes go until 60 part 1/2
ALTER TABLE crime_data_from_2020_to_present
ADD COLUMN `TIME HOUR` INT,
ADD COLUMN `TIME MINUTE` INT

;
#9 split the TIME OCC in Hours and Minutes for later analysis, to avoid confusing visualizations as minutes go until 60 part 2/2
UPDATE crime_data_from_2020_to_present
SET 
	`TIME HOUR` = LEFT(`TIME OCC`, 2),
    `TIME MINUTE` = RIGHT(`TIME OCC`, 2)
    
;
#10 add another column to split the location street and number part
ALTER TABLE crime_data_from_2020_to_present
MODIFY COLUMN `street_number` VARCHAR(20)

;
#11 add the numerical value of street name into the new street_name column
UPDATE crime_data_from_2020_to_present
SET `street_number` = SUBSTRING_INDEX(LOCATION, ' ', 1)
WHERE LOCATION REGEXP '^[0-9]' 
AND SUBSTRING_INDEX(LOCATION, ' ', 1) NOT REGEXP '^[0-9]+(rd|th|nd|st)$'

;
#12 If street has numbers in it, its at the start. Below code locates the position of the first space, indicating the switch from numbers to characters and modifies the street name to only keep the characters
UPDATE crime_data_from_2020_to_present
SET LOCATION = LTRIM(SUBSTRING(LOCATION FROM LOCATE(' ', LOCATION, +1)))
WHERE LOCATION REGEXP'^[0-9]'
AND SUBSTRING_INDEX(LOCATION, ' ', 1) NOT REGEXP '^[0-9]+(rd|th|nd|st)$'

;
#13 change chronological order of columns to match the location hierarchy
ALTER TABLE crime_data_from_2020_to_present
MODIFY COLUMN `street_number` VARCHAR(20)
AFTER `Crm Cd 4`

;
#14 modify column name of Street Name to increase readability
ALTER TABLE crime_data_from_2020_to_present
CHANGE LOCATION street_name TEXT

;
#15 modify column name of Cross Street to increase readability
ALTER TABLE crime_data_from_2020_to_present
CHANGE `Cross Street` cross_street_name TEXT

;
#16 remove timestamp "12:00:00 AM" from all Date columns, since its false & the TIME OCC already exists
UPDATE crime_data_from_2020_to_present
SET 
	`Date Rptd` = LEFT(`Date Rptd`, 10),
	`DATE OCC` = LEFT(`DATE OCC`, 10)

;
#17 change order of columns to match location hierarchy
ALTER TABLE crime_data_from_2020_to_present
MODIFY COLUMN `TIME HOUR` INT AFTER `TIME OCC`,
MODIFY COLUMN `TIME MINUTE` INT AFTER `TIME HOUR`

;
#18 calculate the count for each individual mo_code to identify most common operation methods per year
SELECT 
    new_date,
    mocode, 
    COUNT(*) AS mocode_count
FROM (
    SELECT Mocodes_1 AS mocode, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) as new_date FROM crime_data_from_2020_to_present WHERE Mocodes_1 IS NOT NULL
    UNION ALL
    SELECT Mocodes_2, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_2 IS NOT NULL
    UNION ALL
    SELECT Mocodes_3, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_3 IS NOT NULL
    UNION ALL
    SELECT Mocodes_4, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_4 IS NOT NULL
    UNION ALL
    SELECT Mocodes_5, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_5 IS NOT NULL
    UNION ALL
    SELECT Mocodes_6, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_6 IS NOT NULL
    UNION ALL
    SELECT Mocodes_7, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_7 IS NOT NULL
    UNION ALL
    SELECT Mocodes_8, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_8 IS NOT NULL
    UNION ALL
    SELECT Mocodes_9, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_9 IS NOT NULL
    UNION ALL
    SELECT Mocodes_10, YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) FROM crime_data_from_2020_to_present WHERE Mocodes_10 IS NOT NULL
) AS mocodes_sub
GROUP BY new_date, mocode

;
#19 clean street names - ending in TH become TH ST
UPDATE crime_data_from_2020_to_present
SET street_name = REGEXP_REPLACE(street_name, 'TH$', 'TH ST')
WHERE street_name REGEXP 'TH$'

;
#20 which street intersections have the highest count of crimes commited
SELECT 
	street_name,
    cross_street_name,
    COUNT(*)
FROM crime_data_from_2020_to_present
WHERE cross_street_name != ''
GROUP BY street_name, cross_street_name
ORDER BY COUNT(*) DESC

;
#21 calculate increase in overall crimes committed per area between 2023 and 2020 to determine highest increase
SELECT
	year_2020,
    area_2020,
    count_area_2020,
    year_2023,
    area_2023,
    count_area_2023,
    (count_area_2023 - count_area_2020) / count_area_2020 * 100 AS difference
FROM (
	SELECT
    `AREA NAME` AS area_2020,
    YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) AS year_2020,
    COUNT(*) AS count_area_2020
    FROM crime_data_from_2020_to_present
    WHERE YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) = 2020
    GROUP BY `AREA NAME`, year_2020
    ) AS sub1
LEFT JOIN (
	SELECT
    `AREA NAME` AS area_2023,
    YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) AS year_2023,
    COUNT(*) AS count_area_2023
    FROM crime_data_from_2020_to_present
    WHERE YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) = 2023
    GROUP BY `AREA NAME`, year_2023
    ) AS sub2
ON sub1.area_2020 = sub2.area_2023
ORDER BY difference DESC

;
#22 which street intersections have the highest count of crimes committed
SELECT 
	street_name,
    cross_street_name,
    COUNT(*)
FROM crime_data_from_2020_to_present
WHERE cross_street_name != ''
GROUP BY street_name, cross_street_name
ORDER BY COUNT(*) DESC

;
#23 calculate increase in overall crimes committed per area between 2023 and 2020 to determine highest increase over 3 years
SELECT
	year_2020,
    area_2020,
    count_area_2020,
    year_2023,
    area_2023,
    count_area_2023,
    (count_area_2023 - count_area_2020) / count_area_2020 * 100 AS difference
FROM (
	SELECT
    `AREA NAME` AS area_2020,
    YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) AS year_2020,
    COUNT(*) AS count_area_2020
    FROM crime_data_from_2020_to_present
    WHERE YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) = 2020
    GROUP BY `AREA NAME`, year_2020
    ) AS sub1
LEFT JOIN (
	SELECT
    `AREA NAME` AS area_2023,
    YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) AS year_2023,
    COUNT(*) AS count_area_2023
    FROM crime_data_from_2020_to_present
    WHERE YEAR(STR_TO_DATE(`DATE OCC`, '%m/%d/%Y')) = 2023
    GROUP BY `AREA NAME`, year_2023
    ) AS sub2
ON sub1.area_2020 = sub2.area_2023
ORDER BY difference DESC

;
#24 types of crimes with highest percentage of unresolved cases compared to total amount of cases
SELECT
	t1.`Crm Cd Desc` AS crime_one,
    t1.status,
    COUNT(t1.status) AS count_ic,
    t2.count_total,
    ROUND(COUNT(t1.status) / t2.count_total * 100, 2) AS percent_ic
FROM crime_data_from_2020_to_present AS t1
LEFT JOIN (
	SELECT
		`Crm Cd Desc` AS crime_two,
        COUNT(*) AS count_total
	FROM crime_data_from_2020_to_present
    GROUP BY `Crm Cd Desc`
) as t2
ON t1.`Crm Cd Desc` = t2.crime_two
WHERE status = 'IC'
AND count_total >= 50000
GROUP BY crime_one, t1.status, t2.count_total
ORDER BY percent_ic DESC
;
