% Function that automates traininig of netwotks
% @param trainingConfigurations A .mat file with a cell containing the paths to the configuration files of nets
function[] = automate_training(trainingConfigurations)
	load(trainingConfigurations);
	for conf = confs % confs variable is loaded in previous line
		clearvars -except confs conf aux;
		aux = char(conf);
		disp(strcat('Now training with configuration ', aux));
		train(aux);
	end
end