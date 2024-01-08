function COFE
% COFE : Core rOot Feature Extraction
% Software developed to analyse crop plant's excavated mature root

% Developers : Zaki Jubery
% Copyright : Baskar Ganapathysubramanian
% Version 1 : January 14, 2018 by Zaki Jubery
% Version 2: April 4, 2020 by Zaki Jubery
%%
addpath('code')
% Define display window size
a=300;b=300;c=1100;d=700;
warning('off','all');

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[a,b,c,d],'Toolbar', 'none');
tabgroup = uitabgroup('Parent', f);
set(gcf, 'Position', get(0, 'Screensize'));
startTab = uitab('Parent', tabgroup, 'Title', 'Software Info');
tab1 = uitab('Parent', tabgroup, 'Title', 'Image Pre-Processing');
tab3 = uitab('Parent', tabgroup, 'Title', 'Trait Extraction');

%Initial tab
cofeinfoPanel = uipanel('Parent', startTab,...
    'BackgroundColor', [.93, .84, .84],...
    'ShadowColor', [1, 0, 0, 1],...
    'Units', 'normalized',...
    'Position', [0.2, 0.5, 0.6, 0.4]);

uicontrol('Parent', cofeinfoPanel,...
    'FontName', 'MS Sans Serif',...
    'Style', 'text',...
    'FontSize', 24,...
    'Units', 'normalized',...
    'Position', [0.12, 0.7, 0.75, 0.2],...
    'String', 'COFE : Core rOot Feature Extraction');

infoString = sprintf('Software developed by Ganapathysubramanian group (ISU)\nLead developer: Zaki Jubery \nTesting: Zihao Zhang \nGUI : Zaki Jubery');

uicontrol('Parent', cofeinfoPanel,...
    'Units', 'normalized',...
    'Position', [0.02, 0.075, 0.8, 0.45],...
    'BackgroundColor', cofeinfoPanel.BackgroundColor,...
    'Style', 'text',...
    'String', infoString,...
    'FontSize', 14,...
    'HorizontalAlignment', 'left');

uicontrol('Parent', startTab,...
    'Units', 'normalized',...
    'Position', [0.1, 0.3, 0.3, 0.1],...
    'BackgroundColor', cofeinfoPanel.BackgroundColor,...
    'Style', 'pushbutton',...
    'String', 'Image Pre-Processing',...
    'FontSize', 16,...
    'Callback', @Image2SegClick);

uicontrol('Parent', startTab,...
    'Units', 'normalized',...
    'Position', [0.6, 0.3, 0.3, 0.1],...
    'Style', 'pushbutton',...
    'String', 'Trait Extraction',...
    'FontSize', 16,...
    'Callback', @Seg2DataExtractClick);


    function Image2SegClick(~, ~)
        tabgroup.SelectedTab = tab1;
    end

    function Seg2DataExtractClick(~, ~)
        tabgroup.SelectedTab = tab3;
    end

% Assign the a name to appear in the window title.
f.Name = 'COFE';
% Move the window to the center of the screen.
movegui(f,'center')
% Make the window visible.
f.Visible = 'on';
% Remove number title
f.NumberTitle = 'off';
% Hide menu bar
f.MenuBar = 'none';
%% Construct GUI  components.
% Image Processing (tab1)
uicontrol('Parent', tab1,'Style','pushbutton',...
    'String','Image location','Units', 'normalized','Position',[0.05,0.85,0.15,0.03],...
    'FontSize', 12,...
    'Callback',@datalocationbutton_Callback);
uicontrol('Parent', tab1,'Style','text','String','Rotate Image?',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.05,0.80,0.15,0.03]);
uicontrol('Parent', tab1,'Style','popupmenu',...
    'FontSize', 12,...
    'String',{'No ','Yes'},...
    'Units', 'normalized','Position',[0.05,0.77,0.15,0.03],...
    'Callback',@popup_menu1_Callback);

uicontrol('Parent', tab1,'Style','text','String','Select OS',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.05,0.70,0.15,0.03]);
uicontrol('Parent', tab1,'Style','popupmenu',...
    'FontSize', 12,...
    'String',{'Windows','Mac'},...
    'Units', 'normalized','Position',[0.05,0.67,0.15,0.03],...
    'Callback',@popup_menu2_Callback);

