# Neural Networks
Second Artificial Intelligence System Project.

## Getting Started

1. Install MATLAB, if you haven't yet

2. Clone the repository or download source code:
```
git clone https://github.com/natinavas/neural-networks.git
```
3. Open the project in MATLAB and change working directory to ```multilayerPerceptron/src```

## Usage
The system is created to run in the MATLAB environment. There are several functions that will do the job for you.
All the features described here are for the terrain problem to be solved.

### Training
There is a training function – train.m – that trains a network for you. You just have to write a MATLAB script (see sampleConfFile.m for an example) and call train, passing the path to the file as an argument. Optionally, you can pass a second argument where you indicate if you want to see the progress of the learning stage.
When finishing the training step, a "neural network file" will be created under ```multilayerPerceptron/src/nets``` directory.

### Testing
There is another function – testAndPlot.m – that will test a given network, and plot results. In this case you must pass as an argument the location of such file.

### Automation
There are scripts that automate the task of training (automate_training.m) and testing (automate_testing.m).

#### Training
This script defines a function that receives as an argument the location of a .mat file in which a "confs" variable is stored. This variable must be a cell containing the locations of the configuration files to be trained.
After running the script, networks will be created according to the configuration files.

#### Testing
This script also defines a function that receives as an argument the location of a .mat file in which a "confs" variable is stored. This variable must be a cell containing the locations of the trained netowork files to be tested. Also, another argument is defines for this function. This second argument is the location in which to place a csv file with output data.
After running the script, a csv file with quadratic mean errors of testing will be created, and plots will be saved.
In order to work well, networks must be placed under ```multilayerPerceptron/src/nets/<aspect-to-be-tested>/<network-architecture>```. Not respecting this will avoid saving the plots.

Example of path of networks:
Having your networks under ```multilayerPerceptron/src/nets/test-of-improvements/10_8_5_4_2``` will result in saving plots under ```multilayerPerceptron/src/figs/test-of-improvements/10_8_5_4_2```.


## Authors
* Juan Marcos Bellini
* Natalia Navas
* Francisco Bartolomé