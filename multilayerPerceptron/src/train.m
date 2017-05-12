
    filename = './data/terrain10.data';
    delimiterIn = ' ';
    headerlinesIn = 1;
    A = importdata(filename,delimiterIn,headerlinesIn);
    terrain = A.data;
%{    
    randomIndexes = randperm(length(terrain));
    terrain = terrain(randomIndexes,:);

    trainingSize = 400;
    s = terrain(:,3)';
    total = length(s);
    sTrain = s(:,1:trainingSize);
    sTest = s(:,trainingSize+1:total);
    
    psi = terrain(:,1:2);
    psiTrain = psi(1:trainingSize,:);
    psiTest = psi(trainingSize+1:total,:);
%}
    n = 0.05;
    beta = 1;
    iterations = 2000;

    activationFunctions = activationFunctions();
    normalizers = normalizers();
    denormalizers = denormalizers();

    g = activationFunctions.tangHyp;
    gDeriv = activationFunctions.tangHypDeriv;

%     hiddenLayerSizes = [10 8 5 4 2];
    error = 0;

    psiNormalizer = normalizers.entryTangHypNormalizerFromMinus4_4;
    sNormalizer = normalizers.tangHypNormalizerFromMinus10_10;
    denormalizer = denormalizers.tangHypDenormalizerToMinus10_10;

%    [W, trainingMeanErrors, testingMeanErrors] = backpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer,denormalizer);

    %save('./nets/net_10_8_5_4_2_patterns400.mat','W','trainingMeanErrors', 'testingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer','trainingSize','s','psi','sTest','psiTest','sTrain','psiTrain');

    hiddenLayerSizesVec = {[7 7],[9 9 9],[10 8 5 4 2],[20 10],[5 20 5],[3 3 3 3 3 3]};
    patterns = [50,100,150,200,300,400];
    
    for layer = hiddenLayerSizesVec
       for p = patterns
           for i = 1:5
                randomIndexes = randperm(length(terrain));
                terrain = terrain(randomIndexes,:);

                trainingSize = patterns;
                s = terrain(:,3)';
                total = length(s);
                sTrain = s(:,1:trainingSize);
                sTest = s(:,trainingSize+1:total);

                psi = terrain(:,1:2);
                psiTrain = psi(1:trainingSize,:);
                psiTest = psi(trainingSize+1:total,:);
               
               layerSizesStr = '';
               for l = [layer{1}]
                   layerSizesStr = strcat(layerSizesStr,num2str(l),'_');
               end
               netFilename = strcat('./nets/net_',layerSizesStr,'patterns',num2str(p),'_testNo',num2str(i),'.mat');
               [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = backpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, layer{1}, g, gDeriv, psiNormalizer, sNormalizer,denormalizer);
               netFilename
               save(netFilename,'W','trainingMeanErrors', 'testingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer','trainingSize','s','psi','sTest','psiTest','sTrain','psiTrain','trainingQuadraticMeanError');
           end
       end        
    end
    