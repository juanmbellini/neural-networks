function [] = testAndPlot(file)


    load(strcat('./nets/',file));
    
    total = length(s);
    testingSize = length(sTest);
    psi = [psiTrain; psiTest];
    
    testedValues = test(psiTest, sTest, W, g, psiNormalizer, denormalizer);
    allTestedValues = test(psi, s, W, g, psiNormalizer, denormalizer);
    
    plotAll(psi, s, trainingMeanErrors, testingMeanErrors, testedValues, allTestedValues);

end

