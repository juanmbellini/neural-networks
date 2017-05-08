%function[] = trainTerrain10()

    filename = 'terrain10.data';
    delimiterIn = ' ';
    headerlinesIn = 1;
    A = importdata(filename,delimiterIn,headerlinesIn);
    terrain = A.data;

    psi = terrain(:,1:2);
    psiTrain = psi(1:300,:);
    
    s = terrain(:,3)';
    sTrain = s(:,1:300);

    n = 0.05;
    beta = 1;
    iterations = 99999;
    
    g = tangHyp;
    gDeriv = tangHypDeriv;

    hiddenLayerSizes = [6 4 4 4];
    error = 0.1;

    normalizer = @(x) 0.1*(x + 10)-1;
    denormalizer = @(x) ((x+1)/0.1)-10;

    W = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, normalizer);
    
    save('testedTerrain10-6444-0-1.mat', 'W');

    
%end