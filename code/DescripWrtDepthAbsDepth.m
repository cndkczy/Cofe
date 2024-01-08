function [ DepthAdj] = DescripWrtDepthAbsDepth(Rootimage,PixtoCm,figsavefolder,fname)
%% Calculates adjusted root depth based on density
% Input Arguments
    % Rootimage : binary image 
    % PixtoCm : conversion scale
    % figsavefolder : folder to save output related to depth adjustment
    % fname : file to save the output
% Output Arguments
    % DepthAdj : adjusted root depth as a function of root density

% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
% measure depth of the root
PDepth = MeasureDepth(Rootimage);

% measure maxwidth and root density as a function depth
[Awidth, Rownonzero] = RootWidthNonzero(Rootimage, PDepth);

% maximum and median width
MaxWidth = max(Awidth);

% absolute location of maximum width
LofMaxWidthP = mean(find(round(Awidth) == round(MaxWidth)));

% Normalized Root nonzero values with MaxWidth
RownonzeroNorm = Rownonzero / MaxWidth;

% find location where Normalized (Root nonzero values with MaxWidth) value
% is 80% to 10% with 10% interval
NormDensityofInterest = linspace(0.1, 0.8, 8);
DepthAdj = zeros(8, 1);

for i = 1:8
    DepthIndex = find(RownonzeroNorm > NormDensityofInterest(i));

    % Check if DepthIndex is not empty before further processing
    if ~isempty(DepthIndex)
        DepthIndexD = find(DepthIndex > LofMaxWidthP);

        % Check if DepthIndexD is not empty before further processing
        if ~isempty(DepthIndexD)
            DepthIndexD2 = max(DepthIndex(DepthIndexD));
            DepthAdj(i) = DepthIndexD2;
        end
    end
end

DepthAdj(DepthAdj==0)=nan;
DepthAdj=DepthAdj/PixtoCm;

% visualization for checking
h = figure;
set(h, 'Visible', 'off');
% do ur plotting here
subplot(2,2,[1,3]);imshow(Rootimage);hold on; hline=refline([0 LofMaxWidthP]);
hline.Color='r';
for i=1:8
    hline=refline([0 DepthAdj(i)]);
end
% subplot(2,2,[2,4]);plot(RownonzeroNorm); title('Nonzero Pixel Normalized By Maxwidth');
subplot(2,2,[2,4]);plot(NormDensityofInterest,DepthAdj);ylabel('Adjusted Root Depth (pixel)'),xlabel('Cutoff density');
sgtitle('Adjusted Root Depth based on Different Cutoff Values');

set(gca, 'YDir','reverse')
%fname2 =strcat(fname(:,end-4),'.jpg');
fname2 =  strrep(fname,'JPG','jpg');
saveas(h,fullfile(figsavefolder,fname2));
end