uicontrol('Parent', tab1,'Style','popupmenu',...
    'FontSize', 12,...
    'String',{'Auto','Manual'},...
    'Units', 'normalized','Position',[0.05,0.60,0.15,0.03],...
    'Callback',@popup_menu3_Callback);

uicontrol('Parent', tab1,'Style','pushbutton',...
    'String','Output location','Units', 'normalized','Position',[0.05,0.50,0.15,0.03],...
    'FontSize', 12,...
    'Callback',@outputmainbutton_Callback);

uicontrol('Parent', tab1,'Style','pushbutton',...
    'String','Start','Units', 'normalized','Position',[0.05,0.40,0.15,0.03],...
    'FontSize', 12,...
    'Callback',@surfbutton_Callback);

% Data Extraction (tab3)
uicontrol('Parent', tab3,'Style','pushbutton',...
    'FontSize', 12,...
    'String','Cropped image location','Units', 'normalized','Position',[0.3,0.80,0.40,0.03],...
    'Callback',@t3datalocationbutton_Callback);
uicontrol('Parent', tab3,'Style','pushbutton',...
    'FontSize', 12,...
    'String','Annotation file','Units', 'normalized','Position',[0.3,0.75,0.40,0.03],...
    'Callback',@t3annotationbutton_Callback);
uicontrol('Parent', tab3,'Style','text','String','Rep Number',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.70,0.40,0.03]);
uicontrol('Parent', tab3,'Style','popupmenu',...
    'FontSize', 12,...
    'String',{'Rep1','Rep2','Rep3'},...
    'Units', 'normalized','Position',[0.3,0.67,0.40,0.03],...
    'Callback',@t3popup_menu_Callback);

uicontrol('Parent', tab3,'Style','text','String','Thresholding value',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.60,0.40,0.03]);
uicontrol('Parent', tab3,'Style','edit','String','0.32',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.57,0.40,0.03],'Callback',@ulimbutton_Callback);

uicontrol('Parent', tab3,'Style','text','String','Pix2cm',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.50,0.40,0.03]);
uicontrol('Parent', tab3,'Style','edit','String','25',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.47,0.40,0.03],'Callback',@pix2cmbutton_Callback);

uicontrol('Parent', tab3,'Style','text','String','Number of processors',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.40,0.40,0.03]);
uicontrol('Parent', tab3,'Style','edit','String','2',...
    'FontSize', 12,...
    'Units', 'normalized','Position',[0.3,0.37,0.40,0.03],'Callback',@nop_Callback);

uicontrol('Parent', tab3,'Style','pushbutton',...
    'FontSize', 12,...
    'String','Output location','Units', 'normalized','Position',[0.3,0.30,0.40,0.03],...
    'Callback',@outputmainbutton_Callback);

uicontrol('Parent', tab3,'Style','pushbutton',...
    'FontSize', 12,...
    'String','Start','Units', 'normalized','Position',[0.3,0.20,0.40,0.03],...
    'Callback',@surfbutton3_Callback);

axes('Parent', tab1,'Units', 'normalized','Position',[0.22,0.25,0.75,0.73]);
peaks_data = peaks(35);
current_data = peaks_data;
surf(current_data);

% axes('Parent',tab3,'Units', 'normalized','Position',[0.3,0.2,0.65,0.75]);
% peaks_data = peaks(35);
% current_data = peaks_data;
% surf(current_data);

%% GUI supporting functions


    function popup_menu3_Callback(source,~)
        str = get(source, 'String');
        val = get(source,'Value');
        switch str{val}
            case 'Auto'
                crop_image=0;
            case 'Manual'
                crop_image=1;
        end
    end

    function popup_menu2_Callback(source,~)
        str = get(source, 'String');
        val = get(source,'Value');
        switch str{val}
            case 'Mac'
                slash='/';
            case 'Windows'
                slash='\';
        end
    end

    function popup_menu1_Callback(source,~)
        str = get(source, 'String');
        val = get(source,'Value');
        switch str{val}
            case 'No'
                rotate_image='0';
            case 'Yes'
                rotate_image='1';
        end
    end

    function datalocationbutton_Callback(~,~)
        datasource = uigetdir();
    end

    function t3datalocationbutton_Callback(~,~)
        segimagedata = uigetdir();
    end

    function t3annotationbutton_Callback(~,~)
        [annotation,anotpath]=uigetfile('*.xlsx');
    end

    function t3popup_menu_Callback(source,~)
        str = get(source, 'String');
        val = get(source,'Value');
        switch str{val}
            case 'Rep1'
                repdata='rep1';
            case 'Rep2'
                repdata='rep2';
            case 'Rep3'
                repdata='rep3';
        end
    end

    function ulimbutton_Callback(source,~)
        ulim1=get(source,'String');
    end

    function pix2cmbutton_Callback(source,~)
        pix2cm=get(source,'String');
    end

    function nop_Callback(source,~)
        nop=get(source,'String');
    end


    function outputmainbutton_Callback(~,~)
        OutputMain = uigetdir();
    end
