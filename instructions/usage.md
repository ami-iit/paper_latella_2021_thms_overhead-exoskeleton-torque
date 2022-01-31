# Usage


Clone the paper repository

```
cd path-to-your-own-code-folder
git clone https://github.com/ami-iit/paper_latella_2021_thms_overhead-exoskeleton-torque.git
```

## Prepare the dataset
- Download Zenodo paper dataset at [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1472214.svg)](https://doi.org/10.5281/zenodo.1472214)
- For the dataset interpretation, please refer to the following list:

 ```
Legend: 
NE = no exo
WE = with exo
----------------------
|  S01:  0 WE, 1 NE  |
|  S02:  0 NE, 1 WE  |
|  S03:  0 WE, 1 NE  |
|  S04:  0 NE, 1 WE  |
|  S05:  0 WE, 1 NE  |
|  S06:  0 NE, 1 WE  |
|  S07:  0 WE, 1 NE  |
|  S08:  0 NE, 1 WE  |
|  S09:  0 WE, 1 NE  |
|  S010: 0 NE, 1 WE  |
|  S011: 0 WE, 1 NE  |
|  S012: 0 NE, 1 WE  |
----------------------
 ```

- In the`dataset` folder, build the following data struct **per each subject**:
  
  ![Screenshot 2022-01-28 at 11 12 47](https://user-images.githubusercontent.com/10923418/151528879-433fb3ec-e3f9-4157-82fa-cc27b2879a1d.png)


**Per each task folder**:

### 1) `.mvnx` data
- Import the `.mvnx` file from Zenodo dataset to the created matlab task folder `data`.
- Rename this file with the following syntax: `S0X_0Y.mvnx` (being X = number of subject, Y = number of task).
- Create in folder `data` a new folder called `parsedFromMvnx`.
- After MVNX parser installation (see [installation.md](https://github.com/ami-iit/paper_latella_2021_thms_overhead-exoskeleton-torque/blob/master/instructions/installation.md)), browse to `your-own-path/xsens-mvn/build/install/bin`.
- From a terminal, launch the parser (in a unique command),

```
 ./MVNXParser --outputFolder /Users/path-to-paper-repo/paper_latella_2021_thms_overhead-exoskeleton-torque/dataset/S0X/Task0/data/parsedFromMvnx /Users/path-to-paper-repo/paper_latella_2021_thms_overhead-exoskeleton-torque/dataset/S0X/Task0/data/S0X_0Y.mvnx
```
- Check that you get the following files after parsing into `parsedFromMvnx` folder:
  ![149149292-1b1447be-1a5e-4140-b72f-6a95d3722957](https://user-images.githubusercontent.com/10923418/151414794-2a3e0532-02bc-4dec-bdd8-8b577cc2909f.png)

### 2) `.trc` data
- Import the `.c3d` file from Zenodo dataset to the created matlab task folder `data`.
- Rename this file with the following syntax: `S0X_0Y.trc` (being X = number of subject, Y = number of task).
- After Mokka visualizer installation (see [installation.md](https://github.com/ami-iit/paper_latella_2021_thms_overhead-exoskeleton-torque/blob/master/instructions/installation.md)), import `.c3d` the file into the visualizer.
- Export the file as a `.trc`, as follows

   <img width="620" alt="Screenshot 2022-01-12 at 13 40 40" src="https://user-images.githubusercontent.com/10923418/149142259-e5690dab-6935-4f4e-ad63-0ffb423a95e3.png">
- Save the `.trc` file in the task folder `data` by following the same syntax rule as before (i.e., `S0X_0Y.c3d`).

### 3) `.mat` data
- Import the `.mat` file from Zenodo dataset to the created matlab task folder `data`.
- Rename this file with the following syntax: `S0X_0Y.mat` (being X = number of subject, Y = number of task).
- Further, copy `S0X_0Y_rawExo.mat` file from `dataset/exo_raw_data` to the corrispondent matlab task folder.

 
Now you are ready to run the code.


## Run the code

### a) Intra-subject computation
Per each subject `S0X`, run `batch_processing/batch_subX.m`.

### b) Inter-subject analysis
Once you computed the (previous) intra-subject analysis (i.e., having all the outputs automatically stored in each `S0X` folder), run `analysis/analysis_main.m`.
