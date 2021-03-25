# MatlabWrapper_REddyProc

This software package is a wrapper to simplify the use of the REddyProc package developed by the Department of Biogeochemical Integration at the Max Planck Institute for Biogeochemistry for labs and users that primarily use Matlab for processing. 

The purpose of the wrapper was to simplify use of the REddyProc methods by the CUBioMet Lab at Carleton University which primarily uses Matlab for processing of half hour eddy covariance data. The wrapper is a part of the research project of Razz Routly under the ICUREUS grant program. 

Wutzler T, Lucas-Moffat A, Migliavacca M, Knauer J, Sickel K, Sigut, Menzer O & Reichstein M (2018) Basic and extensible post-processing of eddy covariance flux data with REddyProc. Biogeosciences, Copernicus, 15, doi: 10.5194/bg-15-5015-2018

**Required Input Formatting**

Input data should be provided as a tab or space delimited ASCII file with the columns defined below. The wrapper provided is designed for half-hour eddy covariance data from non-arctic sites to be partitioned with either day-time or night-time processing. Data should be provided in full year chunks with missing data present but indicated as missing used ‘-9999’ as a filler value.

Datetime information should be formatted in three columns labelled ‘Year’, ‘DoY’ (for Day of Year), and ‘Hour’ (with half hour values indicated as .5). 

Other required data columns are the observed ‘NEE’ value in umolm^2s^1, solar radiation as ‘Rg’ in Wm^2, air temperature as Tair in degrees celsius, and vapor pressure density as ‘VPD’ in hPa. 

Additionally, the first row of the data should contain either the units of the applicable values, or a filler value of ‘0’ or ‘-’

**System Parameters**
    
*locationR* is a string parameter of the file path to the Rscript.exe file to run the R script from within Matlab, should be provided with double quotations 
    (ie "C:\Program Files\R\R-4.0.2\bin\Rscript.exe")

*siteName* is a string parameter representing the name of the site, no spaces should be included in the name given
    (ie. MerBleue)

*lat* is a decimal value for the latitude of the site in decimal degrees.
    (ie. 74.9)

*long* is a decimal value for the longitude of the site in decimal degrees
    (ie. -75.5)

*timeShift* is an integer value of the number of hours shifting from the local timezone to UTC (provided the data is measured in the local time zone)
    (ie. -5)
    
*inputFileName* is a string value of the filename for the pre processed data to be used in the R program, file extension should be included
    (ie. preProcessed.txt)

*day/night* are string values of ‘Y’ or ‘N’ indicating which of the partitioning methods to use with the R program

*outFile* is a string value of the filename to save the data to, separate file names can be given for the day and night processing, do not include the file extension
    (ie. daydata)

