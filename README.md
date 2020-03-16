# EBM_JA
Energy-Balance Model for exploring processes driving the latitude of the sea-ice edge.

## Overview
This repository contains MATLAB source code for running simulations in the Energy-Balance Model (EBM) described by _Aylmer et al. (in review)_.

## Requirements
This code has been tested on Windows 7 using MATLAB R2018a and on Linux using MATLAB R2017b. There is no guarantee it will run as intended on other operating systems or with other versions of MATLAB.

## Running the code
There are three files which the user should edit, in the 'bin' directory:
- parameters.m: change parameter values here. Definitions and units are given in the comments.
- settings.m: change general EBM settings here such as grid resolution and integration time.
- run_ebm.m: as the name implies, this script runs the EBM with the specified parameters and settings.

### settings.m
The grid resolution must be specified in terms of the number of grid points (`nphi`) (which includes 0 and 90 degrees latitude). Similarly the time step must be specified in terms of the number of time intervals in 1 year (`nt`) . The total integration time `t_total` must be given as an integer number of years.

It is usually not necessary to save data at every time step. The frequency of saving is specified with `ns`, which is the number of time steps between saved-data points. It is required that `nt/ns` is an integer.

`ic_file` and `ic_subdir` specify the filename and subdirectory (of 'data'), respectively, for the data for which initial conditions should be generated from.

`Sdata_file` is the filename of the insolation forcing to be used. This data must be stored in the 'solar' directory and match the time and grid resolutions specified above. A few datasets are included in this repository with quarter- and eighth-degree spatial resolutions.  

### run_ebm.m

This is the script which should be called from the command line, with 2 or 3 arguments. The first two arguments give the filename and directory name for data files to be saved to. An additional argument of 1 may be used to specify that saved initial conditions are to be used. For example:

`run_ebm('my_ebm_data', 'my_directory');`

will save data to data\my_directory\my_ebm_data.m and will use arbitrary initial conditions (parameters to specify this are in settings.m), whereas

`run_ebm('my_ebm_data', 'my_directory', 1);`

will do the same but use saved initial conditions (again as specified in settings.m). When the EBM is running in the command line, output to the console displays progress. Typically, for an integration time of 30 years with quarter-degree resolution, the EBM takes about 1.5 hours to complete on a standard computing cluster.


## Saved data format
At the end of each model run, two files are saved: one contains the prognostic-variable data for the air temperature (Ta), ocean mixed-layer temperature (Tml), surface temperature (Ts), and ice thickness (Hi) and one for the parameter list. In the examples above, two files would be saved: 'my_ebm_data.m' and 'my_ebm_data_params.m'.
Prognostic variable data is in the format such that each row corresponds to one time, e.g. `Ta(1,:)` is the air temperature profile at initial conditions. Parameters are saved as a struct (similar to a Python dictionary).

## Code testing
Some unit tests are provided in the 'test\unit_test' directory, which may be run in the command line by calling the script UnitTests.m. A manual test of the initial conditions generator function is also included, in 'test\manual\ManualTestInitialConditions.m'.

## References
Aylmer, J., D. Ferreira, and D. Feltham, 2020: Impacts of oceanic and atmospheric heat transports on sea-ice extent. _Journal of Climate (in review)_.
