% Tests the given neural network and plots graphs
% @param network_name The name of the network to be tested (must be under nets directory)
function [quadraticMeanError] = testAndPlot(network_name)

    % load(strcat('./nets/',network_name)); % Loads netowrk variables into wokspace
    load(network_name); % Loads netowrk variables into wokspace
    
    total = length(s);
    testingSize = length(sTest);
    psi = [psiTrain; psiTest];
    
    % Testing
    testedValues = test(psiTest, sTest, W, g, psiNormalizer, denormalizer);
    allTestedValues = test(psi, s, W, g, psiNormalizer, denormalizer);

    % Plotting
    [testedSize, total, sTested, meanError, quadraticMeanError] = calculatePlottingVariables(psi, s, trainingMeanErrors, testingMeanErrors, testedValues, allTestedValues);
    plotResults(testedValues, sTested, psi, allTestedValues, s, trainingMeanErrors, testingMeanErrors)

    disp(strcat('Quadratic Mean Error is: ', num2str(quadraticMeanError)));
end

