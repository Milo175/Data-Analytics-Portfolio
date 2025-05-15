# Data-Analytics-Portfolio
Los Angeles Police Department - Crime Statistics Analysis

## Introduction
Welcome to my first official GitHub ReadMe file! My name is Milo, and I am currently in the process of educating myself in the field of Data Analytics to make it my full-time profession. For this project, I decided to analyze the crime data in the City of Los Angeles from 2020 until 2025. The data of 2024 and 2025 is incomplete in this dataset, but I decided to still use the data, since the personal practice outweighs the data usability. 

Note from LAPD website:
> "This dataset reflects incidents of crime in the City of Los Angeles dating back to 2020. This data is transcribed from original crime reports that are typed on paper and therefore there may be some inaccuracies within the data. Some location fields with missing data are noted as (0°, 0°). Address fields are only provided to the nearest hundred block in order to maintain privacy. This data is as accurate as the data in the database. Please note questions or concerns in the comments."

<br><br>

## Problem Statements
**Nine statements** or questions have been formulated to solve within this dataset. 
1. Analyze victim age, sex, and most common area for different types of crime.
2. Identify the most common types of weapons used.
    - Does this differ per crime type?
3. How have crime rates evolved year-over-year
    - Compare crime patterns during COVID lockdowns (2020–2021) vs. post-lockdown.
    - Do crime rates differ per day of week?
4. What time in the day are most crimes committed?
    - Break it down by crime type (e.g., assaults at night vs. thefts in the morning).
5. Use LAT and LON coordinates to create a heatmap of high-crime zones within the City of Los Angeles
    - What are the high-crime zones in the City of Los Angeles?
    - Break it down by victim decent to find differences in high-crime zones per decent
6. Rank areas by frequency or severity of crimes.
    - Determine the most dangerous streets
    - Also determine the most dangerous intersections
7. Are certain crimes (e.g., robbery, assault) more prevalent against specific groups?
    - Identify whether specific groups are disproportionately targeted in certain areas.
8. Extract and visualize trends from Mocodes to see popular tactics or criminal behavior.
9. What percentage of crimes have an "IC" (investigation complete) or other statuses?
    - Which types of crimes are most likely to remain unresolved?
    - Calculate by total count per crimes and percentage of crimes status IC versus all statuses

<br><br>

## Skills Demonstrated
**MySQL** 
- Data Cleaning
- Standardization
- Removing outliers
- Data Analysis

**Microsoft Power BI** 
- Data Transformation
- Data Modeling 
- Data Modeling Hierarchy 
- DAX Measure Calculations
- New Column Calculations
- Visualization
    - Graph & Chart Creation
    - Filters
    - Data Drilling

<br><br>

## Data Sourcing
The data used for this analysis has been directly downloaded from the City of Los Angeles Police Department Governmental [website](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-Present/2nrs-mtv8/about_data)

> Data last updated: April 30, 2025

<br><br>

## Data Cleaning & Transformation <a name="anchor-data-cleaning-transformation"></a>
**Data Cleaning**
- Link to SQL file: [link](MySQL-Projects/Data%20Cleaning/LAPD_data_cleaning.sql)

