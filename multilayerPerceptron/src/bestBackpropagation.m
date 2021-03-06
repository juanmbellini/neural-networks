%% psi: entry values
%% s: with the waited values for each given set of entry data
%% iterations: maximum amount of iterations
%% hiddenLayerSizes: array containing the size of each hidden layer
%% g: transference function
%% gDeriv: derivative of the transference function

function[W, trainingMeanErrors, testingMeanErrors, trainingQuadraticMeanError] = bestBackpropagation(psiTrain, psiTest, sTrain, sTest, n, error, iterations, hiddenLayerSizes, g, gDeriv, psiNormalizer, sNormalizer, denormalizer, a, b, alfa, showProgress)

    disp('best backpropagation');
    
    origAlfa = alfa;
    
    psi = psiNormalizer(psiTrain);
    s = sNormalizer(sTrain);
    
    layerSizes = [length(psi(1,:)) hiddenLayerSizes length(s(:,1))];

    M = length(layerSizes);

    V = cell(1,M);

    W = cell(1,M);
    
    H = cell(1,M);
    
    Delta = cell(1,M);
    o = zeros(length(s(:,1)),length(s));
    
    currentError = mean(abs(o - s));
    prevError = currentError;
    improvementCounter = 0;
    
    %%amount of iterations of improvent needed to change n (for adaptive n)
    maxImprovement = 1;
    
    finish = false;
    showProgress = nargin == 17; % If nargin is 17, function was called using the showProgress value
    
    DeltaW = cell(1,M);
    
    trainingMeanErrors = [];
    testingMeanErrors = [];
    
    epoch = 0;
    
    for m = 2:M
       limit = (layerSizes(m-1)+1)^(1/2);
       W{m} = rand([layerSizes(m) (layerSizes(m-1)+1)])*2*limit - limit;
       DeltaW{m} = zeros(layerSizes(m),(layerSizes(m-1)+1));
    end
    
    DeltaWOld = DeltaW;
    
    %save the old weights in case a step has to be undone
    Wold = W;
    
    while(epoch ~= iterations && ~finish)
       epoch = epoch + 1;
       indexes = randperm(length(s));
       
       for i = indexes
          
           %% step 2
           V{1} = psi(i,:)';
           V{1} = [-1; V{1}];
           
           %% step 3
           for m = 2:M
               H{m} = W{m}*V{m-1};
               V{m} = g(H{m});
               if(m ~= M)
                 V{m} = [-1; V{m}];
               end
           end

           if showProgress && mod(i, 100) == 0
            plotTerrain(psi, o);
          end
           
           %% step 4
           Delta{M} = gDeriv(H{M}).*(s(:,i)-V{M});
           
           %% step 5
           for m = M:-1:3
              Delta{m-1} = gDeriv(H{m-1}).*(W{m}(:,2:end)'*Delta{m});
           end
           
           %% step 6
           for m = 2:M    
               %add momentum term
               DeltaW{m} = n*Delta{m}*(V{m-1}') + (alfa * DeltaWOld{m});
               W{m} = W{m} + DeltaW{m};
           end
           DeltaWOld = DeltaW;
           
           o(:,i) = V{M};
           currentError = mean(abs(o - s));
           if(abs(o-s) < error)
               finish = true;
           end
       end
       
       %error decreased
       if(currentError < prevError)
           alfa=origAlfa;
           improvementCounter = improvementCounter + 1;
           %if it improves consistently
           if(improvementCounter >= maxImprovement)
             n = n + a;
             improvementCounter = 0;
           end
           
       %error increased  
       elseif(currentError > prevError)
           improvementCounter = 0;
           W = Wold;
           n = n -(b*n);
           alfa = 0;
       end
       Wold = W;
       prevError = currentError;
       trainingMeanErrors = [trainingMeanErrors mean(abs(sTrain-denormalizer(o)))];
       testingMeanErrors = [testingMeanErrors mean(abs(sTest'-test(psiTest,sTest,W,g,psiNormalizer,denormalizer)))];
       
          
    end
    disp(epoch);
    trainingQuadraticMeanError = mean((s-o).^2);

end
