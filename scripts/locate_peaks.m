% Scans the range of data points and determines the ranges where there are peaks (large 
% deviations from the mean value)
%

function channel_values = locate_peaks (dataset)
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
				start_pos = i;
				peaks_found = peaks_found + 1;
				peaks_data(peaks_found, 2) = i;
			end
		end;
	end;
	
	% peaks_data(peaks_data == 0) = [];
	peak_positions = peaks_data(1:peaks_found, 1:2);
	% peaks_data
	
	channel_values = zeros(peaks_found, 2);
	for j = 1:peaks_found
		sigma = peak_positions(j,1) - peak_positions(j,2);
		avg_channel = (peak_positions(j,1) + peak_positions(j,2))/2;
		
		channel_values(j,1) = avg_channel;
		channel_values(j,2) = sigma/8;
	end;
    
	channel_values(1:peaks_found,2);
    
	return;
	