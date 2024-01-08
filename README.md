# COFE : Core rOot Feature Extraction

## Software developed to analyze crop plant's excavated mature root
##### Developed at: Ganapathysubramanian group ([ISU](https://www.me.iastate.edu/bglab))

Developed by: [Zaki Jubery](mailto:znjubery@gmail.com)

GUI development: Zaki Jubery

### Updated Version
* This version of COFE is specifically designed for users who marked a red line or red tape along the soil line during the image-capturing session. COFE employs automatic detection of the red line to identify the soil line, thereby eliminating the need for manual selection during the image-processing session.
### Features
* COFE uses automated digital trimming of outlier roots to improve the estimation of root angles.
* COFE is optimized for use on adult, field-grown plants.
* Two steps process: image pre-processing and trait extraction. Image processing step faciliates user to annotate soil line. (for this updated version, this step is not required)
* COFE is an adaptation of our existing software ARIA (Pace et al. 2014) which was developed for lab-based phenotyping of immature root systems.
* Modular framework that allows extensions.  
* GUI based framework for ease of use.

### Dependencies
* MATLAB (minimum version: 2018b with Image Processing Toolbox, Parallel Computing Toolbox, Statistics and Machine Learning Toolbox and MATLAB Distributed Computing Server)
* Operating system: Windows/Mac

### How to use it
#### Setting up:
* After downloading the source code. Run COFE.m function.

#### Annotation File Preparation
* Please prepare an excel file as /data/sampleinput/sample_annotation.xlsx. where
	* plantid : unique id including metadata
	* Genotype : genotype name
	* photo1 : as root viewed from between rows
	* photo2 : as root viewed from within a row
	* Note that, the excel sheet name indicates the repetition of the experiment. Please use the name as Rep1, Rep2,..., and seperate sheet for each reps.   

#### Image Pre-Processing:
* This step faciliates user to define the soil line and crop the images accordingly. User needs to provide the following information to continue. 
	* Image location : location of original images
	* Rotate image? : no/yes
	* Select OS:Windows/Mac
	* Output location: location to save pre-processed images
The cropped images will be save in the selected output location under cropped_images subfolder.
#### Trait Extraction:
* This step reads the cropped images, segments the root from background, performs digitial trimming and extracts traits including angle. User needs to provide the following information to continue. 
	* Cropped image location: location of the cropped images 
	* Annotation file: location of the xlsx file containing annotation
	* Rep Number : repetition number as per annotation file 
	* Thresholding value: value related to image segmentation. please adjust this hueristically between 0.1 to 0.7 based on the hue of the image background. 
	* Pix2cm: specify 1 cm in terms of pixels
	* Number of processors: specify number of processor for parallel processing
	* Output location: location to save extracted traits and related files
* The extracted traits will be saved in the selected output location under "rep1_ExtractedData" subfolder. It will contain the files
    * N_Global.xls : Traits related to all photo1 (as root viewed from between rows)
	* W_Global.xls : Traits related to all photo2  (as root viewed from within rows)
	* GM_Global.xls : Geometric mean of the traits related to photo1 and photo2
	* TraitsMAT.mat : Contains the all three xlsxs data in binary format 
* Along with there will be subfolders related to 
	* segmented images(segmentedimages)
	* digitially trimmed images (trimmedimages) 
	* adjusted depth (adjusted_depth_figs) 
	* angles (angles_fig) 

#### Trait Description
Genotype  
Repinfo  
ImageID  
RootID : small/big based on the area of the two roots    
Depth : Depth of the root (cm)  
Area : Area of the root in $(cm^2)$  
ConArea : Convex area, area of the smallest polygoan (convex) around the root $(cm^2)$  
Solidity : Area/Convex area  
CofMass : Center of Mass  
MedWidth : Meadian Width (cm)  
MaxWidth : Maximum Width (cm)  
LofMaxWidth: Location (depth) of MaxWidth from the SoilLine (cm)  
RelLoMaxWidth: Relative location of Maxwidth, LofMaxWidth/Depth  
DATMaxWidth : Density of root at the depth where the Maximum Width  
DAtMaxWidthZ : density around maximum width (0.5 cm above and below)  


Note that root angles measure average width over some 100 pixels interval  
WPA : Centered Width profile angle  
La : Centered  Width profile angle using Left part of the root  
Ra : Centered  Width profile angle using Right part of the root  
PWPA : Width profile angle  

BaseWidth : Root width at the soil line  
BWidth : Root width at the soil line (cm)  
ADepth_01 : Adjusted depth (cm), depth at which (below a cutoff depth or   below the location of maximum width) root density is 0.1  
...  
ADepth_09 : Adjusted depth (cm), depth at which (below a cutoff depth    or    below the location of maximum width) root density is 0.9

MeanWidth : Mean of the Width measured at different depth (cm) 
      	
ModeWidth : Mode of the Width measured at different depth (cm)      

### Citations:
If you use COFE please cite us

* Zihao Zheng, Stefan Hey, Talukder Jubery, Huyu Liu, Yu Yang, Lisa Coffey, Brandi Sigmon, James C. Schnable, Frank Hochholdinger, Dan Nettleton,Baskar Ganapathysubramanian and Patrick S. Schnable, "Shared genetic control of root system architecture between Zea mays and Sorghum bicolor", " Plant Physiology 182.2 (2020): 977-991.  

### Funding Acknowledgements
We gratefully acknowledge funding from  Presidential initiative for interdisciplinary research of Iowa State University and Plant Science Institute at Iowa State University.

### Feel free to raise issues and contribute to the Software.

##### Contact:
Baskar Ganapathysubramanian

Mechanical Engineering

Iowa State University

baskarg@iastate.edu