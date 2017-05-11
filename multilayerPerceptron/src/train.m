
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
    iterations = 4000;

    activationFunctions = activationFunctions();
    normalizers = normalizers();
    denormalizers = denormalizers();

    g = activationFunctions.expo;
    gDeriv = activationFunctions.expoDeriv;

    hiddenLayerSizes = [7 7];
    error = 0;

    psiNormalizer = normalizers.entryExpoNormalizerFromMinus4_4;
    sNormalizer = normalizers.expoNormalizerFromMinus10_10;
    denormalizer = denormalizers.expoDenormalizerToMinus10_10;
    
    %for momentum
 	alfa = 0.9;
   
 	%for adaptive learning rate
 	a=0.08;
 	b=0.3;

  	%%normal backpropagation
 	[W, trainingMeanErrors, testingMeanErrors] = backpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer);
     
 	%%backpropagation with momentum
 	%[W, trainingMeanErrors, testingMeanErrors] = momentumBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, alfa);
     
    %psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer
    
 	%%backpropagation with adaptive learning rate
 	%[W, trainingMeanErrors, testingMeanErrors] = adaptiveBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, a, b);
     
 	%backpropagation with adaptive learning rate and momentum
    %[W, trainingMeanErrors, testingMeanErrors] = bestBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, a, b, alfa);
  
    save('./nets/net_7_7_expo_funcactivacion.mat','W','trainingMeanErrors', 'testingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer','trainingSize','s','psi','sTest','psiTest','sTrain','psiTrain');
