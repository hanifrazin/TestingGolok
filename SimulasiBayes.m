function varargout = SimulasiBayes(varargin)
% SIMULASIBAYES MATLAB code for SimulasiBayes.fig
%      SIMULASIBAYES, by itself, creates a new SIMULASIBAYES or raises the existing
%      singleton*.
%
%      H = SIMULASIBAYES returns the handle to a new SIMULASIBAYES or the handle to
%      the existing singleton*.
%
%      SIMULASIBAYES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULASIBAYES.M with the given input arguments.
%
%      SIMULASIBAYES('Property','Value',...) creates a new SIMULASIBAYES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulasiBayes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulasiBayes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulasiBayes

% Last Modified by GUIDE v2.5 11-Jul-2018 20:50:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulasiBayes_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulasiBayes_OutputFcn, ...
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


% --- Executes just before SimulasiBayes is made visible.
function SimulasiBayes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulasiBayes (see VARARGIN)

% Choose default command line output for SimulasiBayes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
arrayfun(@cla,findall(0,'type','axes'))
setappdata(0,'datacontainer',hObject);
movegui(hObject,'onscreen')% To display application onscreen
movegui(hObject,'center')  % To display application in the center of screen
% UIWAIT makes SimulasiBayes wait for user response (see UIRESUME)
% uiwait(handles.figure1);

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
axes(handles.axes6)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.uitable1,'Data',[])
set(handles.edit2,'String',[])
set(handles.edit3,'String',[])
clear all
clc

% --- Outputs from this function are returned to the command line.
function varargout = SimulasiBayes_OutputFcn(hObject, eventdata, handles) 
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
StartDirectory2 = 'data uji';
[filename, pathname] = uigetfile({'*.jpeg;*.jpg','File Citra (*.jpeg,*.jpg)';
                        '*.jpg','File jpeg (*.jpg)';
                        '*.*','Semua File (*.*)'},...
                        'Buka File Citra Asli',StartDirectory2);

if ~isequal(filename,0)
    set(handles.edit3,'String',filename);
    I = imread(fullfile(pathname,filename));
    handles.data1 = I;
    axes(handles.axes1);
    imshow(handles.data1);     
    guidata(hObject,handles);
    mydatacontainer = getappdata(0,'datacontainer');
    setappdata(mydatacontainer,'gambaroriginal',handles.data1);
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Img = getappdata(mydatacontainer,'gambaroriginal');
Gray = rgb2gray(Img);
Contrast = imadjust(Gray,stretchlim(Gray),[]);
MedImg = medfilt2(Contrast);
axes(handles.axes2);
imshow(MedImg),title('Citra Grayscale',...
    'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
setappdata(mydatacontainer,'MedianFilter',MedImg);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
MedImg = getappdata(mydatacontainer,'MedianFilter');
Crop = imcrop(MedImg,[105.5 9.5 193 106]);
Resize = imresize(Crop,[75 150]); 
axes(handles.axes3);
imshow(Resize),title('Crop Citra',...
    'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
setappdata(mydatacontainer,'resize',Resize);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Resize = getappdata(mydatacontainer,'resize');
Biner = imbinarize(Resize,0.8);
Invers = not(Biner);
axes(handles.axes4);
imshow(Invers),title('Citra Biner',...
    'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
setappdata(mydatacontainer,'invers',Invers);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mydatacontainer = getappdata(0,'datacontainer');
Invers = getappdata(mydatacontainer,'invers');
Closing = bwmorph(Invers,'close');
Opening = bwmorph(Closing,'open');
axes(handles.axes6);
imshow(Opening),title('Citra Morfologi',...
    'FontName','Maiandra GD','FontSize',12,'FontWeight','bold');
setappdata(mydatacontainer,'morfologi',Opening);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Opening = getappdata(mydatacontainer,'morfologi');
Stats = regionprops(Opening,'BoundingBox','MajorAxisLength','MinorAxisLength','Centroid','Orientation');
Box = Stats.BoundingBox;
Panjang = Box(3);
Lebar = Box(4);
Center = Stats.Centroid;
Orientasi = Stats.Orientation;
Major_Axis = Stats.MajorAxisLength;
Minor_Axis = Stats.MinorAxisLength;
Slimness = Panjang/Lebar;
Elongation = 1-(Minor_Axis/Major_Axis);
Data_Uji = [Slimness Elongation];

ciri_bentuk = cell(2,2);
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

set(handles.uitable1,'Data',ciri_bentuk,'RowName',row_cell)
setappdata(mydatacontainer,'datauji',Data_Uji);
setappdata(mydatacontainer,'boundingbox',Box);
setappdata(mydatacontainer,'majoraxis',Major_Axis);
setappdata(mydatacontainer,'minoraxis',Minor_Axis);
setappdata(mydatacontainer,'centroid',Center);
setappdata(mydatacontainer,'orientation',Orientasi);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
mydatacontainer = getappdata(0,'datacontainer');
Data_Uji = getappdata(mydatacontainer,'datauji');

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
set(handles.edit2,'String',hasil)

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton14_Callback(hObject, eventdata, handles)
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
axes(handles.axes6)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.uitable1,'Data',[])
set(handles.edit2,'String',[])
set(handles.edit3,'String',[])


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
