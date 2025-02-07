%% Setup the Import Options and import the data (generated by MatLab)
opts = delimitedTextImportOptions("NumVariables", 120);

% Specify range and delimiter
opts.DataLines = [3, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["Year", "DoY", "Hour", "NEE", "LE", "H", "Rg", "Tair", "Tsoil", "rH", "VPD", "Ustar", "season", "Ustar_uStar_Thres", "Ustar_uStar_fqc", "NEE_uStar_orig", "NEE_uStar_f", "NEE_uStar_fqc", "NEE_uStar_fall", "NEE_uStar_fall_qc", "NEE_uStar_fnum", "NEE_uStar_fsd", "NEE_uStar_fmeth", "NEE_uStar_fwin", "Ustar_U05_Thres", "Ustar_U05_fqc", "NEE_U05_orig", "NEE_U05_f", "NEE_U05_fqc", "NEE_U05_fall", "NEE_U05_fall_qc", "NEE_U05_fnum", "NEE_U05_fsd", "NEE_U05_fmeth", "NEE_U05_fwin", "Ustar_U50_Thres", "Ustar_U50_fqc", "NEE_U50_orig", "NEE_U50_f", "NEE_U50_fqc", "NEE_U50_fall", "NEE_U50_fall_qc", "NEE_U50_fnum", "NEE_U50_fsd", "NEE_U50_fmeth", "NEE_U50_fwin", "Ustar_U95_Thres", "Ustar_U95_fqc", "NEE_U95_orig", "NEE_U95_f", "NEE_U95_fqc", "NEE_U95_fall", "NEE_U95_fall_qc", "NEE_U95_fnum", "NEE_U95_fsd", "NEE_U95_fmeth", "NEE_U95_fwin", "Tair_orig", "Tair_f", "Tair_fqc", "Tair_fall", "Tair_fall_qc", "Tair_fnum", "Tair_fsd", "Tair_fmeth", "Tair_fwin", "VPD_orig", "VPD_f", "VPD_fqc", "VPD_fall", "VPD_fall_qc", "VPD_fnum", "VPD_fsd", "VPD_fmeth", "VPD_fwin", "Rg_orig", "Rg_f", "Rg_fqc", "Rg_fall", "Rg_fall_qc", "Rg_fnum", "Rg_fsd", "Rg_fmeth", "Rg_fwin", "PotRad_NEW", "Reco_DT_U95", "GPP_DT_U95", "Reco_DT_U95_SD", "GPP_DT_U95_SD", "Reco_DT_U50", "GPP_DT_U50", "Reco_DT_U50_SD", "GPP_DT_U50_SD", "Reco_DT_U05", "GPP_DT_U05", "Reco_DT_U05_SD", "GPP_DT_U05_SD", "FP_VARnight", "FP_VARday", "NEW_FP_Temp", "NEW_FP_VPD", "FP_RRef_Night", "FP_qc", "FP_dRecPar", "FP_errorcode", "FP_GPP2000", "FP_k", "FP_beta", "FP_alpha", "FP_RRef", "FP_E0", "FP_k_sd", "FP_beta_sd", "FP_alpha_sd", "FP_RRef_sd", "FP_E0_sd", "Reco_DT_uStar", "GPP_DT_uStar", "Reco_DT_uStar_SD", "GPP_DT_uStar_SD"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
fileName = append(outFile, '.txt');
filePath = append(pwd, '\', fileName);
daydata = readtable(filePath, opts);

clear opts
disp(append(fileName, ' Imported to Matlab'))
%% Post Processing 

daydata([1],:) = []; %delete the first row of unit values

dayReco = daydata.Reco_DT_uStar; %separates Ecosystem Respiration column from the table
dayGPP = daydata.GPP_DT_uStar; %separates GPP column from the table

% separates YDH columns into a datetime vector
dayYear = daydata.Year; 
dayDoY = daydata.DoY;
dayHour = daydata.Hour;

even = find(mod(dayHour,1) == 0);
odd = find(mod(dayHour,1) ~= 0);

half(even) = datetime(dayYear(even,:),1,dayDoY(even,:),floor(dayHour(even,:)),0,0);
half(odd) = datetime(dayYear(odd,:),1,dayDoY(odd,:),floor(dayHour(odd,:)),30,0);
dayDate_table = half';

% makes a timetable with the datetime vector, Reco, GPP
daytime = timetable(dayDate_table, dayReco, dayGPP);