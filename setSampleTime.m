function [t_uniform, x_uniform] = setSampleTime(tout, data, t_sample)
    %SET SAMPLE TIME Interpolates data to achieve uniform sampling.
    %   [t_uniform, x_uniform] = setSampleTime(tout, data, t_sample)
    %
    %   INPUTS:
    %   tout      - A vector of time values (timestamps) corresponding to the data samples.
    %   data      - A vector of data values (signals) corresponding to the timestamps in 'tout'.
    %   t_sample  - Desired sample time for the uniform sampling.
    %
    %   OUTPUTS:
    %   t_uniform - A uniformly sampled time vector generated from 'tout' with the specified sample time.
    %   x_uniform - Data values interpolated to match the uniform time vector 't_uniform'.
    
    % Define a uniform time vector from the first to the last timestamp in 'tout',
    % with increments equal to the specified sample time 't_sample'.
    t_uniform = tout(1):t_sample:tout(end); 
    
    % Perform spline interpolation to estimate the data values at the uniform time points.
    % This method smooths the data and provides continuous output.
    x_uniform = interp1(tout, data, t_uniform, 'spline');  % Interpolation using spline method
    
    % Note: 'interp1' function is used to interpolate 1-D data. 
    % The 'spline' method provides a smooth curve that passes through the data points.
end
