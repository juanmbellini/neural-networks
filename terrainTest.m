filename = 'terrain10.data';
delimiterIn = ' ';
headerlinesIn = 1;
A = importdata(filename,delimiterIn,headerlinesIn);
terrain = A.data;

psi = terrain(:,1:2);
psiTrain = psi(1:300,:);
psiTest = psi(301:441,:);

s = terrain(:,3)';
sTrain = s(:,1:300);
sTest = s(:,301:441);

n = 0.05;
beta = 1;
iterations = 99999;

multi = 1;

tangHyp = @(x) tanh(beta*x);
tangHypDeriv = @(x) beta*(1-(tangHyp(x).^2));
lin = @(x) 0.1*x;
linDeriv = @(x) 0.1;
tangHypMulti = @(x) multi*tangHyp(x);
tangHypMultiDeriv = @(x) multi*tangHypDeriv(x);

g = tangHyp;
gDeriv = tangHypDeriv;

hiddenLayerSizes = [6 4 4 4];
error = 0.1;

normalizer = @(x) 0.1*(x + 10)-1;
denormalizer = @(x) ((x+1)/0.1)-10;

W = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, normalizer);

testedValues = zeros(441,1);
for i = 1:441
   testedValues(i,1) = testPerceptron(psi(i,:), W, g, denormalizer);
end

%plot3(psi(:,1), psi(:,2), testedValues, 'ro');

%{
plot(testedValues', 'ro');
hold on
plot(s,'g+');
%}

[xx,yy]=meshgrid(-2:0.1:2,-2:0.1:2);
zz = griddata(psi(:,1), psi(:,2), testedValues, xx, yy);
surf(xx,yy,zz)



