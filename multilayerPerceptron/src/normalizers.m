function normalizers = normalizers()
    normalizers.normalizer = @normalizer;
    normalizers.tangHypNormalizerFromMinus10_10 = @tangHypNormalizerFromMinus10_10;
    normalizers.expoNormalizerFromMinus10_10 = @expoNormalizerFromMinus10_10;
    normalizers.entryTangHypNormalizerFromMinus4_4 = @entryTangHypNormalizerFromMinus4_4;
    normalizers.entryExpoNormalizerFromMinus4_4 = @entryExpoNormalizerFromMinus4_4;
end

%Generic normalizer
function[ret] = normalizer(x,a,b,min,max)
    ret = a + ((x-min)*(b-a))/(max-min);
end

%Normalizer for range [-10, 10] for tangHyp function
function[ret] = tangHypNormalizerFromMinus10_10(x)
    ret = normalizer(x,-0.9,0.9,-10,10);
end

%%Normalizer for range [-10, 10] for exponential function
function[ret] = expoNormalizerFromMinus10_10(x)
    ret = normalizer(x,0.1,0.9,-10,10);
end

%%Normalizer for range [-4,, 4] for tangHyp function
function[ret] = entryTangHypNormalizerFromMinus4_4(x)
    ret = normalizer(x,-1,1,-4,4);
end

%%Normalizer for range [-4,, 4] for exponential function
function[ret] = entryExpoNormalizerFromMinus4_4(x)
    ret = normalizer(x,0,1,-4,4);
end