**Data Transformation**
- Link to file with all DAX measure and calculated column formulas used for this project: [link](PowerBI-Projects/dax_and_columns)
- Or click [here](#anchor-extra-materials) to scroll to the extra material page in this ReadMe file to view them in a clear overview 

<br><br>

## Data Modeling 
One simple many to one (* > 1) data model was used to create the mo-code analysis page. For this page, I exported a table including each individual mo-code from each individual crime scene plus their count. I downloaded the mo-codes plus description from the LAPD website, and modeled them together to add the description to my own table. 

![](PowerBI-Projects/dax_and_columns/0data_model.png)

<br><br>

## Visualizations
Note: each slide includes a filter function to select specifics year(s) to highlight and investigate

### Slide 1: A General Analysis

![](PowerBI-Projects/Page%201.png)

### Slide 2: A bar chart with drill function to analyse common weapons used - description missing *included*
Note: please see analysis to see why weapon type 'description missing' is important to include and/or exclude

![](PowerBI-Projects/Page%202.png)

### Slide 3: A bar chart with drill function to analyse common weapons used - description missing *excluded*
Note: please see analysis to see why weapon type 'description missing' is important to include and/or exclude

![](PowerBI-Projects/Page%202.1.png)

### Slide 4: Drill down into the crime type 'Robbery' to view most common weapons used during robberies

![](PowerBI-Projects/Page%202.2.png)

### Slide 5: Overview of crimes committed year-to-year and a bar chart to show trend in crimes per weekday

![](PowerBI-Projects/Page%203.png)

### Slide 6: A bar chart visualizing the number of crimes commmitted per hour of the day - filter crime type: *all*

![](PowerBI-Projects/Page%204.png)

### Slide 7: A bar chart visualizing the number of crimes commmitted per hour of the day - filter crime type: *'Battery - Simple Assault'* 

![](PowerBI-Projects/Page%204.1.png)

### Slide 8: A bar chart visualizing the number of crimes commmitted per hour of the day - filter crime type: *'Intimate Partner - Simple Assault'*

![](PowerBI-Projects/Page%204.2.png)

### Slide 9: A bar chart visualizing the number of crimes commmitted per hour of the day - filter crime type: *'Vehicle - Stolen'*

![](PowerBI-Projects/Page%204.3.png)

### Slide 10: A bar chart visualizing the number of crimes commmitted per hour of the day - filter crime type: *'Theft of Identity'*

![](PowerBI-Projects/Page%204.4.png)

### Slide 11: A heatmap highlighting high crime areas in Los Angeles - filter set to *'Hispanic'* victim descent

![](PowerBI-Projects/Page%205.png)

### Slide 12: A bar chart highlighting crime count on streets with intersections - including drill function to view each street individually 

![](PowerBI-Projects/Page%206.png)

### Slide 13: Drill function set to *'6TH ST'* for demonstrating purposes 

![](PowerBI-Projects/Page%206.1.png)

### Slide 14: An overview of the victim descent and area names of crimes committed - right graph includes drill function for victim descent type per area 

![](PowerBI-Projects/Page%207.png)

### Slide 15: Drill function set to *'Central'* area for demonstrating purposes

![](PowerBI-Projects/Page%207.1.png)

### Slide 16: Left graph has victim descent type *'Black'* selected as a filter

![](PowerBI-Projects/Page%207.2.png)

### Slide 17: A bar chart showing distribution of victim descent - with drill function to view most common crimes each descent is targetted for

![](PowerBI-Projects/Page%208.png)

### Slide 18: Drill function set to victim descent *'Hispanic'* 

![](PowerBI-Projects/Page%208.1.png)

### **Slide 19: A treemap with most commonly used Modus Operandi (mo's) by criminals - slide filter included to select least to most common

![](PowerBI-Projects/Page%209.png)

### **Slide 20: An overview of the case statuses showing the distribution of statuses versus total cases and the most common types of crimes with a CI (continued investigation) status

![](PowerBI-Projects/Page%2010.png)

<br><br>

## Analysis & Conclusions

**1. Victim Demographics and Crime Locations**
We examined the top five most common crime types and analyzed victim age, sex, and the most frequent reporting districts:

| Crime Type               | Total Cases | Avg. Victim Age | Most Common Area | Male   | Female | Other/Unknown |
|--------------------------|-------------|------------------|------------------|--------|--------|----------------|
| Vehicle Stolen           | 115,234     | 41.2             | 77th Street      | 341    | 129    | 145,000        |
| Battery – Simple Assault | 74,842      | 40.5             | Central          | 39,200 | 35,100 | 475            |
| Burglary from Vehicle    | 63,516      | 38.2             | Central          | 35,400 | 26,500 | 1,500          |
| Theft of Identity        | 62,539      | 41.7             | 77th Street      | 25,800 | 35,800 | 918            |
| Vandalism – Felony       | 61,093      | 41.3             | Central          | 28,000 | 21,400 | 11,700         |

**Key Insights:**
- The average victim age ranges from 38 to 42 years.
- Crime locations are most frequently reported in 77th Street and Central divisions.
- Gender distribution varies per crime, with some (e.g. vehicle theft) having large amounts of unspecified gender data.
- In 2024–2025, cases with unspecified gender increased significantly—interpret data from these years with caution due to dataset incompleteness.

**2. Weapon Types and Their Use by Crime**
   
| Weapon Type         | Total   | Avg. Age | Top Area      | Male   | Female | Other/Unknown |
|---------------------|---------|----------|---------------|--------|--------|----------------|
| Strong Arm (No Weapon) | 174,770 | 36.6     | 77th Street    | 69,000 | 99,000 | 6,200          |
| Unknown/Other Weapon   | 36,390  | 41.2     | Pacific        | 18,800 | 13,700 | 3,900          |
| Verbal Threat          | 23,850  | 39.6     | 77th Street    | 11,000 | 11,500 | 1,300          |
| Handgun                | 20,180  | 34.5     | 77th Street    | 13,600 | 4,700  | 1,900          |

**Weapon Type Breakdown by Crime**:
- **Vehicle Stolen**: Weapon not described in 115K cases; next most common is Strong Arm (23 cases).
- **Battery – Simple Assault**: Strong Arm (67.5K) is by far the most common.
- **Burglary from Vehicle**: Mostly lacks weapon description (~60K).
- **Assault with Deadly Weapon**: Handgun (7.7K) and Strong Arm (7.1K) dominate.
- **Robbery**: Strong Arm (14K) and Handgun (5.9K) are most used.
- **Intimate Partner – Simple Assault**: Strong Arm (44K), then Unknown (2K).

**Note**: Over 678K incidents lack weapon description. This represents a significant gap in reporting and may affect long-term trend analysis unless addressed in future datasets.

**3. Crime Trends Over Time and by Day**
   
| Year | Reported Crimes |
|------|-----------------|
| 2020 | ~200,000        |
| 2021 | ~210,000        |
| 2022 | ~235,000        |
| 2023 | Slight decrease |

Day of the Week Patterns (2020–2023):
- **Friday** has the highest number of reported crimes (9% higher than Mon–Thu average).
- **Saturday** ranks second.
- **Tuesday** consistently records the fewest crimes.
- Patterns remained stable over the years.

**4. Time-of-Day Crime Patterns**
There is a **suspicious spike at 12:00** in nearly all crimes. This may indicate default administrative inputs when the actual time is unknown and should be investigated further.

**General Trend:**
- Early morning rise starts around **5:00–7:00**, peaks from **16:00 to 21:00**, and tapers off overnight.

**By Crime Type:**
- **Vehicle Stolen**: Peaks between **16:00–23:00**.
- **Battery – Simple Assault**: Peaks between **9:00–00:00**, with smaller morning spikes.
- **Burglary from Vehicle**: Spikes between **17:00–00:00**.
- **Theft of Identity**: Sharp spikes at **00:00 and 12:00**—requires further investigation.
- **Vandalism / Assault with Deadly Weapon**: Matches the general trend; peak at **21:00**, drop-off after **2:00**.

**5. Crime Hotspots (Heatmap) + Demographic Differences**
**Top High-Crime Areas (by Reporting Division):**
1. Central
2. 77th Street
3. Pacific
4. Southwest
5. Hollywood

**Fastest Growth in Crime:**

| Reporting Division | % Increase in Crime |
|---------------------|---------------------|
| Central             | +46.2%              |
| Rampart             | +27.8%              |
| Wilshire            | +26.1%              |

note: The overall increase in crime between 2020 and 2023 was **21.8%**

**Demographic Heatmap Patterns:**
- **Hispanic**: Most common in Mission, Newton, 77th Street, Hollenbeck.
- **White**: More active in Pacific, West LA, North Hollywood, Hollywood.
- **Black**: Highest in 77th Street, Southwest, Southeast.
- **Asian**: Concentrated in Olympic, Central, West LA.
- **Other / Unknown**: Evenly spread; unknown descent data too broad for clear conclusions.

**6. Most Dangerous Streets and Intersections**
**Streets with Highest Crime Totals**:
- 6th Street
- 7th Street
- Figueroa Street
  
note: 6th and 7th both report more than double the incidents of Figueroa

**Top 3 Intersections**:
| Intersection         | Reported Crimes |
|----------------------|------------------|
| 5th St & San Pedro   | 284              |
| 7th St & Figueroa    | 244              |
| 6th St & San Pedro   | 229              |


**7. Crime Targeting by Demographic Group**
Disproportionate Victimization Patterns:
- **Hispanic**: Battery, Assault w/ Deadly Weapon, Intimate Partner Assault
- **Black**: Battery, Assault w/ Deadly Weapon, Theft of Identity
- **White**: Burglary, Identity Theft
- **Asian**: Petty Theft, Identity Theft, Burglary from Vehicle
- **Other**: Burglary, Vandalism
- **Unknown**: Vehicle Theft, Petty Theft from Vehicles/Stores

note: Counts for **American Indian** and **Pacific Islander** groups were too low to draw statistically significant conclusions.

**8. Modus Operandi (MO Codes) Trends**
**Most common MO Codes:**

| MO Code | Description               | Count   |
|---------|---------------------------|---------|
| 1822    | Stranger                  | 342,000 |
| 344     | Removes Victim Property   | 299,000 |
| 913     | Victim Knew Suspect       | 142,000 |
| 329     | Vandalized                | 130,000 |
| 416     | Hit w/ Weapon             | 112,000 |

These patterns have remained stable over the years.

**9. Case Statuses: IC (Investigation Complete) and Resolution Trends**
A significant portion of crimes remain unresolved. Here's a breakdown of resolution percentages:

| Crime Type                    | IC Cases | Total Cases | % Resolved (IC) |
|-------------------------------|----------|-------------|------------------|
| Theft of Identity             | 61,560   | 62,539      | 98.4%            |
| Burglary from Vehicle         | 62,253   | 63,516      | 98.0%            |
| Petty Theft ($950 & Under)    | 50,877   | 53,718      | 94.7%            |
| Vehicle Stolen                | 107,873  | 115,234     | 93.6%            |
| Burglary                      | 51,075   | 57,875      | 88.3%            |
| Vandalism – Felony            | 50,789   | 61,093      | 83.1%            |
| Battery – Simple Assault      | 49,822   | 74,842      | 66.6%            |
| Assault w/ Deadly Weapon      | 32,295   | 53,528      | 60.3%            |

**Trend:**
“IC” cases increased slightly over time, but arrests (Adult Arrest - AA, Adult Other - AO) decreased, possibly pointing to decreased enforcement or efficiency.

<br><br>

## Recommendations
This section outlines promising directions for extending the analysis of LAPD crime data. These recommendations focus on deepening the understanding of crime patterns, improving contextual interpretation, and enhancing the dataset's value through complementary data sources.

**Weapon & Violence Analysis**
- Identify weapons most associated with violent crimes (e.g., assault, homicide, robbery).
- Analyze trends in weapon usage over time — are guns becoming more prevalent? Are bladed weapons declining?
- Investigate the relationship between weapon type and resolution rate (e.g., are crimes involving firearms solved more or less often?).

**Demographic Fairness & Representation**
- Compare crime victim data by descent to the actual population distribution by area. Helps assess disproportional targeting or exposure.
- Cross-reference with census data to get victims per capita metrics for each descent group.
- Check statistical validity of findings for underrepresented groups (e.g., Islanders, Native Americans, Alaskans) — assess if sample sizes are large enough to draw meaningful conclusions.

**Behavioral & Pattern Analysis**
- Analyze MO (Modus Operandi) code combinations to detect repeated strategies, behavioral patterns, or organized criminal activity.
- Study co-occurrence patterns among crime types — e.g., is burglary often reported alongside trespassing or vandalism?

**Police Division Performance**
- Compare clearance/resolution rates across LAPD divisions.
- Note: Requires mapping Reporting District numbers to LAPD Division names (one division typically spans multiple districts).
- Investigate whether certain types of crimes are consistently better resolved in some divisions.

**Severity Index**
- Create a crime severity index based on the hierarchy or seriousness of crime codes.
- Use this index to:
    - Map severity trends geographically
    - Track changes over time
    - Compare severity scores between areas and police districts

**Crime Location & Environment**
- Use the Premise Description column to categorize crime locations (e.g., public streets, private homes, parking structures).
- Show proportions of crimes in public vs. private spaces.
- Analyze whether certain crimes are more prevalent in specific locations at particular times (e.g., home burglaries at night).

**Time-Based Anomalies**
- Investigate the 12:00 PM peak in reported crime times.
- Is this a default or placeholder time for unknown incident hours?
- Consider cleaning or flagging this for temporal analysis.

**Deep-Dive**
- Socioeconomic indicators (income levels, housing, employment): May reveal systemic drivers of crime.
- Police resources per division (number of officers, funding): Can be compared against resolution rate and crime volume.

<br><br>

## Extra Materials <a name="anchor-extra-materials"></a> 
Click [here](#anchor-data-cleaning-transformation) to go back to data transformations

**DAX measures and calculated columns used for this project:**

- To add column with days in the week, expressed as numbers 1-7 (mon-sun)

![](PowerBI-Projects/dax_and_columns/0day_of_week.png)

- To add column with days in week, expressed in words instead of numbers

![](PowerBI-Projects/dax_and_columns/0day_week_written.png)

- To add a measure to calculate the area with the most amount of crimes for the card visual on page one

![](PowerBI-Projects/dax_and_columns/0frequent_area.png)

- To change value "UNK" to "Unknown" within 'status' column to improve readability of visualisation on case statuses

![](PowerBI-Projects/dax_and_columns/0status_description_written.png)

- To find the streets with street intersections

![](PowerBI-Projects/dax_and_columns/0street_name_with_cross.png)

- To categorise the victim descents to improve readability of visualisation on descent versus area of crime

![](PowerBI-Projects/dax_and_columns/0vict_descent_categorized.png)

- To write out the known descents of victims in full, instead of using the letter-code

![](PowerBI-Projects/dax_and_columns/0vict_descent_desc.png)

- To write out the known genders of victims in full, instead of using the letter-code

![](PowerBI-Projects/dax_and_columns/0vict_sex_desc.png)



