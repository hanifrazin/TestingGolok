function varargout = KlasifikasiGolok(varargin)
% KLASIFIKASIGOLOK MATLAB code for KlasifikasiGolok.fig
%      KLASIFIKASIGOLOK, by itself, creates a new KLASIFIKASIGOLOK or raises the existing
%      singleton*.
%
%      H = KLASIFIKASIGOLOK returns the handle to a new KLASIFIKASIGOLOK or the handle to
%      the existing singleton*.
%
%      KLASIFIKASIGOLOK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KLASIFIKASIGOLOK.M with the given input arguments.
%
%      KLASIFIKASIGOLOK('Property','Value',...) creates a new KLASIFIKASIGOLOK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KlasifikasiGolok_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KlasifikasiGolok_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KlasifikasiGolok

% Last Modified by GUIDE v2.5 12-Jul-2018 22:49:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KlasifikasiGolok_OpeningFcn, ...
                   'gui_OutputFcn',  @KlasifikasiGolok_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before KlasifikasiGolok is made visible.
function KlasifikasiGolok_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KlasifikasiGolok (see VARARGIN)

% Choose default command line output for KlasifikasiGolok
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
arrayfun(@cla,findall(0,'type','axes'))
setappdata(0,'datacontainer',hObject);
movegui(hObject,'onscreen')% To display application onscreen
movegui(hObject,'center')  % To display application in the center of screen
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes5)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.uitable3,'Data',[])
set(handles.uitable5,'Data',[])
set(handles.edit_Name,'String',[])
set(handles.edit_Hasil,'String',[])
clear all
clc

% UIWAIT makes KlasifikasiGolok wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KlasifikasiGolok_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_Name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Name as text
%        str2double(get(hObject,'String')) returns contents of edit_Name as a double


% --- Executes during object creation, after setting all properties.
function edit_Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Hasil_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Hasil as text
%        str2double(get(hObject,'String')) returns contents of edit_Hasil as a double

% --- Executes during object creation, after setting all properties.
function edit_Hasil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Hasil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btnBuka_Citra.
function btnBuka_Citra_Callback(hObject, eventdata, handles)
StartDir = 'data uji';
[filename, pathname] = uigetfile({'*.jpeg;*.jpg','File Citra (*.jpeg,*.jpg)';
                        '*.jpg','File jpeg (*.jpg)';
                        '*.*','Semua File (*.*)'},...
                        'Buka File Citra Asli',StartDir);