%% Default GUI inputs
% Image Pre-Processing
OutputMain='data2test2\sampleoutput';
datasource='data2test2\sampleinput\sample_photo_jpeg';
slash='/';
% Trait Extraction
segimagedata='data2test2\sampleoutput\croppedimages';
%annotation='sample_annotation.xlsx';
annotation='filtered_output_annotation2.xlsx';
anotpath='data2test2\sampleinput';
repdata='rep1';
nop='2';
pix2cm = '86';
ulim1='0.32';
rotate_image = 0;
crop_image = 0;
%% Hard coded 
threshold_method = 0;
%% Image Pre-Processing function
    function surfbutton_Callback(~,~)
        warning('off','all');
        outputFolderI=OutputMain;        
        logfilename = ['log_RTC_', strrep(datestr(clock), ':' , '-' ) ,'.txt'] ;
        logfilename2=strcat(outputFolderI,slash,logfilename);
        diary(logfilename2)
        
         if isstr(rotate_image)==1
            rotate_image=str2num(rotate_image);
         end
        
        % Preparing output folder
        outputFolderb=strcat(outputFolderI,slash,'croppedimages');
        mkdir(outputFolderb)
        
        %loading images
        fileList=dir(datasource);
        nooffile=size(fileList);
        % expected types of extensions
        imagetypelist= {'.jpg','.JPG','.JPEG','.tif','.png','.RAW','.jpeg'};
        
        for K = 1: nooffile(1)
            
            if endsWith(fileList(K).name,imagetypelist)
                Im=imread(strcat(fileList(K).folder,slash,fileList(K).name));
                
                 % Rotate the image if it is needed
                if rotate_image ==1                   
                        Im=imrotate(Im,-90);
                end              
       
                imshow(Im);
                if crop_image==1
                    title('Click on the soil line','FontSize',9);
                    [~, slocy] = ginput(1);
                    TSrootimage=Im(slocy(1):end,:,:);                    
                elseif crop_image==0
                        [~,TSrootimage] = Redline_createMask(Im);                    
                end
                imwrite(TSrootimage,strcat(outputFolderb,slash,fileList(K).name));
            end
            
        end
        msgbox({'Image Cropping' 'Completed'});
    end

