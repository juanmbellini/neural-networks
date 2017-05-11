function [] = test(file)


    load(strcat('./nets/',file));
    
    total = length(s);
    testingSize = length(sTest);
    testedValues = zeros(testingSize,1);
    for i = 1:testingSize
       testedValues(i,1) = getOutputFromNet(psiTest(i,:), W, g, psiNormalizer, denormalizer);
    end
    for i = 1:total
       allTestedValues(i,1) = getOutputFromNet(psi(i,:), W, g, psiNormalizer, denormalizer);
    end
    
    plotAll(psi, s, trainingMeanErrors, testedValues, allTestedValues);

end

