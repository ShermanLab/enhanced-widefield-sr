function varargout = meas_ctrl(varargin)
% MEAS_CTRL MATLAB code for meas_ctrl.fig
%      MEAS_CTRL, by itself, creates a new MEAS_CTRL or raises the existing
%      singleton*.
%
%      H = MEAS_CTRL returns the handle to a new MEAS_CTRL or the handle to
%      the existing singleton*.
%
%      MEAS_CTRL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEAS_CTRL.M with the given input arguments.
%
%      MEAS_CTRL('Property','Value',...) creates a new MEAS_CTRL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before meas_ctrl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to meas_ctrl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help meas_ctrl

% Last Modified by GUIDE v2.5 31-Oct-2017 21:53:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @meas_ctrl_OpeningFcn, ...
                   'gui_OutputFcn',  @meas_ctrl_OutputFcn, ...
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


% --- Executes just before meas_ctrl is made visible.
function meas_ctrl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to meas_ctrl (see VARARGIN)

% Choose default command line output for meas_ctrl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);





% --- Outputs from this function are returned to the command line.
function varargout = meas_ctrl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtName_Callback(hObject, eventdata, handles)
% hObject    handle to txtName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtName as text
%        str2double(get(hObject,'String')) returns contents of txtName as a double


% --- Executes during object creation, after setting all properties.
function txtName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_tiffLoc_Callback(hObject, eventdata, handles)
% hObject    handle to txt_tiffLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_tiffLoc as text
%        str2double(get(hObject,'String')) returns contents of txt_tiffLoc as a double


% --- Executes during object creation, after setting all properties.
function txt_tiffLoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_tiffLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_molList_Callback(hObject, eventdata, handles)
% hObject    handle to txt_molList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_molList as text
%        str2double(get(hObject,'String')) returns contents of txt_molList as a double


% --- Executes during object creation, after setting all properties.
function txt_molList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_molList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDel.
function btnDel_Callback(hObject, eventdata, handles)
% hObject    handle to btnDel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Construct a questdlg with three options


 global params_struct;
 selection_i = get(handles.ppmn_names,'Value');
meas_name  = params_struct(selection_i).name;
 assignin('base', 'multi_tiff_full_path',params_struct(selection_i).tiff_path);
 assignin('base', 'mol_list_path', params_struct(selection_i).mol_list_path);


choice = questdlg(['Are you sure want to delete ' meas_name '?'], ...
	'Confirmation', ...
	'Yes','No','No');
% Handle response
if strcmp(choice,'Yes')
params_struct(selection_i) = []; %#ok<NASGU>
save('.\meas_params.mat','params_struct');

params_struct = load('.\meas_params.mat','params_struct');
params_struct = params_struct.params_struct;
set(handles.ppmn_names,'String', {params_struct(:).name});

end