%% Trait Extraction Function
    function surfbutton3_Callback(~,~)
        warning('off','all');
        tic
        annotfile=strcat(anotpath,slash,annotation)
        rep=repdata;
        InputFolder1=segimagedata;
        Outputfolder3=OutputMain;
 
        % Output location for segmented images
        outputFoldera=strcat(Outputfolder3,slash,'segmentedimages');
        mkdir(outputFoldera)
        % Output location for autotrimmed images
        outputFolderb=strcat(Outputfolder3,slash,'trimmedimages');
        mkdir(outputFolderb)
        %Output location for autotrimmed images
        outputFolderc=strcat(Outputfolder3,slash,'adjusted_depth_figs');
        mkdir(outputFolderc)
        %Output location for angles
        outputFolderd=strcat(Outputfolder3,slash,'angles_figs');
        mkdir(outputFolderd)
        
        extractTrait=strcat(rep,'_','ExtractedData');
        logfilename = ['log_TriatExt', strrep(datestr(clock), ':' , '-' ) ,'.txt'] ;
        logfilename2=strcat(Outputfolder3,slash,logfilename)
        diary(logfilename2)
        if isstr(nop)==1
            nop=str2num(nop);
        end
        
        if isstr(pix2cm)==1
            pix2cm=str2num(pix2cm);
        end
        
        if isstr(ulim1)==1
            ulim1=str2num(ulim1);
        end
        
        % Import the data
        [~, ~, raw0] = xlsread(annotfile,rep);

       
        % Find rows containing at least one NaN value
        rowsWithNaN = any(cellfun(@(x) any(isnan(x)), raw0), 2);
        
        % Keep only rows without NaN values
        raw = raw0(~rowsWithNaN, :);

        raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
        cellVectors = raw(:,[1,2,3,4]);
        raw
        % Create table
        photoidlist = table;
        
        % Allocate imported array to column variable names
        photoidlist.plantid = cellVectors(2:end,1);
        photoidlist.genotype = cellVectors(2:end,2);
        photoidlist.photo1 = cellVectors(2:end,3);
        photoidlist.photo2 = cellVectors(2:end,4);
        photoidlist
        
        % Clear temporary variables
        clearvars data raw cellVectors;
        fileList=dir(InputFolder1);
        nit=size(fileList);
        p=1;
        
        % expected types of extensions
        imagetypelist= {'.jpg','.JPG','.JPEG','.tif','.png','.RAW','.jpeg'};
        
        % Number of lines in the excel sheet
        imagecount=height(photoidlist)+1
       
        % Prepare message box to show the progress
        t = datetime('now');
        DateString = datestr(t);
        mh=msgbox({'Please Wait ...'; strcat('Total number of image set is ...',num2str(imagecount-1));'Estimated processing time per set is between 2 to 4 mintues'; strcat('Expected completion time is between ...', num2str(2*(imagecount-1)/nop),'  to  ', num2str(4*(imagecount-1)/nop),'  mintues'); strcat('Processing started at ... ', DateString)} );
        th = findall(mh, 'Type', 'Text');
        th.FontSize = 12;
        deltaWidth = sum(th.Extent([1,3]))-mh.Position(3) + th.Extent(1);
        deltaHeight = sum(th.Extent([2,4]))-mh.Position(4) + 10;
        mh.Position([3,4]) = mh.Position([3,4]) + [deltaWidth, deltaHeight];
        mh.Resize = 'on';
        pause(0.01)
        parpool('local',nop);
        nNumIterations=imagecount-1;
        strWindowTitle='Extracting Traits... Please Wait ...  ';
        nProgressStepSize=nop;
        nWidth=700;
        nHeight=75;        
        %ppm = ParforProgMon(strWindowTitle, nNumIterations, nProgressStepSize, nWidth, nHeight);
        
        parfor k=1:nNumIterations
        %for k=1:nNumIterations
            
             try
