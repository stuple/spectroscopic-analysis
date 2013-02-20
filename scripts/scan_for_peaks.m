% Scans the range of data points and determines the ranges where there are peaks (large 
% deviations from the mean value)
%

function peak_ranges = scan_for_peaks (dataset)
	peaks_num = 0;	
	% runs through the data to find the number of peaks
	for m = 1:length(dataset)
		if (dataset(m) > 0)
			peaks_num = peaks_num + 1;
		end;
	end;
	
	% zeros(1:peaks_num)
	% peaks_num
	% defines the matrix to hold data about the ranges
	peaks_data = zeros(peaks_num, 2);
	% peaks_data(1:peaks_num,2) = zeros(peaks_num, 1);
	
	start_pos = 0;
	end_pos = 0;
	peaks_found = 0;
	
	% runs through the data to write the ranges for the peaks
	for i = 1:length(dataset)
		if (dataset(i) > 0)
			start_pos = 0;
			if end_pos == 0
				end_pos = i;
				peaks_data(peaks_found, 1) = i;
			end
		end;
		
		if (dataset(i) < 0)
			end_pos = 0;
			if start_pos == 0
				dataset(i)
				start_pos = i;
				peaks_found = peaks_found + 1;
				peaks_data(peaks_found, 2) = i;
			end
		end;
	end;
	
	peaks_data(peak_data == 0) = [];
	peaks_data