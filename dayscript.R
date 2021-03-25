args = commandArgs(trailingOnly=TRUE)
inputName = args[1]
siteName = args[2]
lat = as.numeric(args[3])
long = as.numeric(args[4])
timeShift = as.numeric(args[5])
outName = args[6]

#load the REddyProc library
library(REddyProc)

#load the data to the R program from the filename given
EddyData.F <- fLoadTXTIntoDataframe(paste(getwd(), "/", inputName, sep=''))

#set the time (dataframe, original time format, name of year col, name of day col, name of hour col)
EddyDataWithPosix <- fConvertTimeToPosix(EddyData.F, 'YDH', Year='Year',Day = 'DoY', Hour = 'Hour')

#create a class for the site (site name, data in Posix time, columns to be used in post-processing)
EProc <- sEddyProc$new(siteName, EddyDataWithPosix, c('NEE', 'Rg', 'Tair', 'VPD', 'Ustar'))

#make the estimates for uStar, in the probs section set the precentiles 5%, 50%, 95%
EProc$sEstimateUstarScenarios(nSample = 100L, probs = c(0.05, 0.5, 0.95))
EProc$sGetUstarScenarios()

# find the scenarios and export the names of the documents
EProc$sMDSGapFillUStarScens('NEE', minNWarnRunLength=NA)
grep("NEE_.*_f$", names(EProc$sExportResults()), value = TRUE)
grep("NEE_.*_fsd$", names(EProc$sExportResults()), value = TRUE)

# Replace values of LatDeg, and LongDeg with the latitude and longitude of the site in decimal degrees
# TimeZoneHour is the hours shift to UTC
EProc$sSetLocationInfo(LatDeg = lat, LongDeg = long, TimeZoneHour = timeShift)

# Gap fill for air temp and vpd  
EProc$sMDSGapFill('Rg', minNWarnRunLength = NA)
EProc$sMDSGapFill('Tair', minNWarnRunLength = NA)
EProc$sMDSGapFill('VPD', minNWarnRunLength = NA)

# Do partitioning based on the Ustar scenarios, using the day time method
EProc$sGLFluxPartitionUStarScens()

filledData <- EProc$sExportResults()
combined <- cbind(EddyData.F, filledData)

fWriteDataframeToFile(combined, paste(getwd(), "/", outName, sep=''))
