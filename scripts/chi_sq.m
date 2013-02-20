function [ chi_sq ] = chi_sq( dataset, data_errors, fitted_values )
%Calculates the chi-squared for a data distribution with given fitted
%values
%   Detailed explanation goes here
    residuals = ((dataset-fitted_values)./data_errors).^2;
    residual_sq_sum = sum(residuals.^2);
    
    chi_sq = residual_sq_sum;

    return;
end

