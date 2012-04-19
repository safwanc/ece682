% DESIGNSTATEFEEDBACK Designs a state feedback controller for 3D LIPM model
%
% Course:       ECE 682 (Fall 2011)
%               Multivariate Control Systems
%
% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% See also:     LIPMSTATESPACE STATEFEEDBACK PLOTPOLEZERO PLOTSTEPRESPONSE

% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

clear all
close all
clc

%% LIPM Model Parameters

m   = 20;           % Robot Mass    [kg]
g   = 9.81;         % Gravity Const [m/s^2]
zc  = 0.5;          % COM Height    [m]

LIPMStateSpace;     % 3D LIPM Model [A, B, C, D]

clear m g zc

%% Design/Plotting Parameters

global SavePlots SamplingTime

SavePlots = true;          % Flag for saving plots 
SamplingTime = 0.001;       % 1KHz for discretizing continuous time systems 

HUSR = 1; HUPZ = 2;         % Plot Handles
HSSR = 3; HSPZ = 4; 

% Helper Anon Functions
MakeStateSpace = @(A) ss(A, B, C, D, ... % Generates state space model
    'StateName', States, 'InputName', Inputs, 'OutputName', Outputs'); 

%% Unstable System SR+PZ

disp(' '); disp('> Unstable (Original) System:'); 
UnstableSys = MakeStateSpace(A) % [Z,P,K] = zpkdata(UnstableSystem);
PlotStepResponse(HUSR, UnstableSys, 5, 'Unstable System', 'ussr.eps'); 
PlotPoleZero(HUPZ, UnstableSys, 'Unstable Transfer Function', 'uspz.eps'); 

%% State Feedback Design

% Arbitrarily place state feedback poles at: 
StablePoles = [-1+1i; -1-1i; -1.3+2.3i; -1.3-2.3i; -1.5+2i; -1.5-2i]; 
% Generate augmented system with: Afb = A - Bk
Afb   = StateFeedback(A, B, StablePoles); 

%% Stablilized System SR+PZ

disp(' '); disp('> Stabilized System:'); 
StableSys = MakeStateSpace(Afb) % Apoles = eig(Afeedback);
PlotStepResponse(HSSR, StableSys, 5, 'Stabilized System', 'sfsr.eps'); 
PlotPoleZero(HSPZ, StableSys, 'Stablized Transfer Function', 'sfpz.eps');

%% Cleanup Environment
clear H* Inputs Outputs States MakeStateSpace SamplingTime SavePlots