function process_c2h2()
  %load data

  c2h2 = load('data/c2h2.dat');

  hold off;
  plot(c2h2);

  average = mean(c2h2);
  xrange = 1:1:length(c2h2);

  scaled_data = c2h2 - average;

  max_peak = max(scaled_data);
  cutoff_value = 0.1*max_peak;

  peak_data = zeros(1, length(scaled_data));

  peaks = zeros(1, length(scaled_data));
  count = 1;

  for i=1:length(scaled_data)
    if abs(scaled_data(i)) > cutoff_value
      peak_data(count) = scaled_data(i);
      peaks(i) = scaled_data(i);
    end;
    count = count+1;
  end;

  % clean up empty spaces in the array (zeros)
  peak_data(peak_data == 0) = [];
  num_peaks = numpeaks(peaks);

  % get peak positions and their uncertainties
  peak_channels = locate_peaks(peaks)

%   c2h2_peaks = locate_peaks(c2h2)

