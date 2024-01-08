function [TrimmedRoot,TrimmedBlurRoot] = DigitalTrimmer( Root )
%% Trims abberant root segments
% Input Arguments
    % Root : binary root image
% Output Arguments
    % TrimmedRoot : Trimmed Root
    % TrimmedBlurRoot : Trimmed Blured Root
% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
% Root =im2bw(Root);
Iblur2 = imgaussfilt(double(Root),100);
% binarized blob image 
TrimmedBlurRoot=im2bw(Iblur2,0.25);
% use binary blob image as mask on original bw image
Rootbw=Root;Rootbw(~TrimmedBlurRoot)=0;
% get biggest components
TrimmedRoot = bwareafilt(Rootbw, 1, 'Largest');
end

