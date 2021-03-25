%% set up the input parameters

locationR = input("Enter File Path to the Rscipt.exe file: (Include Quotes)", 's'); %filepath to the Rscript.exe file in the R Program Files as a string with quotation marks
siteName = input("Enter Site Name: (Must Be One String) ", 's'); %string value for the site name (must have no spaces), used in the R process
lat = input("Enter Latitude Value of Site (Decimal): ", 's'); %decimal value for the latitude of the site
long = input("Enter Longitude Value of Site (Decimal): ", 's'); %decimal value for the longitude of the site
timeShift = input("Enter Hour Shift to UTC: ", 's'); %integer value, of the number of hours shift to UTC
inputFileName = input("Enter Filename of Pre-Processed Input data: ", 's'); %string value of the pre-processed data file, (no spaces) 

%% run either day or night processing

day = input("Run Daytime Processing (Y/N)? ", 's');
if day == 'Y'
    outFile = input("File Name for Daytime Output: ", 's'); %string value of name to save data to, (no spaces)
    filePath = append(pwd, '\dayscript.R', ' ', inputFileName, ' ', siteName, ' ', lat, ' ', long, ' ', timeShift, ' ', outFile, '.txt');
    filePath = append(locationR, ' ', filePath);
    
    system(filePath);
    
    disp('dayscript.R Completed');
    dayPostProc
end
night = input("Run Nighttime Processing (Y/N)? ", 's');
if night == 'Y'
    outFile = input("File Name for Nighttime Output: ", 's'); %string value of name to save data to, (no spaces)
    filePath = append(pwd, '\nightscript.R', ' ', inputFileName, ' ', siteName, ' ', lat, ' ', long, ' ', timeShift, ' ', outFile, '.txt');
    filePath = append(locationR, ' ', filePath);
    
    system(filePath);
    
    disp('nightscript.R Completed');
    nightPostProc
end