%                 filename=ATfilename{k};
%                 filename2=ATfilename2{k};
%                 Genotype=ATGenotype{k};
%                 Repinfo=ATRepinfo{k};
                
                filename=photoidlist.photo1{k};
                filename2=photoidlist.photo2{k};
                Genotype= photoidlist.genotype{k};
                Repinfo=photoidlist.plantid{k};
                
                      
                ImageTageIdN =filename
                ImageTageIdW = char(filename2)
                
                Errorcode =1;
                % read and segment image taken
                NrootimageRGB = imread(strcat(InputFolder1,slash,filename));
                WrootimageRGB = imread(strcat(InputFolder1,slash,char(filename2)));
                
                               
                Errorcode =2;
                % Segmentation from the background
                
                if threshold_method == 1
                    [Nrootimage] = segmentation_colorbased(NrootimageRGB,ulim1);
                    [Wrootimage] = segmentation_colorbased(WrootimageRGB,ulim1);
                else
                    [Nrootimage] = segmentation_colorbased_2023(NrootimageRGB);
                    [Wrootimage] = segmentation_colorbased_2023(WrootimageRGB);
                end

                imwrite(Nrootimage,strcat(outputFoldera,slash,filename));
                imwrite(Wrootimage,strcat(outputFoldera,slash,char(filename2)));               
                               
                Errorcode =3;
                NPixtoCm = pix2cm;
                WPixtoCm = pix2cm;
                % Adjust the North and West images based on the smaller depth
                [Nrootimage,Wrootimage]=AdjustDepth(Nrootimage,Wrootimage,NPixtoCm,WPixtoCm);
                
                % Digital Trimming
                [Nrootimage,~]=DigitalTrimmer(Nrootimage);
                [Wrootimage,~]=DigitalTrimmer(Wrootimage);                
                imwrite(Nrootimage,strcat(outputFolderb,slash,filename));
                imwrite(Wrootimage,strcat(outputFolderb,slash,char(filename2)));
                
                %Extract Global Descriptors
                Errorcode =4;
                %north
                [NDepth, NArea, NConArea, NSolidity,NCofMass,NRCofMass,NMedWidth,NMaxWidth,NLofMaxWidth,NRelLofMaxWidth,NDAtMaxWidthL,NDAtMaxWidthZ,NMeanWidth,NModeWidth] = GlobalDescriptor( Nrootimage,NPixtoCm );
                [NDepthAdj] = DescripWrtDepthAbsDepth(Nrootimage,NPixtoCm,outputFolderc,filename);
                %west
                [WDepth, WArea, WConArea, WSolidity,WCofMass,WRCofMass,WMedWidth,WMaxWidth,WLofMaxWidth,WRelLofMaxWidth,WDAtMaxWidthL,WDAtMaxWidthZ,WMeanWidth,WModeWidth] = GlobalDescriptor( Wrootimage,WPixtoCm );
                [WDepthAdj] = DescripWrtDepthAbsDepth(Wrootimage,WPixtoCm,outputFolderc,char(filename2));
                %geometric mean
                GmDepth=sqrt(NDepth*WDepth);
                GmArea=sqrt(NArea*WArea);
                GmConArea=sqrt( NConArea*WConArea);
                GmSolidity=sqrt( NSolidity*WSolidity);
                GmCofMass=sqrt(NCofMass*WCofMass);
                GmRCofMass=sqrt(NRCofMass*WRCofMass);
                GmMedWidth=sqrt( NMedWidth*WMedWidth);
                GmMaxWidth=sqrt(NMaxWidth*WMaxWidth);
                GmLofMaxWidth=sqrt(NLofMaxWidth*WLofMaxWidth);
                GmRelLofMaxWidth=sqrt(NRelLofMaxWidth*WRelLofMaxWidth);
                GmDAtMaxWidthL=sqrt(NDAtMaxWidthL*WDAtMaxWidthL);
                GmDAtMaxWidthZ=sqrt(NDAtMaxWidthZ*WDAtMaxWidthZ);
                
                % Mesure Angles
                Errorcode =5;
                NCa = nan;NLa = nan;NRa = nan;NPCa = nan;NBWidth = nan;
                WCa = nan;WLa = nan;WRa = nan;WPCa = nan;WBWidth = nan;
                try
                    [NCa,NLa,NRa,NPCa,NBWidth]=MeasureAngles(Nrootimage,outputFolderd,filename);
                    [WCa,WLa,WRa,WPCa,WBWidth]=MeasureAngles(Wrootimage,outputFolderd,char(filename2));
                catch
                    disp('missing angle data')
                end

                % Identify the big and small root
                if NArea>WArea
                    NSize='Big';WSize='Small';
                else
                    NSize='Small';WSize='Big';
                end
                
                %Arrange data in table
                %north
                Errorcode =6;
                A1=[{Genotype},{Repinfo},{ImageTageIdN},{NSize}, NDepth, NArea, NConArea, NSolidity,NCofMass,NRCofMass,NMedWidth,NMaxWidth,NLofMaxWidth, ...
                    NRelLofMaxWidth,NDAtMaxWidthL,NDAtMaxWidthZ,NCa,NLa,NRa,NPCa,NBWidth,NDepthAdj(1),NDepthAdj(2),NDepthAdj(3),NDepthAdj(4),NDepthAdj(5), ...
                    NDepthAdj(6),NDepthAdj(7),NDepthAdj(8),NMeanWidth,NModeWidth];
                TNglobal{k}=A1;
                %west
                A2=[{Genotype},{Repinfo},{ImageTageIdW}, {WSize},WDepth, WArea, WConArea, WSolidity,WCofMass,WRCofMass,WMedWidth,WMaxWidth,WLofMaxWidth, ...
                    WRelLofMaxWidth,WDAtMaxWidthL,WDAtMaxWidthZ,WCa,WLa,WRa,WPCa,WBWidth,WDepthAdj(1),WDepthAdj(2),WDepthAdj(3),WDepthAdj(4),WDepthAdj(5), ...
                    WDepthAdj(6),WDepthAdj(7),WDepthAdj(8),WMeanWidth,WModeWidth];
                TWglobal{k}=A2;
                %GM
                A3=[{Genotype},{Repinfo},{ImageTageIdN}, GmDepth, GmArea, GmConArea, GmSolidity,GmCofMass,GmRCofMass,GmMedWidth,GmMaxWidth, ...
                    GmLofMaxWidth,GmRelLofMaxWidth,GmDAtMaxWidthL,GmDAtMaxWidthZ];
                TGmglobal{k}=A3;
