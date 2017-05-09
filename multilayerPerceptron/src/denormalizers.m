function denormalizers = denormalizers()
    denormalizers.denormalizer = @denormalizer;
    denormalizers.tangHypDenormalizerToMinus10_10 = @tangHypDenormalizerToMinus10_10;
    denormalizers.expoDenormalizerToMinus10_10 = @expoDenormalizerToMinus10_10;
end

function[ret] = denormalizer(x,a,b,min,max)
    ret = min + ((x-a)*(max-min))/(b-a);
end

function[ret] = tangHypDenormalizerToMinus10_10(x)
    ret = denormalizer(x,-0.9,0.9,-10,10);
end

function[ret] = expoDenormalizerToMinus10_10(x)
    ret = denormalizer(x,0.1,0.9,-10,10);
end