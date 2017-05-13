% Function that creates and trains a neural network.
% The trained netowrk will be saved according to configuration file
%
% @param confFile configuration file to load parameters.
function[] = train(confFile)

    % Set up of parameters
    if nargin == 0 % No configuration file
        % Terrain
        importedData = importdata('./data/terrain10.data', ' ', 1);

        % Training data
        activationFunctionOption = 'expo';
        trainingSize = 300;
        n = 0.05;
        beta = 1;
        iterations = 4000;
        error = 0;
        alfa = 0.9; % For momentum
        a = 0.08; % For adaptive learning rate
        b = 0.3; % For adaptive learning rate
        hiddenLayerSizes = [7 7];
        improvementMethod = '';
        trainedNetwork = 'default_net';
    else
        run(confFile) % Loads configuration file
        disp('Data loaded from configuration file :)');
    end

    % Clear variables that might be used in configuration file
    clear terrain activationFunctions_ normalizers_ denormalizers_;
    clear g gDeriv psiNormalizer sNormalizer denormalizer;
    clear s total sTrain sTest psi psiTrain psiTest;


    terrain = importedData.data;
    % Load functions
    activationFunctions_ = activationFunctions();
    normalizers_ = normalizers();
    denormalizers_ = denormalizers();

    switch activationFunctionOption
        case 'expo'
            g = activationFunctions_.expo;
            gDeriv = activationFunctions_.expoDeriv;
            psiNormalizer = normalizers_.entryExpoNormalizerFromMinus4_4;
            sNormalizer = normalizers_.expoNormalizerFromMinus10_10;
            denormalizer = denormalizers_.expoDenormalizerToMinus10_10;
        case 'tangHyp'
            g = activationFunctions_.tangHyp;
            gDeriv = activationFunctions_.tangHypDeriv;
            psiNormalizer = normalizers_.entryTangHypNormalizerFromMinus4_4;
            sNormalizer = normalizers_.tangHypNormalizerFromMinus10_10;
            denormalizer = denormalizers_.tangHypDenormalizerToMinus10_10;
        otherwise
            disp('FATAL: Wrong activation function option');
            exit(1);
    end

    s = terrain(:,3)';
    total = length(s);
    sTrain = s(:,1:trainingSize);
    sTest = s(:,trainingSize+1:total);
    
    psi = terrain(:,1:2);
    psiTrain = psi(1:trainingSize,:);
    psiTest = psi(trainingSize+1:total,:);

    switch improvementMethod
        case ''
            disp('Training without improvements');
            [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = backpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer);
        case 'momentum'
            disp('Training applying momentum improvement');
            [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = momentumBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, alfa);
        case 'adaptative'
            disp('Training applying adaptative learning rate improvement');
            [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = adaptiveBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, a, b);
        case 'adaptive_momentum'
            disp('Training applying momentum and adaptative learning rate improvement');
            [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = bestBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, a, b, alfa);
        otherwise
            disp('WARNING: unknown improvement method');
            disp('Falling back to no improvement method\n');
            [W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = backpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer);
    end
    
    trainedNetwork = strcat('./nets/', trainedNetwork); % TODO: fixed directory?
    trainedNetwork = strcat(trainedNetwork, '.mat');
    save(trainedNetwork,'W','trainingMeanErrors', 'testingMeanErrors','g','gDeriv','psiNormalizer','sNormalizer','denormalizer','trainingSize','s','psi','sTest','psiTest','sTrain','psiTrain', 'trainingQuadraticMeanError');
end
