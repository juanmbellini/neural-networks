%% psi: entry values
%% s: with the waited values for each given set of entry data
%% iterations: maximum amount of iterations
%% hiddenLayerSizes: array containing the size of each hidden layer
%% g: transference function
%% gDeriv: derivative of the transference function

function[W] = backpropagation(psi, s, n, error, iterations, hiddenLayerSizes, g, gDeriv)

    layerSizes = [length(psi(1,:)) hiddenLayerSizes length(s(:,1))];

    M = length(layerSizes);

    V = cell(1,M);

    W = cell(1,M);
    
    H = cell(1,M);
    
    Delta = cell(1,M);
    o = zeros(length(s(:,1)),length(s));
    
    diff = o - s;
    
    finish = false;
    
    for m = 2:M
       W{m} = rand([layerSizes(m) (layerSizes(m-1)+1)]) - 0.5;
    end
    
    while(iterations > 0 && ~finish)
       iterations = iterations - 1;
       indexes = randperm(length(s));
       
       for i = indexes
          
           %% paso 2
           V{1} = psi(i,:)';
           V{1} = [-1; V{1}];
           
           %% paso 3
           for m = 2:M
               H{m} = W{m}*V{m-1};
               V{m} = g(H{m});
               if(m ~= M)
                 V{m} = [-1; V{m}];
               end
           end
           V{M} = V{M}*10;
           %% paso 4
           Delta{M} = gDeriv(H{M}).*(s(:,i)-V{M});
           
           %% paso 5
           for m = M:-1:3
              Delta{m-1} = gDeriv(H{m-1}).*(W{m}(:,2:end)'*Delta{m});
           end
           
           %% paso 6
           for m = 2:M    
               W{m} = W{m} + n*Delta{m}*(V{m-1}');
           end
           
           
           o(:,i) = V{M};
           diff = o - s;
           
           if(abs(diff) < error)
               finish = true;
           end
           
       end
        
        
    end
    o

end
