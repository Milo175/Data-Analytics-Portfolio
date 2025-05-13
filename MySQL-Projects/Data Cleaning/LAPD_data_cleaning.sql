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
#11 add the street name numbers into the new street_name column
UPDATE crime_data_from_2020_to_present
SET `street_number` = SUBSTRING_INDEX(LOCATION, ' ', 1)
WHERE LOCATION REGEXP '^[0-9]' 
AND SUBSTRING_INDEX(LOCATION, ' ', 1) NOT REGEXP '^[0-9]+(rd|th|nd|st)$'

;
#12 locates the position of the first space, indicating the switch from numbers to characters and changing accordingly
UPDATE crime_data_from_2020_to_present
SET LOCATION = LTRIM(SUBSTRING(LOCATION FROM LOCATE(' ', LOCATION, +1)))
WHERE LOCATION REGEXP'^[0-9]'
AND SUBSTRING_INDEX(LOCATION, ' ', 1) NOT REGEXP '^[0-9]+(rd|th|nd|st)$'

;
#13 change order of columns to match the location hierarchy
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