# Computed Tomography Reconstruction 

## System Setup

1. Install Matlab_R2022b. 
2. During the installation the application will ask for Add-ons. Install the following Toolbox:

   Image Processing Toolbox  
   Statistics and Machine Learning Toolbox
   
   
3. Download all the files from within the folders in this GitHub and place them in the Documents/Matlab folder in your system.
4. Open the Matlab application and open the script ProjectGUI.mlapp
5. Hit the Run button and this open a GUI showing our Project.

<img width="760" alt="Screenshot 2022-12-08 at 11 55 37 PM" src="https://user-images.githubusercontent.com/90299324/206814330-3c15d5cc-0771-4d1a-b964-ffbda3ddc808.png">

## Code description

The MATLAB code is attached. A list of the files is as follows:
1. ProjectGUI.mlapp: code for MATLAB GUI interface. Run this file to start the program.
2. Generatesinogram.m: generates the sinogram for the input images.
3. fbp_discphantom.m: this function creates a disk phantom and reconstructs the ct using simple back projection, filtered back projection, and filtered back projection using iradon transform.
4. fbp_shepplogan.m: this script uses the shepp logan phantom to reconstruct ct using back projection and filtered back projection using iradon transform.
5. sart_discphantom.m: this function reconstructs the disk phantom using Simultaneous Algebraic Reconstruction Technique SART. 
6. discphantomnorm.mat: The sart_discphantom.m uses the normalized (0 to 0.0309) mat file of the disk to perform the SART.
7. sart_shepplogan.m: this script reconstructs the shepp logan phantom using Simultaneous Algebraic Reconstruction Technique SART.
8. Shepplogannorm.mat: The sart_shepplogan.m uses the normalized (0 to 0.0309) mat file of the disk to perform the SART.


## CT reconstruction using GUI

1. Once the GUI window shows up. Use the Load Shepp logan button to open the file explorer.
2. Select the SheppLogan_Phantom.png file.
3. Click on Generate sinogram button to see the sinogram generated using radon transform.
4. Click on FBP button to perform the reconstruction using Filtered Back Projection.
5. This operation can take some time based on your system configuration

## Simple Back Projection 
<img width="769" alt="Screenshot 2022-12-09 at 6 10 15 PM" src="https://user-images.githubusercontent.com/90299324/206814728-f260845b-b2dd-4c3e-b8ec-0667cabab8ae.png">

## Filtered Back Projection using iradon transform
<img width="769" alt="Screenshot 2022-12-09 at 6 10 59 PM" src="https://user-images.githubusercontent.com/90299324/206814766-b2e11dd2-322f-4900-a85e-5b9eed11ab94.png">

## Simultaneous Algebraic Reconstruction Technique (SART)
<img width="769" alt="Screenshot 2022-12-09 at 6 16 53 PM" src="https://user-images.githubusercontent.com/90299324/206816301-4aa6dd61-beee-4120-9d0e-7ca8c5a5bfe5.png">





