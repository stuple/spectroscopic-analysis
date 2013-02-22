function process_c2h2(wavenumber_scaling_factor, scaling_err)
	% load data
	c2h2 = load('data/c2h2.dat');

	% load corresponding m values
	m_values = load('data/c2h2_m.dat');
	
	
	% constants
	c = 3e8; % speed of light
	h_bar = 1.05457148e-34; % reduced Planck constant
	h = 6.626068e-34; % Planck constant

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
	peak_channels = locate_peaks(peaks);

	% assign channel values for peaks to variables for easier access
	yy = peak_channels(:,1);
	ee = peak_channels(:,2);

	error_plot = errorbar(m_values, yy, ee);
	grid on;
	set(error_plot, "linestyle", "none");
	set(error_plot, "marker", "x");

	[fit_p, fit_err, chi_squared] = data_fit(yy, ee, m_values, 2);

	% construct a model for values for that polynomial
	fitted_values = polyval(fit_p, m_values);

	% plot residuals 
	hold off;
	residuals = yy - fitted_values;

	residuals_plot = errorbar(1:1:length(residuals), residuals, ee);
	grid on;
	set(residuals_plot, "linestyle", "none");
	set(residuals_plot, "marker", "*");

	% perform calculations 
	
	% invert the conversion factor as it is from wavenumber to channel
	% wavenumber_scaling_factor = wavenumber_scaling_factor^(-1);
	
	% rest moment of inertia
	I_0 = h_bar^2/(wavenumber_scaling_factor*h*c*(fit_p(2)-fit_p(1)));
	sig_I_0 = I_0*sqrt((scaling_err/wavenumber_scaling_factor)^2+(fit_err(2)^2+fit_err(1)^2)/(fit_p(2)-fit_p(1))^2);
	
	% excited moment of inertia
	I_1 = h_bar^2/(wavenumber_scaling_factor*h*c*(fit_p(2)+fit_p(1)));
	sig_I_1 = I_1*sqrt((scaling_err/wavenumber_scaling_factor)^2+(fit_err(2)^2+fit_err(1)^2)/(fit_p(2)-fit_p(1))^2);
	
	% different in excitation 
	delta_I = 2*h_bar^2*fit_p(1)/(wavenumber_scaling_factor*h*c*(fit_p(2)^2-fit_p(1)^2))
	sig_delta_I = delta_I*sqrt((scaling_err/wavenumber_scaling_factor)^2+(2*fit_err(2)/fit_p(2))^2+(fit_err(1)/fit_p(1))^2)


endfunction
