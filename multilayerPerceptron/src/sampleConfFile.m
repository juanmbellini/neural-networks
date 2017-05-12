% Sample configuration file.
% This file is a matlab script file used to initialize training variables.
% Calculations can be done here in order to set those them.
% Required variables are those declared here.

% Terrain
filename = './data/terrain10.data'; % For local use
delimiterIn = ' ';                  % For local use
headerlinesIn = 1;                  % For local use
importedData = importdata(filename, delimiterIn, headerlinesIn);

% Training parameters
trainingSize = 300;
n = 0.05;
beta = 1;
iterations = 4000;
error = 0;
hiddenLayerSizes = [7 7];
activationFunctionOption = 'expo'; % Possible values: 
trainedNetwork = 'default_net';
improvementMethod = ''; % Possible values: <empty string>, 'momentum', 'adaptative', 'adaptive_momentum' 

% Improvements settings
% For momentum, define alfa
% For adaptative learning rate, define a and b
% For both uses, define alfa, a and b
alfa = 0.9; % For momentum
a = 0.08; % For adaptive learning rate
b = 0.3; % For adaptive learning rate