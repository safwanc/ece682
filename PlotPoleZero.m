function [ h ] = PlotPoleZero( h, sys, varargin )
%PLOTPOLEZERO Plots the pole-zero locations of a state space model
%
% Course:       ECE 682 (Fall 2011)
%               Multivariate Control Systems
%
% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% See also:     DESIGNSTATEFEEDBACK LIPMSTATESPACE PLOTSTEPRESPONSE

% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

    global SavePlots
    persistent PlotTitle

    if isempty(PlotTitle)
        PlotTitle = 'Pole-Zero Map';
    end
    
    figure(h); 
    pzplot(sys); % Plot Pole/Zero Locations of System
    title(PlotTitle);
    
    if ~isempty(varargin)
        
        title([PlotTitle ' of ' char(varargin{1})]);
        
        if SavePlots
            saveas(h, varargin{2}); 
        end
        
    end
    
end

