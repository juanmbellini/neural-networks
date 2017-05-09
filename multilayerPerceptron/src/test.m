function [] = test(file)

    load(strcat('./nets/',file));
    
    total = length(s);
    testedValues = zeros(total,1);
    for i = 1:total
       testedValues(i,1) = getOutputFromNet(psi(i,:), W, g, psiNormalizer, denormalizer);
    end
    
    plotAll(psi, s, trainingMeanErrors, testedValues);

end

