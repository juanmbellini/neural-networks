function[] = fiveBitAnd()

    binaryNums = [1 -1];
    
    psi = seqrep(binaryNums, 5);
    
    s = zeros(1, length(psi(:,1)));
    
    for i = 1:length(s)
        if (psi(i,1) == 1) && (psi(i,2) == 1) && (psi(i,3) == 1) && (psi(i,4) == 1) && (psi(i,5) == 1)
            s(i) = 1;
        else
            s(i) = -1;
        end
    end
    
    n = 0.05;
    beta = 1;
    iterations = 99999;
    
    tangHyp = @(x) tanh(beta*x);
    tangHypDeriv = @(x) beta*(1-(tangHyp(x).^2));
    hiddenLayerSizes = [5 5 5 4 3 2];
    
    backpropagation(psi, s, n, error, iterations, hiddenLayerSizes, tangHyp, tangHypDeriv);
    
    

end

function result = seqrep(V,N) 
    l=length(V); 
    a=zeros(l^N,N); 
    for i=1:N 
        a(:,i)=reshape(reshape(repmat((1:l),1,l^(N-1)),l^i,l^(N-i))',l^N,1); 
    end 
    result=V(a);
end