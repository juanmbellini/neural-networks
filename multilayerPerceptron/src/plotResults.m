% Function that actually plots testing results
function[] = plotResults(testedValues, sTested, psi, allTestedValues, s, trainingMeanErrors, testingMeanErrors)
    subplot(2,2,1);
    plot(abs(testedValues' - sTested),'.b');
    title('Testing error');
    ylabel('error');

    subplot(2,2,2);
    [xx,yy]=meshgrid(-4:0.1:4,-4:0.1:4);
    zz = griddata(psi(:,1), psi(:,2), allTestedValues, xx, yy);
    surf(xx,yy,zz);
    hold on
    plot3(psi(:,1), psi(:,2), s, 'ro');
    title('Terrain representation');
    
    subplot(2,2,3);
    plot(trainingMeanErrors);
    title('Mean error variation in training');
    xlabel('epoch');
    ylabel('mean error');
    
    subplot(2,2,4);
    plot(testingMeanErrors,'.r');
    title('Mean error variation in testing');
    xlabel('epoch');
    ylabel('mean error');

end