if ~isequal(filename,0)
    Img = imread(fullfile(pathname,filename));
    handles.RGB_Img = Img;
    axes(handles.axes1);
    imshow(handles.RGB_Img),title('Citra RGB',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    set(handles.edit_Name,'String',filename); 
    guidata(hObject,handles);
    mydatacontainer = getappdata(0,'datacontainer');
    setappdata(mydatacontainer,'gambaroriginal',handles.RGB_Img);
else
    return;
end

% --- Executes on button press in btnGray.
function btnGray_Callback(hObject, eventdata, handles)
if isempty(get(handles.axes1,'Children'))
    H = 'Silahkan input gambar terlebih dahulu';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    handles.RGB_Img = getappdata(mydatacontainer,'gambaroriginal');
    
    % Konversi RGB ke Grayscale
    Gray = rgb2gray(handles.RGB_Img);
    
    axes(handles.axes2);
    imshow(Gray),title('Citra Grayscale',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    
    axes(handles.axes3);
    imhist(Gray);ylim([0,200]);xlim([0,255]);
   
    setappdata(mydatacontainer,'preprocessing',Gray);
end

% --- Executes on button press in btnPreProcess.
function btnPreProcess_Callback(hObject, eventdata, handles)
if isempty(get(handles.axes2,'Children'))
    H = 'Maaf gambar belum diconvert menjadi Grayscale';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    Gray = getappdata(mydatacontainer,'preprocessing');
    
    % Meningkatkan kontras dengan Contrast Stretching
    Constretch = imadjust(Gray,stretchlim(Gray),[]);
    
    axes(handles.axes2);
    imshow(Constretch),title('Perbaikan Citra',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    axes(handles.axes3);
    imhist(Constretch);ylim([0,200]);xlim([0,255]);
    
    % Menghaluskan Citra
    fmed3x3 = ordfilt2(Constretch,5,ones(3,3));
    
    setappdata(mydatacontainer,'Smooth',fmed3x3);
end

% --- Executes on button press in btnCrop.
function btnCrop_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
FiltMed3x3 = getappdata(mydatacontainer,'Smooth');
if isempty(FiltMed3x3)
    H = 'Maaf gambar belum di preprocessing';
    msgbox(H,'Warning','warn');
else
     % Crop Citra (Memotong Citra)
    Crop = imcrop(FiltMed3x3,[105.5 9.5 193 106]);
    
    % Merubah ukuran crop citra ke ukuran 75x150 pixel
    Resize = imresize(Crop,[75 150]); 
    axes(handles.axes4);
    imshow(Resize),title('Crop Citra',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    
    setappdata(mydatacontainer,'resize_img',Resize);
end

% --- Executes on button press in btnBiner.
function btnBiner_Callback(hObject, eventdata, handles)
if isempty(get(handles.axes4,'Children'))
    H = 'Maaf gambar belum di crop';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    Resize = getappdata(mydatacontainer,'resize_img');
    
    %% Segmentasi
    Biner = imbinarize(Resize,0.8);
    Invers = imcomplement(Biner);
    axes(handles.axes5);
    imshow(Invers),title('Citra Biner',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    setappdata(mydatacontainer,'invers_biner',Invers);
end

% --- Executes on button press in btnMorphologi.
function btnMorphologi_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Invers = getappdata(mydatacontainer,'invers_biner');
if isempty(Invers)
    H = 'Maaf gambar belum di segmentasi';
    msgbox(H,'Warning','warn');
else
    %% Operasi Morfologi
    Opening = bwmorph(Invers,'open');
    Closing = bwmorph(Opening,'close');
    axes(handles.axes5);
    imshow(Closing),title('Morfologi',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    setappdata(mydatacontainer,'morphologi',Closing);
end

% --- Executes on button press in btnEkstraksi.
function btnEkstraksi_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Closing = getappdata(mydatacontainer,'morphologi');
if isempty(Closing)
    H = 'Maaf gambar belum di morfologi';
    msgbox(H,'Warning','warn');
else
    % Ekstraksi Bentuk
    ekstraksi = regionprops(Closing,'all');
    area = ekstraksi.Area;
    perimeter = ekstraksi.Perimeter;
    minor_axis = ekstraksi.MinorAxisLength;
    mayor_axis = ekstraksi.MajorAxisLength;
    compactness = (perimeter^2)/area;
    roundness = (4*pi*area)/(perimeter^2);    
    rectangularity = area/(mayor_axis*minor_axis);
    elongation = 1 - (minor_axis/mayor_axis);
    Data_Uji = [roundness compactness rectangularity elongation]
    
    ciri_bentuk = cell(8,2);
    ciri_bentuk{1,1} = 'Area';
    ciri_bentuk{2,1} = 'Perimeter';
    ciri_bentuk{3,1} = 'Major Axis Length';
    ciri_bentuk{4,1} = 'Minor Axis Length';
    ciri_bentuk{5,1} = 'Compactness';
    ciri_bentuk{6,1} = 'Roundness';
    ciri_bentuk{7,1} = 'Rectangularity';
    ciri_bentuk{8,1} = 'Elongation';
    ciri_bentuk{1,2} = num2str(area);
    ciri_bentuk{2,2} = num2str(perimeter);
    ciri_bentuk{3,2} = num2str(mayor_axis);
    ciri_bentuk{4,2} = num2str(minor_axis);
    ciri_bentuk{5,2} = num2str(roundness);
    ciri_bentuk{6,2} = num2str(compactness);
    ciri_bentuk{7,2} = num2str(rectangularity);
    ciri_bentuk{8,2} = num2str(elongation);
    
    row_cell = cell(8,1);
    for i = 1:8
        row_cell{i} = num2str(i);
    end

    set(handles.uitable3,'Data',ciri_bentuk,'RowName',row_cell),
    setappdata(mydatacontainer,'data_testing',Data_Uji);
end


% --- Executes on button press in btnKlasifikasi.
function btnKlasifikasi_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Data_Uji = getappdata(mydatacontainer,'data_testing');
if isempty(Data_Uji)
    H = 'Maaf data ekstraksi ciri masih kosong';
    msgbox(H,'Warning','warn');
else
    hasil = 'test';
    load('BayesGolok.mat')
    [PrediksiBayes,Posterior] = predict(BayesModel,Data_Uji);
    
    Posterior_trans = transpose(Posterior);
    val_posterior = cell(1,3);
    val_posterior{1,1} = Posterior_trans(1);
    val_posterior{1,2} = Posterior_trans(2);
    val_posterior{1,3} = Posterior_trans(3);
    set(handles.uitable5,'Data',val_posterior),
    
    if isequal(Posterior(1,1),max(Posterior))
        hasil = 'Gablogan';
    elseif isequal(Posterior(1,2),max(Posterior))
        hasil = 'Sembelih';
    elseif isequal(Posterior(1,3),max(Posterior))
        hasil = 'Sorenan';
    end
    set(handles.edit_Hasil,'String',hasil)
end

% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
appdata = get(0,'ApplicationData')
fns = fieldnames(appdata);
for ii = 1:numel(fns)
  rmappdata(0,fns{ii});
end
arrayfun(@cla,findall(0,'type','axes'))
setappdata(0,'datacontainer',hObject);
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes5)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.uitable3,'Data',[])
set(handles.uitable5,'Data',[])
set(handles.edit_Name,'String',[])
set(handles.edit_Hasil,'String',[])
clear all
clc

% --- Executes on button press in btnKeluar.
function btnKeluar_Callback(hObject, eventdata, handles)
