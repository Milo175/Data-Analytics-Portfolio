# Data-Analytics-Portfolio
Personal Portfolio of all my Data Analytics projects

Los Angeles Police Department - Crime Statistics Analysis

## Introduction:
Welcome to my first official GitHub ReadMe file! My name is Milo, and I am currently in the process of educating myself in the field of Data Analytics to make it my full-time profession. For this project, I decided to analyze the crime data in the City of Los Angeles from 2020 until 2025. The data of 2024 and 2025 is incomplete in this dataset, but I decided to still use the data, since the personal practice outweighs the data usability. 

> This dataset reflects incidents of crime in the City of Los Angeles dating back to 2020. This data is transcribed from original crime reports that are typed on paper and therefore there may be some inaccuracies within the data. Some location fields with missing data are noted as (0°, 0°). Address fields are only provided to the nearest hundred block in order to maintain privacy. This data is as accurate as the data in the database. Please note questions or concerns in the comments.

## Problem Statements
10 statements or questions have been formulated to solve within this dataset. 
Analyze victim age, sex, and location for different types of crime.
Identify the most common types of weapons used. Does this differ per crime type?
How have crime rates evolved year-over-year and which do rates differ per day of week?
Compare crime patterns during COVID lockdowns (2020–2021) vs. post-lockdown.
What time in the day are most crimes committed?
Break it down by crime type (e.g., assaults at night vs. thefts in the morning).
Use LAT, LON, and AREA NAME to create a heatmap of high-crime zones.
What are the high-crime zones in Los Angeles?
Break it down by victim decent to find differences in high-crime zones per decent
Determine the most dangerous streets
Determine the most dangerous intersections
Rank areas (AREA NAME or Rpt Dist No) by frequency or severity of crimes.
Are certain crimes (e.g., robbery, assault) more prevalent against specific groups?
Identify whether specific groups are disproportionately targeted in certain areas.
Extract and visualize trends from Mocodes to see popular tactics or criminal behavior.
What percentage of crimes have an "IC" (investigation complete) or other statuses?
Which types of crimes are most likely to remain unresolved?

## Skills Demonstrated
MySQL 
Data Cleaning
Standardization
Removing outliers
Data Analysis
Microsoft PowerBI 
Data Transformation
Data Modeling 
Data Modeling Hierarchy 
DAX Measure Calculations
New Column Calculations
Visualization
Graph & Chart Creation
Filters
Data Drilling

## Data Sourcing
The data used for this analysis has been directly downloaded from the City of Los Angeles Police Department Governmental [website](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-Present/2nrs-mtv8/about_data)

## Data Cleaning & Transformation
**Data Cleaning**
Link to SQL file: link

**Data Transformation**
DAX measure formulas used:


## Data Modeling 
One simple many to one (* > 1) data model was used to create the mo-code analysis page. For this page, I exported a table including each individual mo-code from each individual crime scene plus their count. I downloaded the mo-codes plus description from the LAPD website, and modeled them together to add the description to my own table. 

## Visualizations & Analysis

## Conclusions

## Recommendations






