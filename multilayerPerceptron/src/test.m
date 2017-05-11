function [ testedValues ] = test(psi,s,W, g, psiNormalizer, denormalizer)

    total = length(s);
    testedValues = zeros(total,1);
    for i = 1:total
       testedValues(i,1) = getOutputFromNet(psi(i,:), W, g, psiNormalizer, denormalizer);
    end

end

