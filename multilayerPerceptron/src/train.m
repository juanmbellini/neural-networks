
    filename = './data/terrain10.data';
    delimiterIn = ' ';
    headerlinesIn = 1;
    A = importdata(filename,delimiterIn,headerlinesIn);
    terrain = A.data;

    trainingSize = 300;
    s = terrain(:,3)';
    total = length(s);
    sTrain = s(:,1:trainingSize);
    
    psi = terrain(:,1:2);
    psiTrain = psi(1:trainingSize,:);

    n = 0.05;
    beta = 1;
    iterations = 99999;

    activationFunctions = activationFunctions();
    normalizers = normalizers();
    denormalizers = denormalizers();

    g = activationFunctions.tangHyp;
    gDeriv = activationFunctions.tangHypDeriv;

    hiddenLayerSizes = [6 4 4 4];
    error = 0.1;

    psiNormalizer = normalizers.entryTangHypNormalizerFromMinus4_4;
    sNormalizer = normalizers.tangHypNormalizerFromMinus10_10;
    denormalizer = denormalizers.tangHypDenormalizerToMinus10_10;

    [W, trainingMeanErrors] = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer);

    save('./nets/net_6_4_4_4_hyp_0_1.mat','W','psi','s','trainingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer');


