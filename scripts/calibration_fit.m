function [m, sigma_m, red_chi_sq] = calibration_fit (channel_data, wavenumber_data, size)

        yy = channel_data(:,1);
        ee = channel_data(:,2);

        % use polyfit to fit the wavenumbers to first degree polynomial
	[fit_p, fit_s] = polyfit(wavenumber_data, yy, \
						  1);
	% construct a model for values for that polynomial
	fitted_values = polyval(fit_p, wavenumber_data);
	%{
	% reset any existing plots
	hold off;

	error_plot = errorbar(wavenumber_data, yy, ee);
	set(error_plot, "linestyle", "none");
	set(error_plot, "marker", "x");

	% hold the previous plot to superimpose model data
	hold on;
	plot(wavenumber_data, fitted_values, 'r');
	%}
        m = fit_p(1);
    
        % calculation for the reduced chi_squared
        chi_squared = chi_sq(yy, ee, fitted_values); 
    
        % reduced chi_squared
        red_chi_sq = chi_squared/fit_s.df;
	
	% calculate uncertainty on the gradient (need single value)
	channel_uncertainty = mean(ee); 
	new_ee = channel_uncertainty*ones(length(ee));
	
	% to calulate uncertainty in gradient, we use covalent matrix
	covm = channel_uncertainty*inv(fit_s.R)*inv(fit_s.R)';
	
	% calculate sigma m from covelent matrix
	sigma_m = sqrt(covm(1,1));

	return;
endfunction