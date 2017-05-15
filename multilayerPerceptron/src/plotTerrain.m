function[] = plotTerrain(psi, s)
	[xx,yy]=meshgrid(-4:0.1:4,-4:0.1:4);
	zz = griddata(psi(:,1), psi(:,2), s, xx, yy);
	surf(xx,yy,zz);
	drawnow;
end
         