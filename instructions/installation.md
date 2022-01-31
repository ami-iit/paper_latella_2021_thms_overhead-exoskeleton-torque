# Installation


⚠️ The code has been tested on macOS Mojave 10.14.5

## Dependencies
- [Matlab](https://www.mathworks.com/products/matlab.html)
- [Mokka](http://biomechanical-toolkit.github.io/mokka/)
- [OpenSim APIs for MATLAB](https://simtk-confluence.stanford.edu:8443/display/OpenSim/Scripting+with+Matlab)

## Codebase components
The following are the main components that are required to run the code for the paper.

- [YARP](https://github.com/robotology/yarp)
- [iDynTree](https://github.com/robotology/idyntree) - on branch: [feature/stack-of-tasks-berdy](https://github.com/ami-iit/idyntree-hde-fork/tree/feature/stack-of-tasks-berdy)


### robotology-superbuild

Installing the components of Robotology seperately can be tricky.
 [Robotology-superbuild](https://github.com/robotology/robotology-superbuild) offers a convenient way to setup the required infrastructure.

To install the robotology-superbuild follows the [source installations](https://github.com/robotology/robotology-superbuild#source-installation) with the following CMake options:

| CMake options|  Flag ON|
|:---:|:---:|
| for [Profile](https://github.com/robotology/robotology-superbuild/blob/master/doc/cmake-options.md#profile-cmake-options) |`ROBOTOLOGY_ENABLE_DYNAMICS`|
| for [Matlab](https://github.com/robotology/robotology-superbuild/blob/master/doc/cmake-options.md#dependencies-cmake-options)  |`ROBOTOLOGY_USES_MATLAB` |


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

- Launch the driver from `your-own-path/xsens-mvn/build/install/bin` as follows,

  - e.g.1:
```./MVNXParser path-to-the-mvnx-file```

  - e.g.2:
```./MVNXParser --outputFolder path-to-the-output-folder path-to-the-mvnx-file ```

 **NOTE:** for launching in Windows no './' is required