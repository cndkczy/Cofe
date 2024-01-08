function [Depth, Area, ConArea, Solidity,CofMass,RCofMass,MedWidth,MaxWidth,LofMaxWidth,RelLofMaxWidth,DAtMaxWidthL,DAtMaxWidthZ,MeanWidth,ModeWidth] = GlobalDescriptor( Rootimage,PixtoCm )
%% Extracts global traits 
% Input Arguments
    % Rootimage : binary image 
    % PixtoCm : conversion scale 
% Output Arguments
    % Depth : depth
    % Area  : total area
    % ConArea : convex area 
    % Solidity : solidity
    % CofMass : center of mass, 
    % RCofMass : relative location of the center of mass w.r.t depth
    % MedWidth : median of width 
    % MaxWidth : maximum width
    % LofMaxWidth : location of maximum width
    % RelLofMaxWidth :  relative location of maximum width
    % DAtMaxWidthL : density at maximum width
    % DAtMaxWidthZ : density around maximum width (0.5 cm above and below)
    % MeanWidth : mean of width
    % ModeWidth : mode of width
  
% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
PDepth= MeasureDepth(Rootimage); Depth=PDepth/PixtoCm;
s  = regionprops(Rootimage,'Area','Centroid','ConvexArea','FilledArea','Solidity');
Area= s.Area/(PixtoCm)^2;
ConArea=s.ConvexArea/(PixtoCm)^2; 
Solidity=s.Solidity; 
CofMassA=s.Centroid/(PixtoCm);
CofMass=CofMassA(2);
RCofMass=CofMass/Depth;

% Calculate width and density as a function of depth
[ Awidth,Rowdensity ] = RootWidthDensity(Rootimage,PDepth);

% maximum and median width
MedWidth = median(Awidth)/PixtoCm;
MeanWidth = mean(Awidth)/PixtoCm;
ModeWidth = mode(Awidth)/PixtoCm;
MaxWidth = max(Awidth)/PixtoCm;
%relative and absolute location of maximum width
LofMaxWidthP=mean(find(round(Awidth)==round(MaxWidth*PixtoCm)));
LofMaxWidth=LofMaxWidthP/PixtoCm;
RelLofMaxWidth=LofMaxWidth/Depth;

DAtMaxWidthL = nan; DAtMaxWidthZ = nan;
try
    % Line and zone based density at the maximum width location
    DAtMaxWidthL=Rowdensity(round(LofMaxWidthP,0));

    % selected zone is 0.5 cm above and below the location of maximum width 
    Ulimit=min(round((LofMaxWidth)*PixtoCm,0)-2,length(Rootimage));
    Llimit=max(round((LofMaxWidth-0.5)*PixtoCm,0)+2,1);
    DAtMaxWidthZ=mean(Rowdensity(Llimit:Ulimit));
catch
    disp('density and maximum width are missing')
end

end

