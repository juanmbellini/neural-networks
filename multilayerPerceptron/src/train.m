
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
    iterations = 2000;

    activationFunctions = activationFunctions();
    normalizers = normalizers();
    denormalizers = denormalizers();

    g = activationFunctions.expo;
    gDeriv = activationFunctions.expoDeriv;

    hiddenLayerSizes = [6 4 4 4];
    error = 0;

    psiNormalizer = normalizers.entryExpoNormalizerFromMinus4_4;
    sNormalizer = normalizers.expoNormalizerFromMinus10_10;
    denormalizer = denormalizers.expoDenormalizerToMinus10_10;

    [W, trainingMeanErrors] = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer);

    save('./nets/net_6_4_4_4_expo.mat','W','psi','s','trainingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer');


