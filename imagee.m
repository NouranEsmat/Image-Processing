function varargout = imagee(varargin)
% IMAGEE MATLAB code for imagee.fig
%      IMAGEE, by itself, creates a new IMAGEE or raises the existing
%      singleton*.
%
%      H = IMAGEE returns the handle to a new IMAGEE or the handle to
%      the existing singleton*.
%
%      IMAGEE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEE.M with the given input arguments.
%
%      IMAGEE('Property','Value',...) creates a new IMAGEE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imagee_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imagee_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imagee

% Last Modified by GUIDE v2.5 13-Dec-2019 15:40:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imagee_OpeningFcn, ...
                   'gui_OutputFcn',  @imagee_OutputFcn, ...
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


% --- Executes just before imagee is made visible.
function imagee_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imagee (see VARARGIN)

% Choose default command line output for imagee
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imagee wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imagee_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s= imread('E:\grad project\dataset\ProSRL\Set14\Set14_HR2\Set14_HR\X2\lenna.png');
I=rgb2gray(s);
ratio=4;
[h, w] = size(I);
H = (ratio * h);
W = (ratio * w);
newimage = zeros(H,W);
hs = (h/H);
ws = (w/W);
for i=1:H
    y = (hs * i) ;
    for j=1:W
        x = (ws * j) ;
      if x < 1
          x=1;
      elseif x>h-0.001
          x=h-0.001;
      end
      x1 = floor(x);
      x2 = x1 + 1;
      if y < 1
          y=1;
      elseif y>w-0.001
          y=w-0.001;
      end
          y1 = floor(y);
          y2 = y1 + 1;
      %// 4 Neighboring Pixels
          n1 = I(y1,x1);
          n2 = I(y1,x2);
          n3 = I(y2,x1); 
          n4 = I(y2,x2);
      %// 4 Pixels Weights
          w1 = (y2-y)*(x2-x);
          w2 = (y2-y)*(x-x1);
          w3 = (x2-x)*(y-y1);
          w4 = (y-y1)*(x-x1);
          newimage(i,j) = w1 * n1 + w2 * n2 + w3 * n3 + w4 * n4;
    end
end
t=uint8(newimage);
image=t;
axes(handles.axes1);
imshow(image);

%%%////histogram equalization
frq=zeros(256,1);
[rows,cols]=size(image);
for i=2:rows
    for k=2:cols
      frq(image(i,k)) = frq(image(i,k)) + 1;%%frquency for every intensity,bnshof elintensity de atkrart kam mara w bndeha frq
    end
end

for i=1:256
      frq(i) = frq(i) / (rows*cols); %%frq/m*n normalization llfrq
end
for i=2:256
      frq(i) = frq(i) + frq(i-1);    
end
for i=1:256
      frq(i) = frq(i) * 255;    %%%mapping
end
%display(image);
for i=1:rows
    for k=1:cols
      image(i,k) = frq(image(i,k)+1);
    end
end

%display(image);
y=uint8(image);
axes(handles.axes2);
imshow(y);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

image= imread('E:\grad project\dataset\ProSRL\Set14\Set14_HR2\Set14_HR\X2\lenna.png');
image=rgb2gray(image);
 
a = imnoise(image, 'salt & pepper',0.1);
axes(handles.axes1);
imshow(a);
[rows,cols]=size(a);
image=uint8(a);

newimage= zeros(255,1);
for i=2 :rows-1
    for j=2:cols-1
        tmp(1)= image(i,j);
        tmp(2)= image(i-1,j);
        tmp(3)=image(i+1,j);
        tmp(4)=image(i+1,j+1);
        tmp(5)=image(i-1,j-1);
        tmp(6)=image(i,j+1);
        tmp(7)=image(i,j-1);
        tmp(8)=image(i+1,j-1);
        tmp(9)=image(i-1,j+1);
        tmp=sort(tmp);
        newimage(i,j)=tmp(5);
    end
end
y=uint8(newimage);
axes(handles.axes2);
imshow(y);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im=imread('E:\grad project\dataset\ProSRL\Set14\Set14_HR2\Set14_HR\X2\lenna.png');
image=rgb2gray(im);
axes(handles.axes1);
imshow(image);
image=double(image);
[rows,cols]=size(image);
newimage= zeros(255,1);
for i=2 :rows-1
    for j=2:cols-1
        tmp= image(i,j)+image(i-1,j)+image(i+1,j)+image(i+1,j+1)+image(i-1,j-1)+image(i,j+1)+image(i,j-1)+image(i+1,j-1)+image(i-1,j+1);
        newimage(i,j)= tmp/9;
       
    end
end
y=uint8(newimage);
axes(handles.axes2);
imshow(y);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s= imread('E:\grad project\dataset\ProSRL\Set14\Set14_HR2\Set14_HR\X2\lenna.png');
I=rgb2gray(s);
axes(handles.axes1);
imshow(I);
ratio=4;
[h, w] = size(I);
H = (ratio * h);
W = (ratio * w);
Y = zeros(H,W);%new image dim
hs = (h/H);
ws = (w/W);
for i=1:H
    y = (hs * i) ;
    for j=1:W
        x = (ws * j) ;
        if x < 1
            x=1;
        elseif x>h-0.001
            x=h-0.001;
        end
          x1 = floor(x);
          x2 = x1 + 1;
          if y < 1
            y=1;
          elseif y>w-0.001
            y=w-0.001;
           end
          y1 = floor(y);
          y2 = y1 + 1;
      %// 4 Neighboring Pixels
          n1 = I(y1,x1);
          n2 = I(y1,x2);
          n3 = I(y2,x1); 
          n4 = I(y2,x2);
      %// 4 Pixels Weights
          w1 = (y2-y)*(x2-x);
          w2 = (y2-y)*(x-x1);
          w3 = (x2-x)*(y-y1);
          w4 = (y-y1)*(x-x1);
          Y(i,j) = w1 * n1 + w2 * n2 + w3 * n3 + w4 * n4;
    end
end
y=uint8(Y);
axes(handles.axes2);
imshow(y);
