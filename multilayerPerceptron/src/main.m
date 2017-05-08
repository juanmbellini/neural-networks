function[] = main()

    %% XOR
    psiXor = [  1, 1;
                1, -1;
                -1, 1;
                -1, -1];
    sXor = [-1,1,1,-1];
    hiddenLayerSizesXor = [2];
    
    %% NAND
    psiNand = [  1, 1;
                1, -1;
                -1, 1;
                -1, -1];
    sNand = [-1,1,1,1];
    hiddenLayerSizesNand = [2];
    
    %% Al reves
    psiAR = [   1, 1;
                1, -1;
                -1, 1;
                -1, -1];
    sAR = [ 1, 1;
            -1, 1;
            1, -1;
            -1, -1]';
    hiddenLayerSizesAR = [4 4];
   

    n = 0.05;
    beta = 1;
    iterations = 99999;
    
    tangHyp = @(x) tanh(beta*x);
    tangHypDeriv = @(x) beta*(1-(tangHyp(x).^2));
    
    backpropagation(psiAR, sAR, n, error, iterations, hiddenLayerSizesAR, tangHyp, tangHypDeriv);
    
end
