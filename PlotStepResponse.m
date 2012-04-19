function [ h ] = PlotStepResponse( h, sys, tf, varargin )
%PLOTSTEPRESPONSE Plots discretized step response of a state space model
%
% Course:       ECE 682 (Fall 2011)
%               Multivariate Control Systems
%
% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% See also:     DESIGNSTATEFEEDBACK LIPMSTATESPACE PLOTPOLEZERO

% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

    global SavePlots SamplingTime
    persistent PlotTitle

    if isempty(PlotTitle)
        PlotTitle = 'Step Response';
    end
    
    figure(h); 
    step(c2d(sys, SamplingTime), tf); % Discretize & Plot Step Response
    title(PlotTitle);
    
    if ~isempty(varargin)
        
        title([PlotTitle ' of ' char(varargin{1})]); 
        
        if SavePlots
            saveas(h, varargin{2}); 
        end
        
    end
    
end

