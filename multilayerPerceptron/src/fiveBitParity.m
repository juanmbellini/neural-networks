function[] = fiveBitParity()
    binaryNums = [1 -1];
    
    psi = seqrep(binaryNums, 5);
    
    psiTrain = psi(1:25,:);
    psiTest = psi(26:32,:);
    
    s = zeros(1, length(psi(:,1)));
    
    for i = 1:length(s)
        c = 0;
        for j = 1:5
            if psi(i,j) == 1
                c = c+1;
            end
            if mod(c,2) == 0
                s(i) = -1;
            else
                s(i) = 1;
            end
        end
        
    end
    
    sTrain = s(:,1:25);
    sTest = s(:,25:32);
    
    n = 0.05;
    beta = 1;
    iterations = 99999;
    
    tangHyp = @(x) tanh(beta*x);
    tangHypDeriv = @(x) beta*(1-(tangHyp(x).^2));
    hiddenLayerSizes = [3 3];
    error = 0.1;
    
    W = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, tangHyp, tangHypDeriv);
    
    
    for i = 1:8
       [sTest(:,i) testPerceptron(psi(i,:), W, tangHyp)]
    end
    

end

function result = seqrep(V,N) 
    l=length(V); 
    a=zeros(l^N,N); 
    for i=1:N 
        a(:,i)=reshape(reshape(repmat((1:l),1,l^(N-1)),l^i,l^(N-i))',l^N,1); 
    end 
    result=V(a);
end