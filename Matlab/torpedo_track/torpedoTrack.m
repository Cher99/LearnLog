function varargout = torpedoTrack(varargin)
%TORPEDOTRACK MATLAB code file for torpedoTrack.fig
%      TORPEDOTRACK, by itself, creates a new TORPEDOTRACK or raises the existing
%      singleton*.
%
%      H = TORPEDOTRACK returns the handle to a new TORPEDOTRACK or the handle to
%      the existing singleton*.
%
%      TORPEDOTRACK('Property','Value',...) creates a new TORPEDOTRACK using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to torpedoTrack_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TORPEDOTRACK('CALLBACK') and TORPEDOTRACK('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TORPEDOTRACK.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help torpedoTrack

% Last Modified by GUIDE v2.5 14-May-2020 18:58:21

% Begin initialization code - DO NOT EDIT
global x_tor x_tar y_tor y_tar angle_tor angle_tar v_tor v_tar boom boom_dis h1 h1_head h2 h2_head boom_zone boom_edge;

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @torpedoTrack_OpeningFcn, ...
                   'gui_OutputFcn',  @torpedoTrack_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before torpedoTrack is made visible.
function torpedoTrack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for torpedoTrack
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes torpedoTrack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = torpedoTrack_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function torpedoSet_button_Callback(hObject, eventdata, handles)
%%   Yijiang: Initial position and speed of torpedo will be drawn here.
disp(['ALL Paramters of Torpedo have been set.']);
global x_tor y_tor angle_tor v_tor boom_dis h2 h2_head boom_zone boom_edge;
boom_dis=get(handles.boom_disp,'String');boom_dis=str2double(boom_dis);
x_tor=get(handles.x_torpedo,'String');x_tor=str2double(x_tor);
y_tor=get(handles.y_torpedo,'String');y_tor=str2double(y_tor);
v_tor=get(handles.speed_torpedo,'String');v_tor=str2double(v_tor);
angle_tor=get(handles.angle_torpedo,'String');angle_tor=str2double(angle_tor);

x_b=x_tor;y_b=y_tor;
x_e=x_tor+v_tor/10*cos(angle_tor/180*pi);y_e=y_tor+v_tor/10*sin(angle_tor/180*pi);

h2=plot([x_b,x_e],[y_b,y_e],'linewidth',3,'color',[0,0.8,0.8]);hold on
h2_head=plot([x_e],[y_e],'ks','MarkerFaceColor','b');

%画出鱼雷的感知范围boom_distance。
theta_sub=0:pi/100:2*pi;
x=x_tor+boom_dis*cos(theta_sub);y=y_tor+boom_dis*sin(theta_sub);
boom_edge=plot(x,y,'b');
boom_zone=fill(x,y,'c','FaceAlpha',0.3);
axis([-20 20 -20 20]);axis equal





function target_set_button_Callback(hObject, eventdata, handles)
%%   Yijiang: Initial position and speed of target will be drawn here.
disp(['ALL Paramters of Target have been set.']);
global x_tar y_tar angle_tar v_tar h1 h1_head
x_tar=get(handles.x_target,'String');x_tar=str2double(x_tar);
y_tar=get(handles.y_target,'String');y_tar=str2double(y_tar);
v_tar=get(handles.speed_target,'String');v_tar=str2double(v_tar);
angle_tar=get(handles.angle_target,'String');angle_tar=str2double(angle_tar);

x_b=x_tar;y_b=y_tar;
x_e=x_tar+v_tar/10*cos(angle_tar/180*pi);y_e=y_tar+v_tar/10*sin(angle_tar/180*pi);

h1=plot([x_b,x_e],[y_b,y_e],'linewidth',3,'color',[0.8,0.3,0.2]);hold on
h1_head=plot([x_e],[y_e],'bs','MarkerFaceColor','r');
axis([-20 20 -20 20]);axis equal


% --- Executes on button press in begin_track.
function begin_track_Callback(hObject, eventdata, handles)

%%   Yijiang: Track be drawn here in a dynamic way.
% Solution: Relative Movement.
cla(handles.track_map,'reset');
global x_tor x_tar y_tor y_tar angle_tor angle_tar v_tor v_tar boom boom_dis;
delta_x=x_tor-x_tar,delta_y=y_tor-y_tar;boom=0;
now_dis=sqrt(delta_x^2+delta_y^2);
theta1=atan2(delta_y,delta_x)+pi; %rad
theta2=theta1-pi/2;
theta2tor1=theta1-angle_tor/180*pi;theta2tar1=pi-theta1-angle_tar/180*pi;
theta2tor2=theta2-angle_tor/180*pi;theta2tar2=pi-theta2-angle_tar/180*pi;
delta_vx=(v_tar*cos(theta2tar1)+v_tor*cos(theta2tor1));%大于0，意味着两者在位置连线方向上越来越近
delta_vy=(v_tar*cos(theta2tar2)+v_tor*cos(theta2tor2));%大于0，意味着两者在位置连线方向上越来越近

track_tor=animatedline('Color',[0,0.8,0.8],'Marker','o','MarkerSize',3,'linewidth',3);
track_tar=animatedline('Color',[0.8,0.3,0.2],'Marker','*','MarkerSize',3,'linewidth',3);
if delta_vx>1e-1
    dt=0.1;Max_step1=floor(abs(now_dis/delta_vx/dt)+1);
    dx1=dt*v_tar*cos(angle_tar/180*pi);dy1=dt*v_tar*sin(angle_tar/180*pi);
    dx2=dt*v_tor*cos(angle_tor/180*pi);dy2=dt*v_tor*sin(angle_tor/180*pi);
    track_tor_x=[];track_tor_y=[];track_tar_x=[];track_tar_y=[];t=0;
    while(boom==0)
        track_tor_x=[track_tor_x x_tor];track_tor_y=[track_tor_y y_tor];
        track_tar_x=[track_tar_x x_tar];track_tar_y=[track_tar_y y_tar];
        delta_x=x_tor-x_tar;delta_y=y_tor-y_tar;
        now_dis=sqrt(delta_x^2+delta_y^2);
        addpoints(track_tar,x_tar,y_tar);
        x_tar=x_tar+dx1;y_tar=y_tar+dy1;
        addpoints(track_tor,x_tor,y_tor);
        x_tor=x_tor+dx2;y_tor=y_tor+dy2;
        drawnow limitrate
        pause(0.5)
        axis([-20 20 -20 20]);axis equal
        if(now_dis<boom_dis)
            boom=1;
        else
            t=t+1;
        end
        if(t>=Max_step1)
            break;
        end
    end
    if boom==1
        plot(track_tor_x,track_tor_y,'linewidth',3,'color',[0,0.8,0.8]);hold on
        plot(track_tor_x(end),track_tor_y(end),'b*');text(track_tor_x(end),track_tor_y(end),['Time:',num2str(t*dt),' 击中目标'],'FontSize',10);
        plot(track_tar_x,track_tar_y,'linewidth',3,'color',[0.8,0.3,0.2]);
        plot(track_tar_x(end),track_tar_y(end),'ro');
        %画出鱼雷的感知范围boom_distance。
        theta_sub=0:pi/100:2*pi;
        x=track_tor_x(end)+boom_dis*cos(theta_sub);y=track_tor_y(end)+boom_dis*sin(theta_sub);
        plot(x,y,'b');
        fill(x,y,'c','FaceAlpha',0.3);
        axis([-20 20 -20 20]);axis equal
    else
        text_no='鱼雷速度与作用范围不匹配，无法击中';
        handles.begin_track.String=text_no;
    end
else
    text_no='航迹平行，无法击中';
    handles.begin_track.String=text_no;
end
function speed_torpedo_Callback(hObject, eventdata, handles)
% hObject    handle to speed_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed_torpedo as text
%        str2double(get(hObject,'String')) returns contents of speed_torpedo as a double

global v_tor
v_tor=get(handles.speed_torpedo,'String');v_tor=str2double(v_tor);


% --- Executes during object creation, after setting all properties.
function speed_torpedo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angle_torpedo_Callback(hObject, eventdata, handles)
% hObject    handle to angle_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angle_torpedo as text
%        str2double(get(hObject,'String')) returns contents of angle_torpedo as a double
global angle_tor
angle_tor=get(handles.angle_torpedo,'String');angle_tor=str2double(angle_tor);


% --- Executes during object creation, after setting all properties.
function angle_torpedo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function speed_target_Callback(hObject, eventdata, handles)
% hObject    handle to speed_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed_target as text
%        str2double(get(hObject,'String')) returns contents of speed_target as a double

global v_tar
v_tar=get(handles.speed_target,'String');v_tar=str2double(v_tar);



% --- Executes during object creation, after setting all properties.
function speed_target_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angle_target_Callback(hObject, eventdata, handles)
% hObject    handle to angle_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angle_target as text
%        str2double(get(hObject,'String')) returns contents of angle_target as a double

global angle_tar
angle_tar=get(handles.angle_target,'String');angle_tar=str2double(angle_tar);



% --- Executes during object creation, after setting all properties.
function angle_target_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_torpedo_Callback(hObject, eventdata, handles)
% hObject    handle to x_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_torpedo as text
%        str2double(get(hObject,'String')) returns contents of x_torpedo as a double
global x_tor
x_tor=get(handles.x_torpedo,'String');x_tor=str2double(x_tor);


% --- Executes during object creation, after setting all properties.
function x_torpedo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_torpedo_Callback(hObject, eventdata, handles)
% hObject    handle to y_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_torpedo as text
%        str2double(get(hObject,'String')) returns contents of y_torpedo as a double
global y_tor
y_tor=get(handles.y_torpedo,'String');y_tor=str2double(y_tor);

% --- Executes during object creation, after setting all properties.
function y_torpedo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_torpedo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_target_Callback(hObject, eventdata, handles)
% hObject    handle to x_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_target as text
%        str2double(get(hObject,'String')) returns contents of x_target as a double
global x_tar
x_tar=get(handles.x_target,'String');x_tar=str2double(x_tar);

% --- Executes during object creation, after setting all properties.
function x_target_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_target_Callback(hObject, eventdata, handles)
% hObject    handle to y_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_target as text
%        str2double(get(hObject,'String')) returns contents of y_target as a double
global y_tar
y_tar=get(handles.y_target,'String');y_tar=str2double(y_tar);

% --- Executes during object creation, after setting all properties.
function y_target_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_target (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
% img_path='?D:\本学期课程\探测自导技术\作业\background.jpg';
% im=imread(img_path);
% imshow(im)



function boom_disp_Callback(hObject, eventdata, handles)
% hObject    handle to boom_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boom_disp as text
%        str2double(get(hObject,'String')) returns contents of boom_disp as a double
global boom_dis
boom_dis=get(handles.boom_disp,'String');boom_dis=str2double(boom_dis);

% --- Executes during object creation, after setting all properties.
function boom_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boom_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
