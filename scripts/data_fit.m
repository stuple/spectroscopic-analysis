function [fit_p, f_errors, chi_sq] = data_fit (dependent, dependent_err, independent, order)
	% todo refactor function to enable arbitrary fitting of any
	% datapoints to different degrees of polynomial

	yy = dependent;
	ee = dependent_err;
	xx = independent;

        % use polyfit to fit the wavenumbers to first degree polynomial
	[fit_p, fit_s] = polyfit(xx, yy, order);
	% construct a model for values for that polynomial
	fitted_values = polyval(fit_p, xx);

	
	m = fit_p(1);

	% calculation for chi_squared
	chi_sq = chi_sq(yy, ee, fitted_values); 

	% reduced chi_squared
	red_chi_sq = chi_sq/fit_s.df;
	
	% calculate uncertainty on the gradient (need single value)
	y_e = mean(ee); 
	new_ee = y_e*ones(length(ee));
	
	% to calulate uncertainty in fitted parameters, we use covalent 
	% matrix
	covm = y_e*inv(fit_s.R)*inv(fit_s.R)';
	
	% calculate sigma m from covelent matrix
	for i=1:length(covm)
		f_errors(i) = sqrt(covm(i,i));
	end

	return;

endfunction
