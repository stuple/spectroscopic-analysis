% -----------------------
%
%
%------------------------
function [m, sig_m] = calibrate()

  % load calibration data for h2o
  calibration_data = load('data/h2o.dat');

  % load the corresponding wavenumbers for different water peaks
  calibration_wavenumbers = load('data/calibration_wavenumbers.dat');

  average = mean(calibration_data);
  xrange = 1:1:length(calibration_data);

  scaled_data = calibration_data - average;

  max_peak = max(scaled_data);
  cutoff_value = 0.2*max_peak;

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
  peak_channels = locate_peaks(peaks);

  [m, sig_m] = calibration_fit(peak_channels, calibration_wavenumbers, \
			       num_peaks);

  m = m^-1;
  sig_m = m^2*sig_m;

  return;
endfunction