%                 ppm.increment();
                
             catch
                 parwrite2file2(Outputfolder3,ImageTageIdN,Errorcode);
             end
        end
        
        msgbox({'Writing Traits to File'});
        % save output as mat file
        fmname=strcat(Outputfolder3,slash,extractTrait,slash);
        mkdir(strcat(Outputfolder3,slash,extractTrait));
        %save (fullfile(fmname,'TraitsMAT.mat'));
        
        % prepare data to write in excel
        ATNglobal=[]; ATWglobal=[];ATGmglobal=[];
        parfor K=1:nNumIterations          
            if isempty(TNglobal{K})==0
                L1=cell2table(TNglobal{K},'VariableNames',{'Genotype' 'Repinfo' 'ImageID' 'RootID' 'NDepth' 'NArea' 'NConArea' 'NSolidity' 'NCofMass' 'NRCofMass' ...
                    'NMedWidth' 'NMaxWidth' 'NLofMaxWidth' 'NRelLofMaxWidth' 'NDAtMaxWidthL' 'NDAtMaxWidthZ' 'NWPA' 'NLa' 'NRa' 'NPWPA' 'NBWidth' 'NADepth_01' ...
                    'NADepth_02' 'NADepth_03' 'NADepth_04' 'NADepth_05' 'NADepth_06' 'NADepth_07' 'NADepth_08' 'NMeanWidth' 'NModeWidth'}) ;
                ATNglobal=[ATNglobal;L1];
                L2=cell2table(TWglobal{K},'VariableNames',{'Genotype' 'Repinfo' 'ImageID' 'RootID' 'WDepth' 'WArea' 'WConArea' 'WSolidity' 'WCofMass' 'WRCofMass' ...
                    'WMedWidth' 'WMaxWidth' 'WLofMaxWidth' 'WRelLofMaxWidth' 'WDAtMaxWidthL' 'WDAtMaxWidthZ' 'WWPA' 'WLa' 'WRa' 'WPWPA' 'WBWidth' 'WADepth_01' ...
                    'WADepth_02' 'WADepth_03' 'WADepth_04' 'WADepth_05' 'WADepth_06' 'WADepth_07' 'WADepth_08' 'WMeanWidth' 'WModeWidth'});
                ATWglobal=[ATWglobal;L2];
                L3=cell2table(TGmglobal{K},'VariableNames',{'Genotype' 'Repinfo' 'ImageID' 'GMDepth' 'GMArea' 'GMConArea' 'GMSolidity' 'GMCofMass' 'GMRCofMass' ...
                    'GMMedWidth' 'GMMaxWidth' 'GMLofMaxWidth' 'GMRelLofMaxWidth' 'GMDAtMaxWidthL' 'GMDAtMaxWidthZ' });
                ATGmglobal=[ATGmglobal;L3];
                
                parclearvars( L1,L2,L3)
                
            end
        end
        
        filename = 'GM_Global.xls';
        Nfilename = 'N_Global.xls';
        Wfilename = 'W_Global.xls';
        writetable(ATNglobal, ...
            fullfile(fmname,  Nfilename),'Sheet',1,'WriteVariableNames',true)
        writetable(ATWglobal, ...
            fullfile(fmname, Wfilename),'Sheet',1,'WriteVariableNames',true)
        writetable(ATGmglobal, ...
            fullfile(fmname, filename),'Sheet',1,'WriteVariableNames',true)
        
        close all;
        poolobj = gcp('nocreate');
        delete(poolobj);
        msgbox({'Trait extraction' 'Completed'});
    end

end
