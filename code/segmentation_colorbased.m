function [BW] = segmentation_colorbased(RGB,ulim)
%% Generates binary image of root by seperating it from the background and
% removing other smaller objects including marker,tag, etc.
% Input Arguments
% RGB : RGB image of the root
% ulim : thresholding value for segmentation
% Output Arguments
% BW : binary image of the root

% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%% 
% constraint the range based on heuristic
if ulim>0.6; ulim=0.6; end
if ulim<0.057; ulim=0.09; end
% Convert RGB image to chosen color space
I = rgb2hsv(RGB);
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.057;
channel1Max = ulim;
% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 1.000;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 1.000;
% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
% Dilate the image to smoothen the roughness in the image
se=strel('disk',2);
sliderBW=imdilate(sliderBW,se);
% get biggest components
BW = bwareafilt(sliderBW, 1, 'Largest');
end
