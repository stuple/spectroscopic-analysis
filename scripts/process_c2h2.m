function process_c2h2()

  % load data
  c2h2 = load('data/c2h2.dat');

  % load corresponding m values
  m_values = load('data/c2h2_m.dat')

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
  
  % assign channel values for peaks to variables for easier access
  yy = peak_channels(:,1);
  ee = peak_channels(:,2);

  error_plot = errorbar(m_values, yy, ee);
  grid on;
  set(error_plot, "linestyle", "none");
  set(error_plot, "marker", "x");



  % plot(peak_channels(:,1), m_values, 'kx');

