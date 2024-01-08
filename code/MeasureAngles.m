function [CSm,LSm,RSm,CNSm,BaseWidth]=MeasureAngles(TSrootimage,figsavefolder,fname)
%% Computes angle of the root with respect to vertical axis (towards gravity)
% Input Arguments
% TSrootimage : trimmed binary root image
% figsavefolder : folder to angle related output
% fname : file to save the output
% Output Arguments
%CSm : Total Angle
%LSm :Angle at the left side
%RSm :Angle at the right side
%CNSm :Total Angle
%BaseWidth : Root width at the soil line
% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
% consider top 1000 pixels for angle calculation
BW=TSrootimage(1:1000,:);
for i=1:1000
    tBW=BW(i,:);
    P=find(tBW);
    width(i)=max(P)-min(P);
    Lside(i)=min(P);
    Rside(i)=max(P);
    if i==1
        Lcor=min(P);
        Rcor=max(P);
    end
end

% find largest connected components at the soil line
I1=BW(1,:);
I3=bwconncomp(I1);
numPixels=cellfun(@numel,I3.PixelIdxList);
[~,idx]=max(numPixels);
for i=1:length(I3.PixelIdxList)
    if i~=idx
        I1(I3.PixelIdxList{i})=0;
    end
end

% find base width
P2=find(I1);
Lcor=min(P2);
Lside(1)=Lcor;
Rcor=max(P2);
Rside(1)=Rcor;
Ccor=width(1);
BaseWidth=Ccor;

% measure average width over some 100 pixels interval
pix=100; % play with this no of pixels
count=round(length(width)/pix,0);
for j=1:count-1
    s=(j-1)*pix+1;
    avgwidth(j)=mean(width(s:s+pix))-Ccor;    
    if avgwidth(j)<0
        avgwidth(j)=nan;
    end    
    avgwidthN(j)=mean(width(s:s+pix));
    
    avgRside(j)=mean(Rside(s:s+pix))-Rcor;
    if avgRside(j)<0
        avgRside(j)=nan;
    end
    avgLside(j)=Lcor-mean(Lside(s:s+pix));
    if avgLside(j)<0
        avgLside(j)=nan;
    end
end

% Calculate slope as angles
stp=3;
avgLsideS=[0 avgLside(1,stp:end)];
avgRsideS=[0 avgRside(1,stp:end)];
avgwidthS=[0 avgwidth(1,stp:end)];
avgwidthNS=avgwidthN;
Xpool=[0 stp*pix:pix:(count-1)*pix];
for j=2:count-1
    X1=1:pix:j*pix;
    YNC=avgwidthNS(1:j);
    cumfitslopeN(j)=YNC'\X1';
end
for j=2:count-1-stp
    X=Xpool(1,1:j);
    YL=avgLsideS(1:j);
    YR=avgRsideS(1:j);
    YC=avgwidthS(1:j);
    cumfitslope(j)=YC'\X';   
    Lfitslope(j)=YL'\X';
    Rfitslope(j)=YR'\X';
end

% YNC is the vector containing the non-centered average width values over the same intervals (avgwidthNS). 
% This means that the values are not adjusted by subtracting the mean (Ccor in this case) before being included in the vector. 
% YNC is used in a separate linear regression calculation to estimate the slope of the trend in the average width without centering.

% YC is the vector containing the average width values over specific 100-pixel intervals (avgwidthS). 
% These intervals are calculated from the root image, and YC is used in linear regression to 
% estimate the slope of the trend in the average width over depth.

% YL is the vector containing the average values of the left side of the root (avgLsideS). 
% These values are calculated over specific 100-pixel intervals.
%  The vector YL is then used in linear regression to estimate the slope of the trend in the left side values over depth.

% YR is the vector containing the average values of the right side of the root (avgRsideS). 
% Similar to YL, these values are calculated over specific 100-pixel intervals. 
% The vector YR is used in a separate linear regression calculation to
%  estimate the slope of the trend in the right side values over depth

CS=atand(cumfitslope); LS=atand(Lfitslope);RS=atand(Rfitslope); CNS=atand(cumfitslopeN);

CSm=nanmean(CS(3:end));
CNSm=nanmean(CNS(3:end));
LSm=-nanmean(LS(3:end));
RSm=90-nanmean(RS(3:end));

% plot angles
h =figure;
set(h, 'Visible', 'off');
imshow(TSrootimage);hold on;
plot(Rcor,1,'go','MarkerSize', 10); hold on;
plot(Lcor,1,'go','MarkerSize', 10); hold on;

X=1:pix:10*pix;
y_est = X'*tand(90-RSm);
plot(X+Rcor, y_est', 'g','LineWidth', 2)
hold on
y_est = X'*tand(-LSm);
plot(Lcor-X, y_est', 'g','LineWidth', 2)
%fname2 =strcat(fname(:,end-4),'.jpg');
fname2 =  strrep(fname,'JPG','jpg');
saveas(h,fullfile(figsavefolder,fname2));
end



