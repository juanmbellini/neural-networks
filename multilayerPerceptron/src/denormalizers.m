function denormalizers = denormalizers()
    denormalizers.denormalizer = @denormalizer;
    denormalizers.tangHypDenormalizerToMinus10_10 = @tangHypDenormalizerToMinus10_10;
    denormalizers.expoDenormalizerToMinus10_10 = @expoDenormalizerToMinus10_10;
end

%%Generic denormalizer
function[ret] = denormalizer(x,a,b,min,max)
    ret = min + ((x-a)*(max-min))/(b-a);
end

%%Denormalizer for range [-10, 10] for tanHyp function
function[ret] = tangHypDenormalizerToMinus10_10(x)
    ret = denormalizer(x,-0.9,0.9,-10,10);
end

%%Denormalizer for range [-10, 10] for exponential function
function[ret] = expoDenormalizerToMinus10_10(x)
    ret = denormalizer(x,0.1,0.9,-10,10);
end