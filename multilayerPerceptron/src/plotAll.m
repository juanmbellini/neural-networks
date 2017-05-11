function [] = plotAll(psi, s, trainingMeanErrors, testedValues, allTestedValues)
    
    testedSize = length(testedValues);
    total = length(s);
    sTested = s(total-testedSize + 1:total);

    subplot(2,2,1);
    plot(testedValues', 'ro');
    quadraticMeanError = mean((sTested-testedValues').^2);
    quadraticMeanError
    hold on
    plot(sTested,'g+');
    title('Real and calculated values');

    subplot(2,2,2);
    plot(abs(testedValues' - sTested),'.b');
    title('Testing error');
    ylabel('error');

    subplot(2,2,3);
    [xx,yy]=meshgrid(-4:0.1:4,-4:0.1:4);
    zz = griddata(psi(:,1), psi(:,2), allTestedValues, xx, yy);
    surf(xx,yy,zz);
    hold on
    plot3(psi(:,1), psi(:,2), s, 'ro');
    title('Terrain representation');

    
    subplot(2,2,4);
    plot(trainingMeanErrors);
    title('Mean error variation in training');
    xlabel('epoch');
    ylabel('mean error');


end

