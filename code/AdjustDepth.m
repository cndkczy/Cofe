function [ Nrootimage2,Wrootimage2 ] = AdjustDepth(Nrootimage,Wrootimage,NPixtoCm,WPixtoCm)
%% Adjusts/Crops images to make the depth of the root from two views are the same
% Input Arguments
    % Nrootimage : binary image (between rows)
    % Wrootimage : binary image (with-in-row)
    % NPixtoCm : conversion scale (for between rows)
    % WPixtoCm : conversion scale (for with-in-row)
% Output Arguments
    % Nrootimage : adjusted binary image (between rows)
    % Wrootimage : adjusted binary image (with-in-row)
% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
% Converting depth from pixel to cm
%north
ND=size(Nrootimage);
NDs=ND(1)/NPixtoCm;
%west
WD=size(Nrootimage);
WDs=WD(1)/WPixtoCm;
% find the smallest depth
DAdjust=min(WDs,NDs);
if abs(WD-ND)>10
if DAdjust==NDs
    Nrootimage2=Nrootimage;
    % Modified starting point for Wrootimage
    WtrimS=WD-NDs*WPixtoCm;
    % crop Wrootimage
    Wrootimage2=Wrootimage(round(WtrimS,0):end,:);
end
if DAdjust==WDs
    Wrootimage2=Wrootimage;
    % Modified starting point for Nrootimage
    NtrimS=ND-WDs*NPixtoCm;
    % crop Nrootimage
    Nrootimage2=Nrootimage(round(NtrimS,0):end,:);
end
else
 Wrootimage2=Wrootimage;
 Nrootimage2=Nrootimage;
end
end

