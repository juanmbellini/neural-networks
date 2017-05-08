function[] = plotTerrain(psi, s)
	[xx,yy]=meshgrid(-2:0.1:2,-2:0.1:2);
	zz = griddata(psi(:,1), psi(:,2), s, xx, yy);
	surf(xx,yy,zz);
	drawnow;
end
         