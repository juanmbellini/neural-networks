
    filename = './data/terrain10.data';
    delimiterIn = ' ';
    headerlinesIn = 1;
    A = importdata(filename,delimiterIn,headerlinesIn);
    terrain = A.data;

    trainingSize = 300;
    s = terrain(:,3)';
    total = length(s);
    sTrain = s(:,1:trainingSize);
    sTest = s(:,trainingSize+1:total);
    
    psi = terrain(:,1:2);
    psiTrain = psi(1:trainingSize,:);
    psiTest = psi(trainingSize+1:total,:);

    n = 0.05;
    beta = 1;
    iterations = 5000;

    activationFunctions = activationFunctions();
    normalizers = normalizers();
    denormalizers = denormalizers();

    g = activationFunctions.tangHyp;
    gDeriv = activationFunctions.tangHypDeriv;

    hiddenLayerSizes = [5 20 5];
    error = 0;

    psiNormalizer = normalizers.entryTangHypNormalizerFromMinus4_4;
    sNormalizer = normalizers.tangHypNormalizerFromMinus10_10;
    denormalizer = denormalizers.tangHypDenormalizerToMinus10_10;
    
    %for momentum
    alfa = 0.9;
    
    %for adaptive learning rate
    a=0.08;
    b=0.3;

    %%normal backpropagation
    %[W, trainingMeanErrors] = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer);
    
    %%backpropagation with momentum
    [W, trainingMeanErrors] = momentumBackpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, alfa);
    
    %%backpropagation with adaptive learning rate
    %[W, trainingMeanErrors] = adaptiveBackpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, a, b);
    
    %backpropagation with adaptive learning rate and momentum
    %[W, trainingMeanErrors] = bestBackpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, a, b, alfa);
   
    save('./nets/net_9_9_9_hyp.mat','W','psi','s','trainingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer','trainingSize','sTest','psiTest');
