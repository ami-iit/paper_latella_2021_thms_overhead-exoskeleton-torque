<h1 align="left">URDF template</h1>

The human body is modeled as a rigid multi-body system with a certain
 number of links connected by joints.  The model consists of simple geometric
 shapes (parallelepiped, cylinder, sphere) whose dimensions are dependent 
from the Xsens motion acquisition by making the model dimensions 'scalable'
 for different subjects.  Due to the strong dependency from the Xsens model
 (23-links biomechanical model), we reconstruct our model in a very similar
 way for a better matching with the data coming from the Xsens motion tracking. 

Due to the physiological constraints of the human joints, the human template owns 48 DoFs.

<p align="center"><img src="https://user-images.githubusercontent.com/10923418/147951072-55ff2d74-7b6a-4d36-99b1-b34d02899646.png" alt=""/></p>

The template `XSensModelStyle_48URDFtemplate.urdf` is composed of 1-DoFs revolute joints and combination of them to obtain a series of joints with a higher number of DoFs.  As a straightforward consequence, this choice implies the presence of 'fake' links (denoted in the templates with *name-of-the-link_f*) with mass and dimensions negligible.  

<p align="center"><img src="https://user-images.githubusercontent.com/10923418/147951605-f19b5058-0437-4cfd-a05d-1a854854ced6.png" alt=""/></p>