# Installation


### Important note on the operative system
- The installation works interely on macOS.
- The code has also been tested for Ubuntu and Windows but reported several issues.  If you want to proceed with this, please refer to [this comment](https://github.com/ami-iit/paper_latella_2021_thms_overhead-exoskeleton-torque/issues/1) for code testing.


## Dependencies
- [Matlab](https://www.mathworks.com/products/matlab.html)
- [Mokka](http://biomechanical-toolkit.github.io/mokka/)
- [OpenSim APIs for MATLAB](https://simtk-confluence.stanford.edu:8443/display/OpenSim/Scripting+with+Matlab)


## robotology-superbuild

Installing the components of Robotology of the code associated with the paper seperately can be tricky. [Robotology-superbuild](https://github.com/robotology/robotology-superbuild) offers a convenient way to setup the required infrastructure, using [robotology project tags](https://github.com/robotology/robotology-superbuild/blob/master/doc/change-project-tags.md). The required version of the code is updated in [thms.yaml](./thms.yaml). Before installing the robotology-superbuild be sure to install the required dependencies following [this](https://github.com/robotology/robotology-superbuild#linux-macos-or-windows-from-source-with-dependencies-provided-by-conda-forge).  Please follow the instructions below to setup robotology components.

```
git clone https://github.com/ami-iit/paper_latella_2021_thms_overhead-exoskeleton-torque.git
export THMS_ROOT=`pwd`/paper_latella_2021_thms_overhead-exoskeleton-torque
git clone https://github.com/robotology/robotology-superbuild
cd robotology-superbuild
git checkout v2021.05
mkdir build
cd build
cmake -DROBOTOLOGY_PROJECT_TAGS:STRING=Custom -DROBOTOLOGY_ENABLE_DYNAMICS=True -DROBOTOLOGY_USES_MATLAB=True -DROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE=${THMS_ROOT}/thms.yaml ..
make
```

:warning: Do not forget to configure your environment after successfully compiling robotology-superbuild. Please check [configure-your-environment](https://github.com/robotology/robotology-superbuild#configure-your-environment) section for further details.


## MVNX parser

Install the [YARP drivers for the Xsens MVNX system](https://github.com/robotology-playground/xsens-mvn)

```bash
cd path-to-your-own-code-folder
git clone https://github.com/robotology-playground/xsens-mvn.git
mkdir build
cd build
cmake ..
ccmake .
```

- Set the CMake options:

 |   Flag ON|  Flag OFF|
|:---:|:---:|
| ` XSENS_MVN_ENABLE_PARSER`| `ALLOW_IDL_GENERATION`, `ENABLE_xsens_mvn_remote`, `ENABLE_xsens_mvn_remote_light`|


- Define the CMake install prefix , e.g., 
`CMAKE_INSTALL_PREFIX = your-own-path/xsens-mvn/build/install`

 ```bash
cmake --build . --config Release --target install
cd install/bin
```