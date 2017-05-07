function [o] = testPerceptron(psi, W, g, denormalizer)

    M = length(W);
    V = cell(1,M);
    H = cell(1,M);
    
    %% paso 2
    V{1} = psi';
    V{1} = [-1; V{1}];

    %% paso 3
    for m = 2:M
       H{m} = W{m}*V{m-1};
       V{m} = g(H{m});
       if(m ~= M)
         V{m} = [-1; V{m}];
       end
    end
    
    o = denormalizer(V{m});

end