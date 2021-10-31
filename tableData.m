function varargout = tableData(varargin)
% TABLEDATA MATLAB code for tableData.fig
%      TABLEDATA, by itself, creates a new TABLEDATA or raises the existing
%      singleton*.
%
%      H = TABLEDATA returns the handle to a new TABLEDATA or the handle to
%      the existing singleton*.
%
%      TABLEDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLEDATA.M with the given input arguments.
%
%      TABLEDATA('Property','Value',...) creates a new TABLEDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tableData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tableData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tableData

% Last Modified by GUIDE v2.5 30-Nov-2019 20:13:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tableData_OpeningFcn, ...
                   'gui_OutputFcn',  @tableData_OutputFcn, ...
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


% --- Executes just before tableData is made visible.
function tableData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tableData (see VARARGIN)

% Choose default command line output for tableData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tableData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tableData_OutputFcn(hObject, eventdata, handles) 
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
Age = [22; 23; 11; 45; 66]
Height = rand(1,5)
Height= Height';
Width = [111; 332; 44; 55; 23]

AllData = [Age, Height, Width]
set(handles.uitable1, 'data', AllData)

columnNames = {'Age', 'Height', 'Width'}
rowNames = {'a', 'b', 'c', 'd', 'e'}

set(handles.uitable1,'columnName', columnNames)
set(handles.uitable1, 'rowName', rowNames)


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
data = get(hObject,'Data');
indices = eventdata.Indices;
r = indices(:,1);
c = indices(:,2);
linear_index = sub2ind(size(data),r,c);
selected_vals = data(linear_index);
selection_sum = sum(sum(selected_vals))


axes(handles.axes1)
plot(selected_vals)
axes(handles.axes2)
bar(selected_vals, 'hist')


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.csv'}, 'SelectFile');
if isequal(filename,0)
    return
else
    Path=strcat(pathname,filename);
    set(handles.edit1,'String', Path);
    set(handles.edit2,'String', Path);
    set(handles.edit3,'String', Path);
    
    data= readtable(Path);
    dataTable=table2cell(data);
    set(handles.uitable1,'Data',dataTable);
    
end
   set(handles.uitable1, 'ColumnName', {'rank','discripline', 'phd','service','sex','salary'});
   
  Prof = get(handles.Prof, 'Value')

vall = get(handles.radiobutton1,'value')
if(vall == 1)
    set(handles.radiobutton2,'value',0)
    set(handles.radiobutton3,'value',0)
    dataVal1 = dataTable.salary(strcmp(dataTable,'Prof'))
    
    set(handles.uitable1,'data',dataVal1)
elseif(vall == 2)
    set(handles.radiobutton1,'value',0)
    set(handles.radiobutton3,'value',0)
     dataVal1 = dataTable.salary(strcmp(dataTable,'AssocProf'))
    
    set(handles.uitable1,'data',dataVal1)
elseif(vall == 3)
    set(handles.radiobutton1,'value',0)
    set(handles.radiobutton2,'value',0)
     dataVal1 = dataTable.salary(strcmp(dataTable,'AsstProf'))
    
    set(handles.uitable1,'data',dataVal1)
end


  
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%radio button condition

   
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



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
