function transferFunctions = transferFunctions()
    transferFunctions.tangHyp = @tangHyp;
    transferFunctions.tangHypDeriv = @tangHypDeriv;
end

%   hyperbolic tangent

function[ret] = tangHyp(x)
    beta = 1;
    ret = tanh(beta*x);
end

function[ret] = tangHypDeriv(x)
    beta = 1;
    ret = beta*(1-(tangHyp(x).^2));
end

% exponential
