% Function that automates testing of netwotks
% Will save plots and an ouput csv file with name of trained networks and quadratic mean error for each.
% @param testingConfigurations A .mat file with a cell containing the paths to the nets stored in a variable called confs
% @param csvOutputFilePath name (including directory) for the csv output file. Do not include '.csv' extension.
function[] = automate_testing(testingConfigurations, csvOutputFilePath)
	load(testingConfigurations);

	[rowsUnused amountOfNetworks] = size(confs);
	outputCell = cell(amountOfNetworks, 2);
	actual = 1;
	for conf = confs % confs variable is loaded in previous line
		clearvars -except conf confs actual outputCell amountOfNetworks csvOutputFilePath
		aux = char(conf);
		disp(strcat('Now testing with network ', aux));
		quadraticMeanError = testAndPlot(aux);

		% Store results for CSV file
		outputCell{actual, 1} = conf;
		outputCell{actual, 2} = quadraticMeanError;

		% Save plot
	    [directory, fileName] = fileparts(aux); % Separates network file name from directory
	    [nets improvement] = fileparts(directory); % Separates the './net' part from the 'kind of improvement' part
	    [nets testingVariable] = fileparts(nets);
	    plotPath = strcat('./figs/', testingVariable, '/', improvement);
		if ~exist(plotPath, 'dir')
			mkdir(plotPath);
		end
	    savefig(strcat(plotPath, '/', fileName));

		clf;

		actual = actual + 1;
	end

	% Create a CSV file with results
	fid = fopen(strcat(csvOutputFilePath, '.csv'), 'w+');
	fprintf(fid, 'Used network (path), Quadratic mean error\n'); % Headers of csv
	for actual = 1:1:amountOfNetworks
		net = char(outputCell{actual, 1});
		qme = num2str(outputCell{actual, 2});
		fprintf(fid, '%s , %s\n', net, qme);
	end
end