# GPU Programming with CUDA

This repository contains the code for the GPU Programming with CUDA project.

## Prerequisites
1) Check the system requirements: Make sure that your Windows machine meets the system requirements for installing CUDA. You can find the system requirements on the NVIDIA website.

2) Download the CUDA toolkit: Download the CUDA toolkit installer from the NVIDIA website. Make sure that you download the version that is compatible with your Windows operating system and the version of Visual Studio that you are using (if applicable).

3) Run the installer: Double-click the downloaded installer to launch it. Follow the prompts to complete the installation. You can choose the components you want to install, but it is recommended to install all components.

4) Set environment variables: After the installation is complete, you need to set the `PATH` and `CUDA_PATH` environment variables. To do this, right-click on the Windows Start button and select "System". Click on "Advanced system settings" and then click on "Environment Variables". Under "System Variables", click on "New" and add the following: 
   
Variable name: `PATH`  
Variable value: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\vX.Y\bin`  
(Replace `X.Y` with the version of CUDA you installed, for example, `v11.4`)  
  
Click on "New" again and add the following:  
Variable name: `CUDA_PATH`  
Variable value: `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\vX.Y`  
(Replace `X.Y` with the version of CUDA you installed, for example, `v11.4`)

5) Verify the installation: To verify that CUDA is installed correctly, open a command prompt and type nvcc --version. This should display the version of the CUDA compiler. You can also run some sample CUDA programs to make sure that everything is working correctly.

That's it! You have successfully installed CUDA on your Windows machine.

## Execute the code

To execute the CUDA code, follow these steps:

- Open a terminal or command prompt and navigate to the directory where the file is saved.
- Compile the code using the nvcc compiler provided by the CUDA toolkit. Type the following command in the terminal: `nvcc vector_addition.cu -o vector_addition`  
This command compiles the `vector_addition.cu` file and generates an executable file called `vector_addition`.
- Run the executable file by typing the following command in the terminal:
`./vector_addition`  
This command executes the `vector_addition` program on the GPU, and the output is displayed in the terminal.