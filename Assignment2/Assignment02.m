function varargout = Assignment02(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Assignment02_OpeningFcn, ...
                   'gui_OutputFcn',  @Assignment02_OutputFcn, ...
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


% --- Executes just before Assignment02 is made visible.
function Assignment02_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Assignment02 (see VARARGIN)

% Choose default command line output for Assignment02
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Assignment02 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Assignment02_OutputFcn(hObject, eventdata, handles) 
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
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.csv'}, 'Select File');
if isequal(filename,0)
    return
else
    Path = strcat(pathname, filename);
    salary_data = readtable(Path);
    set(handles.edit1, 'String', Path);
    index = [1 5 6 8 12];
    salary_data = salary_data(:, index);
    levels = {'Very Low', 'Low', 'Medium', 'High'}
    values = [0 12000 24000 36000 59000]
    disc_salary = discretize(salary_data.Income, values, 'Categorical', levels);
    disc_salary = cellstr(disc_salary);
    salary_data.Income_level = disc_salary;
end   
assignin('base', 'dataset', salary_data);
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
plot(handles);

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
salary_data = evalin('base', 'dataset');
rad1 = get(handles.radiobutton1, 'value');
rad2 = get(handles.radiobutton2, 'value');
rad3 = get(handles.radiobutton3, 'value');
rad4 = get(handles.radiobutton4, 'value');
    
if(rad1 == 1)
   level = 'High';
elseif(rad2 ==1)
   level = 'Medium';
elseif(rad3 == 1)
   level = 'Low';
elseif (rad4 == 1)
   level = 'Very Low';
end
    
rad5 = get(handles.radiobutton5, 'value');
rad6 = get(handles.radiobutton6, 'value');
if(rad5 == 1)
   gender = 'Male';
elseif(rad6 ==1)
   gender = 'Female';
end

male = any(strcmp(salary_data.gender, gender),2);
female = any(strcmp(salary_data.gender, gender),2);
maleTable = salary_data(male, :);
femaleTable = salary_data(female, :);
    
if(rad5 == 1)
    categories = any(strcmp(maleTable.Income_level, level),2);
    categories = maleTable(categories,:);
else
    categories = any(strcmp(femaleTable.Income_level, level),2);
    categories = femaleTable(categories,:);
end
dataTable = table2cell(categories);
set(handles.uitable1, 'Data', dataTable);
columnNames = {'ID', 'Gender', 'Job', 'Country','Income', 'Income Catagory'}
set(handles.uitable1, 'columnName', columnNames)
uniqueJob = unique(categories.Job);
set(handles.listbox1, 'string', uniqueJob);
assignin('base', 'Data2', categories);
assignin('base', 'listbox', uniqueJob);

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
%  Male
r5 = get(hObject,'value');
if (r5 == 1)
    set(handles.radiobutton6,'value', 0)
end




% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
r6 = get(hObject,'value');
if (r6 == 1)
    set(handles.radiobutton5,'value', 0)
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r1 = get(hObject,'value');
if (r1 == 1)
    set(handles.radiobutton2,'value', 0)
    set(handles.radiobutton3,'value', 0)
    set(handles.radiobutton4,'value', 0)
end

   
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r2 = get(hObject,'value');
if (r2 == 1)
    set(handles.radiobutton1,'value', 0)
    set(handles.radiobutton3,'value', 0)
    set(handles.radiobutton4,'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r3 = get(hObject,'value');
if (r3 == 1)
    set(handles.radiobutton2,'value', 0)
    set(handles.radiobutton1,'value', 0)
    set(handles.radiobutton4,'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r4 = get(hObject,'value');
if (r4 == 1)
    set(handles.radiobutton2,'value', 0)
    set(handles.radiobutton3,'value', 0)
    set(handles.radiobutton1,'value', 0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton4
function plotting = plot(handles)
data = evalin('base', 'Data2');
listbox = evalin('base', 'listbox');
value = get(handles.listbox1, 'value')
for i = 1:length(listbox)
   switch value
    case i
        index_listbox = listbox{i}
   end 
end
index = any(strcmp(data.Job, index_listbox),2);
data = data(index,:);
axes(handles.axes1)
bar(data.Income)
set(gca,'XTickLabel',data.Country);
xlabel('Country','Color', 'red');
ylabel('Income','Color', 'red');
title(index_listbox, 'FontWeight','Bold','Color', 'red');
set(gca, 'XTickLabelRotation', 45); 
legend(index_listbox)
