filename = './data/terrain10.data';
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

transferFunctions = transferFunctions();

g = transferFunctions.tangHyp;
gDeriv = transferFunctions.tangHypDeriv;

hiddenLayerSizes = [6 4 4 4];
error = 0.1;

normalizers = normalizers();
denormalizers = denormalizers();

W = backpropagation(psiTrain, sTrain, n, error, iterations, hiddenLayerSizes, g, gDeriv, normalizers.entryNormalizerFromMinus4_4, normalizers.tangHypNormalizerFromMinus10_10);

testedValues = zeros(441,1);
for i = 1:441
   testedValues(i,1) = testPerceptron(psi(i,:), W, g, normalizers.entryNormalizerFromMinus4_4, denormalizers.tangHypDenormalizerToMinus10_10);
end

%plot3(psi(:,1), psi(:,2), testedValues, 'ro');

%{
plot(testedValues', 'ro');
hold on
plot(s,'g+');
%}

plot(abs(testedValues' - s),'ro');

%{
[xx,yy]=meshgrid(-2:0.1:2,-2:0.1:2);
zz = griddata(psi(:,1), psi(:,2), testedValues, xx, yy);
surf(xx,yy,zz)
%}


%save('filename.mat', 'W');
%load('filename.mat');