% --- Executes during object creation, after setting all properties.
function lbl_tiffLoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbl_tiffLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function lbl_molLoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbl_molLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function txt_Sofival_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Sofival (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Sofival as text
%        str2double(get(hObject,'String')) returns contents of txt_Sofival as a double


% --- Executes during object creation, after setting all properties.
function txt_Sofival_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Sofival (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function lbl_sofiBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbl_sofiBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in ppmn_names.
function ppmn_names_Callback(hObject, eventdata, handles)
% hObject    handle to ppmn_names (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppmn_names contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppmn_names

global params_struct;
 selection_i = get(hObject,'Value');
 tif_p = params_struct(selection_i).tiff_path;
 tif_p = strrep(tif_p,'C:\Users\owner\Desktop','...\desktop');
 
 mol_p =  params_struct(selection_i).mol_list_path;
 mol_p = strrep(mol_p,'C:\Users\owner\Desktop','...\desktop');

 set(handles.lbl_tiffLoc,'String',tif_p  );
 set(handles.lbl_molLoc,'String',mol_p);

  set(handles.chkSimulation,'Value',params_struct(selection_i).is_simulation);


 

% --- Executes during object creation, after setting all properties.
function ppmn_names_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppmn_names (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global params_struct;

if exist('.\meas_params.mat','file')
    params_struct = load('.\meas_params.mat','params_struct');
    params_struct = params_struct.params_struct;
    set(hObject,'String', {params_struct(:).name});
else
    params_struct = [];
     set(hObject,'String', 'no measurments added');
end


% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
% hObject    handle to btnClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','clearvars -except p_false_alarm');
global params_struct;
 selection_i = get(handles.ppmn_names,'Value');
 assignin('base', 'sofi_order', str2double(get(handles.txtOrder,'String')));
 assignin('base', 'is_bSOFI', get(handles.chkBSOFI,'Value'));
 assignin('base', 'is_xc', get(handles.chkXC,'Value'));
 assignin('base', 'meas_name', params_struct(selection_i).name);
 assignin('base', 'number_of_frames', str2double(get(handles.txtFrameNum,'String')));
 assignin('base', 'multi_tiff_full_path',params_struct(selection_i).tiff_path);
 assignin('base', 'mol_list_path', params_struct(selection_i).mol_list_path);
 assignin('base','is_simulation',params_struct(selection_i).is_simulation);
 assignin('base','first_frame', str2double(get(handles.txtFirstFrame,'String')));
 assignin('base','time_lapse',str2double(get(handles.txtTimeLapse,'String')));
 assignin('base','use_log_sofi', get(handles.chkLogSOFI, 'Value'));
 num = str2double(get(handles.txt_falseAlarm,'String'));
  
 assignin('base','p_false_alarm',num);

 evalin('base','sofi_and_molList;');
 
 
 

% --- Executes on button press in btn_tiffLoc.
function btn_tiffLoc_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to btn_tiffLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,~] = uigetfile({'*.tif','*.tiff'},'select tif file',pwd);

if FileName~=0
    set(handles.txt_tiffLoc,'String',[PathName FileName]);
end








% --- Executes on button press in btn_molLoc.
function btn_molLoc_Callback(hObject, eventdata, handles)
% hObject    handle to btn_molLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,~] = uigetfile({'*.csv'},'select tif file',pwd);

if FileName~=0
    set(handles.txt_molList,'String',[PathName FileName]);
end



% --- Executes on key press with focus on btn_tiffLoc and none of its controls.
function btn_tiffLoc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to btn_tiffLoc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on btn_molLoc and none of its controls.
function btn_molLoc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to btn_molLoc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btn_molLoc.
function btn_molLoc_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btn_molLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,~] = uigetfile({'*.csv'},'select tif file',pwd);

set(handles.txt_molList,'String',[PathName FileName]);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txt_molList.
function txt_molList_ButtonDownFcn(hObject, eventdata, handles) %#ok<*INUSD>
% hObject    handle to txt_molList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_Add.
function btn_Add_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to btn_Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

name = get(handles.txtName,'String');
sofi_val = 0.1;
tiff_loc = get(handles.txt_tiffLoc,'String');
molList_loc = get(handles.txt_molList,'String');
is_simulation = get(handles.chkSimulation,'Value');
global params_struct;
i = length(params_struct)+1;
params_struct(i). name = name;
params_struct(i).mol_list_path = molList_loc;
params_struct(i).tiff_path = tiff_loc;
params_struct(i).SOFI_bar =sofi_val;
params_struct(i).is_simulation = is_simulation; 
save('.\meas_params.mat','params_struct');

params_struct = load('.\meas_params.mat','params_struct');
params_struct = params_struct.params_struct;
set(handles.ppmn_names,'String', {params_struct(:).name});



%params_struct = load('.\meas_params.mat','params_struct');


% --- Executes on button press in btnClusterDevide.
function btnClusterDevide_Callback(hObject, eventdata, handles)
% hObject    handle to btnClusterDevide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

evalin('base','clusters_devide;');


% --- Executes on button press in chkXC.
function chkXC_Callback(hObject, eventdata, handles)
% hObject    handle to chkXC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkXC


% --- Executes on button press in chkBSOFI.
function chkBSOFI_Callback(hObject, eventdata, handles)
% hObject    handle to chkBSOFI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkBSOFI



function txtOrder_Callback(hObject, eventdata, handles)
% hObject    handle to txtOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOrder as text
%        str2double(get(hObject,'String')) returns contents of txtOrder as a double


% --- Executes during object creation, after setting all properties.
function txtOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtFrameNum_Callback(hObject, eventdata, handles)
% hObject    handle to txtFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFrameNum as text
%        str2double(get(hObject,'String')) returns contents of txtFrameNum as a double


% --- Executes during object creation, after setting all properties.
function txtFrameNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFrameNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnParams.
function btnParams_Callback(hObject, eventdata, handles)
% hObject    handle to btnParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','show_params');



function txtSofiBar_Callback(hObject, eventdata, handles)
% hObject    handle to txtSofiBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSofiBar as text
%        str2double(get(hObject,'String')) returns contents of txtSofiBar as a double


% --- Executes during object creation, after setting all properties.
function txtSofiBar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSofiBar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chk_Simulation.
function chk_Simulation_Callback(hObject, eventdata, handles)
% hObject    handle to chk_Simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_Simulation


% --- Executes on button press in chkSimulation.
function chkSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to chkSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkSimulation



function txt_falseAlarm_Callback(hObject, eventdata, handles)
% hObject    handle to txt_falseAlarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_falseAlarm as text
%        str2double(get(hObject,'String')) returns contents of txt_falseAlarm as a double
 str = get(hObject,'String');
 num= str2double(str);
 if ~isempty(num) 
     if num>=0 && num<=1
         assignin('base','p_false_alarm', num);
     else
          msgbox('P false alarm should be between 0 and 1','Error');
          set(hObject,'String','1');
     end
 else
     msgbox('P false alarm should be a number','Error');
     set(hObject,'String','1');
 end
 

% --- Executes during object creation, after setting all properties.
function txt_falseAlarm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_falseAlarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtFirstFrame_Callback(hObject, eventdata, handles)
% hObject    handle to txtFirstFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFirstFrame as text
%        str2double(get(hObject,'String')) returns contents of txtFirstFrame as a double


% --- Executes during object creation, after setting all properties.
function txtFirstFrame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFirstFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ppmn_second_names.
function ppmn_second_names_Callback(hObject, eventdata, handles)
% hObject    handle to ppmn_second_names (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppmn_second_names contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppmn_second_names


% --- Executes during object creation, after setting all properties.
function ppmn_second_names_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppmn_second_names (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkShowSumImg.
function chkShowSumImg_Callback(hObject, eventdata, handles)
% hObject    handle to chkShowSumImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkShowSumImg



function txtTimeLapse_Callback(hObject, eventdata, handles)
% hObject    handle to txtTimeLapse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTimeLapse as text
%        str2double(get(hObject,'String')) returns contents of txtTimeLapse as a double


% --- Executes during object creation, after setting all properties.
function txtTimeLapse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTimeLapse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkLogSOFI.
function chkLogSOFI_Callback(hObject, eventdata, handles)
% hObject    handle to chkLogSOFI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkLogSOFI
