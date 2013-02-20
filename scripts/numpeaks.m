
function peaks_found = numpeaks(dataset)
	peaks_num = 0;	
	% runs through the data to find the number of peaks
	for m = 1:length(dataset)
		if (dataset(m) > 0)
			peaks_num = peaks_num + 1;
		end;
	end;
	
	start_pos = 0;
	end_pos = 0;
	peaks_found = 0;
	
	% runs through the data to write the ranges for the peaks
	for i = 1:length(dataset)
		if (dataset(i) > 0)
			start_pos = 0;
			if end_pos == 0
				end_pos = i;
			end
		end;
		
		if (dataset(i) < 0)
			end_pos = 0;
			if start_pos == 0
				start_pos = i;
				peaks_found = peaks_found + 1;
			end
		end;
	end;
	
	return;