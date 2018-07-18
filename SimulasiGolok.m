function varargout = SimulasiGolok(varargin)
% SIMULASIGOLOK MATLAB code for SimulasiGolok.fig
%      SIMULASIGOLOK, by itself, creates a new SIMULASIGOLOK or raises the existing
%      singleton*.
%
%      H = SIMULASIGOLOK returns the handle to a new SIMULASIGOLOK or the handle to
%      the existing singleton*.
%
%      SIMULASIGOLOK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULASIGOLOK.M with the given input arguments.
%
%      SIMULASIGOLOK('Property','Value',...) creates a new SIMULASIGOLOK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulasiGolok_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulasiGolok_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulasiGolok

% Last Modified by GUIDE v2.5 24-Jun-2018 21:31:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulasiGolok_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulasiGolok_OutputFcn, ...
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


% --- Executes just before SimulasiGolok is made visible.
function SimulasiGolok_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulasiGolok (see VARARGIN)

% Choose default command line output for SimulasiGolok
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
set(handles.uitable1,'Data',[])
set(handles.edit1,'String',[])
clear all
clc

% UIWAIT makes SimulasiGolok wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SimulasiGolok_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
StartDir = 'data uji';
[filename, pathname] = uigetfile({'*.jpeg;*.jpg','File Citra (*.jpeg,*.jpg)';
                        '*.jpg','File jpeg (*.jpg)';
                        '*.*','Semua File (*.*)'},...
                        'Buka File Citra Asli',StartDir);

if ~isequal(filename,0)
    Img = imread(fullfile(pathname,filename));
    handles.data1 = Img;
    axes(handles.axes1);
    imshow(handles.data1),title('Citra Asli',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
     
    guidata(hObject,handles);
    mydatacontainer = getappdata(0,'datacontainer');
    setappdata(mydatacontainer,'gambaroriginal',handles.data1);
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
set(handles.uitable1,'Data',[])
set(handles.edit1,'String',[])
clear all
clc

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.axes1,'Children'))
    H = 'Silahkan input gambar terlebih dahulu';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    handles.data1 = getappdata(mydatacontainer,'gambaroriginal');
    
    % Konversi RGB ke Grayscale
    Gray = rgb2gray(handles.data1);
    
    % Meningkatkan kontras dengan Contrast Stretching
    Contrast = imadjust(Gray,stretchlim(Gray),[]);
    
    % Menghaluskan Citra
    MedImg = medfilt2(Contrast);
    axes(handles.axes2);
    imshow(MedImg),title('Perbaikan Citra',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');

    setappdata(mydatacontainer,'preprocessing',MedImg);
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
if isempty(get(handles.axes2,'Children'))
    H = 'Silahkan gambar di processing terlebih dahulu';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    MedImg = getappdata(mydatacontainer,'preprocessing');
    
    % Crop Citra (Memotong Citra)
    Crop = imcrop(MedImg,[105.5 9.5 193 106]);
    
    % Merubah ukuran crop citra ke ukuran 75x150 pixel
    Resize = imresize(Crop,[75 150]); 
    axes(handles.axes3);
    imshow(Resize),title('Crop Citra',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    
    setappdata(mydatacontainer,'resize_img',Resize);
end
% --- Executes on button press in pushbutton7.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.axes2,'Children'))
    H = 'Maaf gambar belum di preprocessing';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    Resize = getappdata(mydatacontainer,'resize_img');
    
    %% Segmentasi
    Biner = imbinarize(Resize,0.8);
    Invers = imcomplement(Biner);
    axes(handles.axes4);
    imshow(Invers),title('Citra Biner',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    setappdata(mydatacontainer,'invers_biner',Invers);
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Invers = getappdata(mydatacontainer,'invers_biner');
if isempty(Invers)
    H = 'Maaf gambar belum di segmentasi';
    msgbox(H,'Warning','warn');
else
    %% Operasi Morfologi
    Closing = bwmorph(Invers,'close');
    Opening = bwmorph(Closing,'open');
    axes(handles.axes5);
    imshow(Opening),title('Morfologi',...
        'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
    setappdata(mydatacontainer,'opening',Opening);
end

function pushbutton10_Callback(hObject, eventdata, handles)
if isempty(get(handles.axes4,'Children'))
    H = 'Maaf gambar belum di morfologi';
    msgbox(H,'Warning','warn');
else
    mydatacontainer = getappdata(0,'datacontainer');
    Opening = getappdata(mydatacontainer,'opening');
    
    %% Ekstraksi Ciri Bentuk
    Stats = regionprops(Opening,'BoundingBox','MajorAxisLength','MinorAxisLength');
    Box = Stats.BoundingBox;
    Panjang = Box(3);
    Lebar = Box(4);
    Major_Axis = Stats.MajorAxisLength;
    Minor_Axis = Stats.MinorAxisLength;
    Slimness = Panjang/Lebar;
    Elongation = 1-(Minor_Axis/Major_Axis);
    Data_Uji = [Slimness Elongation];

    ciri_bentuk = cell(6,2);
    ciri_bentuk{1,1} = 'Panjang';
    ciri_bentuk{2,1} = 'Lebar';
    ciri_bentuk{3,1} = 'Major Axis Length';
    ciri_bentuk{4,1} = 'Minor Axis Length';
    ciri_bentuk{5,1} = 'Slimness';
    ciri_bentuk{6,1} = 'Elongation';
    ciri_bentuk{1,2} = num2str(Panjang);
    ciri_bentuk{2,2} = num2str(Lebar);
    ciri_bentuk{3,2} = num2str(Major_Axis);
    ciri_bentuk{4,2} = num2str(Minor_Axis);
    ciri_bentuk{5,2} = num2str(Slimness);
    ciri_bentuk{6,2} = num2str(Elongation);

    row_cell = cell(6,1);
    for i = 1:6
        row_cell{i} = num2str(i);
    end

    set(handles.uitable1,'Data',ciri_bentuk,'RowName',row_cell);
    setappdata(mydatacontainer,'datauji',Data_Uji);
end

function pushbutton7_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Data_Uji = getappdata(mydatacontainer,'datauji');
if isempty(Data_Uji)
    H = 'Maaf data ekstraksi ciri masih kosong';
    msgbox(H,'Warning','warn');
else
    hasil = 'test';
    load('BayesModelGolok.mat')
    PrediksiBayes = predict(BayesModel,Data_Uji);
    if isequal(PrediksiBayes,1)
        hasil = 'Gablogan';
    elseif isequal(PrediksiBayes,2)
        hasil = 'Sembelih';
    elseif isequal(PrediksiBayes,3)
        hasil = 'Sorenan';
    end
    set(handles.edit1,'String',hasil)
end
