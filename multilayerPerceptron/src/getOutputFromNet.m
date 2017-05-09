function [o] = getOutputFromNet(pattern, W, g, psiNormalizer, sDenormalizer)

    pattern = psiNormalizer(pattern);
    M = length(W);
    V = cell(1,M);
    H = cell(1,M);
    
    %% step 2
    V{1} = pattern';
    V{1} = [-1; V{1}];

    %% step 3
    for m = 2:M
       H{m} = W{m}*V{m-1};
       V{m} = g(H{m});
       if(m ~= M)
         V{m} = [-1; V{m}];
       end
    end
    
    o = sDenormalizer(V{m});

end