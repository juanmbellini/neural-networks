filename = 'terrain09.data';
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

tangHyp = @(x) tanh(beta*x);
tangHypDeriv = @(x) beta*(1-(tangHyp(x).^2));
lin = @(x) x;
linDeriv = @(x) 1;

hiddenLayerSizes = [6 4 4 4];
error = 0.1;


W = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, tangHyp, tangHypDeriv);


for i = 1:141
   [sTest(:,i) testPerceptron(psiTest(i,:), W, tangHyp)]
end

testedValues = zeros(441,1);
for i = 1:441
   testedValues(i,1) = testPerceptron(psi(i,:), W, tangHyp);
end

%plot3(psi(:,1), psi(:,2), testedValues, 'ro');
%{
plot(testedValues', 'ro');
hold on
plot(s,'g+');
%}
surf(delaunay(psi(:,1), psi(:,2)), psi(:,1), psi(:,2), testedValues);

