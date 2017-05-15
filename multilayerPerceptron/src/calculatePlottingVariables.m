% Function that calculates plotting variables
function [testedSize, total, sTested, meanError, quadraticMeanError] = calculatePlottingVariables(psi, s, trainingMeanErrors, testingMeanErrors, testedValues, allTestedValues)
    
    testedSize = length(testedValues);
    total = length(s);
    sTested = s(total - testedSize + 1 : total);

    meanError = mean((sTested - testedValues'));
    quadraticMeanError = mean((sTested - testedValues').^2);
end
