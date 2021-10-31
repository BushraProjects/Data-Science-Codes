function varargout = ActivityG(varargin)
% ACTIVITYG MATLAB code for ActivityG.fig
%      ACTIVITYG, by itself, creates a new ACTIVITYG or raises the existing
%      singleton*.
%
%      H = ACTIVITYG returns the handle to a new ACTIVITYG or the handle to
%      the existing singleton*.
%
%      ACTIVITYG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACTIVITYG.M with the given input arguments.
%
%      ACTIVITYG('Property','Value',...) creates a new ACTIVITYG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ActivityG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ActivityG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ActivityG

% Last Modified by GUIDE v2.5 04-Dec-2019 23:47:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ActivityG_OpeningFcn, ...
                   'gui_OutputFcn',  @ActivityG_OutputFcn, ...
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


% --- Executes just before ActivityG is made visible.
function ActivityG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ActivityG (see VARARGIN)

% Choose default command line output for ActivityG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ActivityG wait for user response (see UIRESUME)
% uiwait(handles.figure1);
ages = {'1 - 10 Years', '11 - 25 Years', '26 - 40 Years', '41 - 60 Years', 'All'}
set(handles.listbox1, 'string', ages)
age = 1;
sex = 'Male'
assignin('base', 'age', age)
assignin('base', 'sex', sex)

% --- Outputs from this function are returned to the command line.
function varargout = ActivityG_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in p1.
function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.csv'}, 'Select a CSV file')

if isequal(filename,0)
    return
else
    Path = strcat(pathname,filename);
    data = readtable(Path);
    set(handles.edit1,'String', Path);
    assignin('base', 'table', data);
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
index = get (hObject, 'value')
assignin('base', 'age', index)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in p2.
function p2_Callback(hObject, eventdata, handles)
% hObject    handle to p2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

table = evalin('base', 'table')
age = evalin('base', 'age')
class = evalin('base', 'class')
sex = lower(evalin('base', 'sex'))

switch age
    case 1
        Tableage = table(find(table.age >1 & table.age <10),:);
    case 2
        Tableage = table(find(table.age >11 & table.age <25),:);
        
    case 3
        Tableage = table(find(table.age >26 & table.age <40),:);
        
    case 4
        Tableage = table(find(table.age >41 & table.age <60),:);
        
    case 5
        Tableage = table;
end

if strcmp(sex,'both')
    Table_sex = Tableage;
    classTable = Table_sex(find(Table_sex.pclass==class),:);
    
    female = classTable(any(strcmp(classTable.sex, 'female'),2),:)
    male = classTable(any(strcmp(classTable.sex, 'male'),2),:)
    
    sexes_servived = [ length(find(female.survived==1));length(find(male.survived==1))]
    axes(handles.axes1)
    bar(sexes_servived)
    set(gca, 'XTickLabel',{'Female','Male'})
    legend('Survived')
    
    
else
    Table_sex = Tableage(any(strcmp(Tableage.sex, sex),2),:)
    classTable = Table_sex(find(Table_sex.pclass==class),:);
    
    sexes_servived = [ length(find(classTable.survived==1))]
    axes(handles.axes1)
    bar(sexes_servived)
    set(gca, 'XTickLabel',{'Survived'})
    title = [sex " Survived"]
    
end


% --- Executes on button press in r4.
function r4_Callback(hObject, eventdata, handles)
% hObject    handle to r4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r4
if get(hObject, 'value')==1
    set(handles.r5, 'value',0)
    set(handles.r6, 'value',0)
end
sex ='Male';
assignin('base', 'sex', sex)

% --- Executes on button press in r5.
function r5_Callback(hObject, eventdata, handles)
% hObject    handle to r5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r5
if get(hObject, 'value')==1
    set(handles.r4, 'value',0)
    set(handles.r6, 'value',0)
end
sex ='Female';
assignin('base', 'sex', sex)

% --- Executes on button press in r6.
function r6_Callback(hObject, eventdata, handles)
% hObject    handle to r6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r6
if get(hObject, 'value')==1
    set(handles.r5, 'value',0)
    set(handles.r4, 'value',0)
end
sex ='both';
assignin('base', 'sex', sex)

% --- Executes on button press in r1.
function r1_Callback(hObject, eventdata, handles)
% hObject    handle to r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r1
if get(hObject, 'value')==1
    set(handles.r2, 'value',0)
    set(handles.r3, 'value',0)
end
class =1;
assignin('base', 'class', class)

% --- Executes on button press in r2.
function r2_Callback(hObject, eventdata, handles)
% hObject    handle to r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r2
if get(hObject, 'value')==1
    set(handles.r1, 'value',0)
    set(handles.r3, 'value',0)
end
class =2;
assignin('base', 'class', class)

% --- Executes on button press in r3.
function r3_Callback(hObject, eventdata, handles)
% hObject    handle to r3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject, 'value')==1
    set(handles.r1, 'value',0)
    set(handles.r2, 'value',0)
end
class =3;
assignin('base', 'class', class)
% Hint: get(hObject,'Value') returns toggle state of r3


% --- Executes during object creation, after setting all properties.
function r1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'value', 1)
class =1;
assignin('base', 'class', class)
