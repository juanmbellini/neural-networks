function activationFunctions = activationFunctions()
    activationFunctions.tangHyp = @tangHyp;
    activationFunctions.tangHypDeriv = @tangHypDeriv;
    activationFunctions.expo = @expo;
    activationFunctions.expoDeriv = @expoDeriv;
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

function[ret] = expo(x)
    beta = 1;
    ret = (1+exp(-2*beta*x)).^(-1);
end

function[ret] = expoDeriv(x)
    beta = 1;
    g = expo(x);
    ret = 2*beta*g.*(1-g);
end



