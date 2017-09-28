function varargout = ControlDifuso(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlDifuso_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlDifuso_OutputFcn, ...
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


% --- Executes just before ControlDifuso is made visible.
function ControlDifuso_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for ControlDifuso
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ControlDifuso wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ControlDifuso_OutputFcn(hObject, eventdata, handles) 
%%% Define the membership functions
%% Define the functions for the motor speed
x_speed=0:0.1:100;
duty_cycle_Low =(x_speed<9).*(0.5/9*x_speed) + ((x_speed>=9)&(x_speed<12)).*(0.25/3*x_speed-0.25) + ((x_speed>=12)&(x_speed<20)).*(0.25/8*x_speed+3/8) + ((x_speed>=20)&(x_speed<=25)).*(1) + ((x_speed>25)&(x_speed<35)).*(-1/10*x_speed+7/2) + (x_speed>=35).*(0);
duty_cycle_Normal=(x_speed<=25).*(0) + ((x_speed>=25)&(x_speed<30)).*(0.5/5*x_speed-2.5) + ((x_speed>=30)&(x_speed<45)).*(0.5/15*x_speed-1/2) + ((x_speed>=45)&(x_speed<57)).*(1) + ((x_speed>=57)&(x_speed<60)).*(-0.25/3*x_speed+5.75) + ((x_speed>=60)&(x_speed<67)).*(-0.5/7*x_speed+141/28) + ((x_speed>=67)&(x_speed<70)).*(-0.25/3*x_speed+35/6) + (x_speed>=70).*(0);
duty_cycle_High=(x_speed<=60).*(0) + ((x_speed>=60)&(x_speed<65)).*(0.25/5*x_speed-3) + ((x_speed>=65)&(x_speed<75)).*(0.25) + ((x_speed>=75)&(x_speed<88)).*(0.5/13*x_speed-137/52) + ((x_speed>=88)&(x_speed<90)).*(0.75) + ((x_speed>=90)&(x_speed<93)).*(0.25/3*x_speed-27/4) + ((x_speed>=93)&(x_speed<100)).*(1);
%% Define the functions for temp
x_temp=20:0.1:67;
temp_Low=(x_temp<=20).*(1) + ((x_temp>20)&(x_temp<33)).*(-1/15*x_temp+7/3) + (x_temp>33).*(0);
temp_Normal=(x_temp<=25).*(0) + ((x_temp>25)&(x_temp<28)).*(0.5/3*x_temp-25/6) + ((x_temp>=28)&(x_temp<32)).*(0.5/4*x_temp-3) +  ((x_temp>=32)&(x_temp<37)).*(1) + ((x_temp>=37)&(x_temp<40)).*(-0.5/3*x_temp+43/6) + ((x_temp>=40)&(x_temp<44)).*(-0.5/4*x_temp+5.5) + (x_temp>=44).*(0);
temp_High=((x_temp>0)&(x_temp<43)).*(0) + ((x_temp>=43)&(x_temp<67)).*(1/24*x_temp-43/24) + (x_temp>=67).*(1);
%% Define the function for output the motor
x_Out1=0:0.05:100;
Grap_out=(x_Out1<=25).*(1) + ((x_Out1>25)&(x_Out1<30)).*(-0.5/5*x_Out1+7/2) + ((x_Out1>=30)&(x_Out1<50)).*(0.5) + ((x_Out1>=50)&(x_Out1<=63)).*((0.25/13)*x_Out1-(6/13)) + ((x_Out1>63)&(x_Out1<=75)).*(0.75) + ((x_Out1>75)&(x_Out1<=85)).*((-0.5/10)*x_Out1+(9/2)) + ((x_Out1>85)&(x_Out1<=90)).*(0.25) + ((x_Out1>90)&(x_Out1<=100)).*((-0.25/10)*x_Out1+(5/2));
%% Define the function for output the temperature
x_Out2=0:0.05:100;
Grap_out2=(x_Out2<=15).*((0.25/15)*x_Out2) + ((x_Out2>15)&(x_Out2<=20)).*(0.25) + ((x_Out2>20)&(x_Out2<35)).*((0.5/15)*x_Out2-(5/12)) + ((x_Out2>=35)&(x_Out2<43)).*(0.75) + ((x_Out2>=43)&(x_Out2<=50)).*((-0.25/7)*x_Out2+(16/7)) + ((x_Out2>50)&(x_Out2<=75)).*(0.5) + ((x_Out2>75)&(x_Out2<=80)).*((0.5/5)*x_Out2-7) + ((x_Out2>80)&(x_Out2<=100)).*(1);
%%% End of membership functions

%%% Begin Plot the Functions
%% Plot the graphics for the motor speed
handles.g1=plot(handles.Graph_1,x_speed,duty_cycle_Low,'B');
grid(handles.Graph_1,'on');
title(handles.Graph_1,'Duty Cycle Low');
%%hold(handles.Graph_1,'on');

handles.g2=plot(handles.Graph_2,x_speed,duty_cycle_Normal,'B');
grid(handles.Graph_2,'on');
title(handles.Graph_2,'Duty Cycle Normal');
%%hold(handles.Graph_1,'on');

handles.g3=plot(handles.Graph_3,x_speed,duty_cycle_High,'B');
grid(handles.Graph_3,'on');
title(handles.Graph_3,'Duty Cycle High');
%%hold(handles.Graph_1,'on');

%% Plot the graphics for the Outputs
% First, Output motor
handles.g4=plot(handles.Graph_4,x_Out1,Grap_out,'B');
grid(handles.Graph_4,'on');
title(handles.Graph_4,'PWM FAN(Out)');
%%hold(handles.Graph_1,'on');

% Second, Output bulbs
handles.g8=plot(handles.Graph_8,x_Out2,Grap_out2,'B');
grid(handles.Graph_8,'on');
title(handles.Graph_8,'PWM Bulbs(Out)');
%%hold(handles.Graph_1,'on');

%% Plot the graphics for the bulbs 
handles.g5=plot(handles.Graph_5,x_temp,temp_Low,'B');
grid(handles.Graph_5,'on');
title(handles.Graph_5,'Temperature Low');
%%hold(handles.Graph_5,'on');

handles.g6=plot(handles.Graph_6,x_temp,temp_Normal,'B');
grid(handles.Graph_6,'on');
title(handles.Graph_6,'Temperature Normal');

handles.g7=plot(handles.Graph_7,x_temp,temp_High,'B');
grid(handles.Graph_7,'on');
title(handles.Graph_7,'Temperature High');
%%hold(handles.Graph_1,'on');
%%% END Plots

% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button1.
function button1_Callback(hObject, eventdata, handles)
s=serial('COM9'); %% Define el puerto usado por la comunicacion serial
set(s,'BaudRate',9600,'Timeout', 1); %% Inicializa la comunicaion serial, ajusta la velocidad de trasmision
set(s,'Terminator','LF');
fopen(s); %% Abre el puerto de la comunicacion serial 
fwrite (s,1);   %% Envia por el puerto serial un 1, para solicitar un dato
pause(0.005);   %%
temp=fread(s);  %% Guarda el dato enviado por el puerto serial que corresponde al valor de la temperatura
    %% Convierte la temperatura adquirida en numero  
set(handles.InputTemp,'String',temp);   %% Cambia en la interfaz grafica el valor correspondiente recibido
fwrite (s,2);   %% Envia por el puerto serial un 2 para solicitar otro dato
pause(0.005);
vel=fread(s);    %% Guarda el dato enviado por el puerto serial que corresponde al valor de la velocidad
  %% Convierte la velocidad adquirida en un numero
set(handles.InputVel,'String',vel); %% Cambia en la interfaz grafica el valor correspondiente recibido
fclose(s);  %% Cierra el puerto usado para la comunicacion serial


%%% Define the membership functions
%% Define the functions for the motor speed
x_speed=0:0.1:100;
duty_cycle_Low =(x_speed<9).*(0.5/9*x_speed) + ((x_speed>=9)&(x_speed<12)).*(0.25/3*x_speed-0.25) + ((x_speed>=12)&(x_speed<20)).*(0.25/8*x_speed+3/8) + ((x_speed>=20)&(x_speed<=25)).*(1) + ((x_speed>25)&(x_speed<35)).*(-1/10*x_speed+7/2) + (x_speed>=35).*(0);
duty_cycle_Normal=(x_speed<=25).*(0) + ((x_speed>=25)&(x_speed<30)).*(0.5/5*x_speed-2.5) + ((x_speed>=30)&(x_speed<45)).*(0.5/15*x_speed-1/2) + ((x_speed>=45)&(x_speed<57)).*(1) + ((x_speed>=57)&(x_speed<60)).*(-0.25/3*x_speed+5.75) + ((x_speed>=60)&(x_speed<67)).*(-0.5/7*x_speed+141/28) + ((x_speed>=67)&(x_speed<70)).*(-0.25/3*x_speed+35/6) + (x_speed>=70).*(0);
duty_cycle_High=(x_speed<=60).*(0) + ((x_speed>=60)&(x_speed<65)).*(0.25/5*x_speed-3) + ((x_speed>=65)&(x_speed<75)).*(0.25) + ((x_speed>=75)&(x_speed<88)).*(0.5/13*x_speed-137/52) + ((x_speed>=88)&(x_speed<90)).*(0.75) + ((x_speed>=90)&(x_speed<93)).*(0.25/3*x_speed-27/4) + ((x_speed>=93)&(x_speed<100)).*(1);
%% Define the functions for temp
x_temp=0:0.1:67;
temp_Low=(x_temp<=20).*(1) + ((x_temp>20)&(x_temp<33)).*(-1/15*x_temp+7/3) + (x_temp>33).*(0);
temp_Normal=(x_temp<=25).*(0) + ((x_temp>25)&(x_temp<28)).*(0.5/3*x_temp-25/6) + ((x_temp>=28)&(x_temp<32)).*(0.5/4*x_temp-3) +  ((x_temp>=32)&(x_temp<37)).*(1) + ((x_temp>=37)&(x_temp<40)).*(-0.5/3*x_temp+43/6) + ((x_temp>=40)&(x_temp<44)).*(-0.5/4*x_temp+5.5) + (x_temp>=44).*(0);
temp_High=(x_temp<43).*(0) + ((x_temp>=43)&(x_temp<67)).*(1/24*x_temp-43/24) + (x_temp>=67).*(1);
%% Define the function for output the motor
x_Out1=0:0.05:100;
Grap_out=(x_Out1<=25).*(1) + ((x_Out1>25)&(x_Out1<30)).*(-0.5/5*x_Out1+7/2) + ((x_Out1>=30)&(x_Out1<50)).*(0.5) + ((x_Out1>=50)&(x_Out1<=63)).*((0.25/13)*x_Out1-(6/13)) + ((x_Out1>63)&(x_Out1<=75)).*(0.75) + ((x_Out1>75)&(x_Out1<=85)).*((-0.5/10)*x_Out1+(9/2)) + ((x_Out1>85)&(x_Out1<=90)).*(0.25) + ((x_Out1>90)&(x_Out1<=100)).*((-0.25/10)*x_Out1+(5/2));
%% Define the function for output the temperature
x_Out2=0:0.05:100;
Grap_out2=(x_Out2<=15).*((0.25/15)*x_Out2) + ((x_Out2>15)&(x_Out2<=20)).*(0.25) + ((x_Out2>20)&(x_Out2<35)).*((0.5/15)*x_Out2-(5/12)) + ((x_Out2>=35)&(x_Out2<43)).*(0.75) + ((x_Out2>=43)&(x_Out2<=50)).*((-0.25/7)*x_Out2+(16/7)) + ((x_Out2>50)&(x_Out2<=75)).*(0.5) + ((x_Out2>75)&(x_Out2<=80)).*((0.5/5)*x_Out2-7) + ((x_Out2>80)&(x_Out2<=100)).*(1);
%%% End of membership functions

%%% Begin Plot the Functions
%% Plot the graphics for the motor speed
handles.g1=plot(handles.Graph_1,x_speed,duty_cycle_Low,'B');
grid(handles.Graph_1,'on');
title(handles.Graph_1,'Duty Cycle Low');
hold(handles.Graph_1,'on');
plot(handles.Graph_1,[vel vel],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_1,'off');

handles.g2=plot(handles.Graph_2,x_speed,duty_cycle_Normal,'B');
grid(handles.Graph_2,'on');
title(handles.Graph_2,'Duty Cycle Normal');
hold(handles.Graph_2,'on');
plot(handles.Graph_2,[vel vel],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_2,'off');

handles.g3=plot(handles.Graph_3,x_speed,duty_cycle_High,'B');
grid(handles.Graph_3,'on');
title(handles.Graph_3,'Duty Cycle High');
hold(handles.Graph_3,'on');
plot(handles.Graph_3,[vel vel],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_3,'off');

%% Plot the graphics for the Outputs
% First, Output motor
handles.g4=plot(handles.Graph_4,x_Out1,Grap_out,'B');
grid(handles.Graph_4,'on');
title(handles.Graph_4,'PWM FAN(Out)');

% Second, Output bulbs
handles.g8=plot(handles.Graph_8,x_Out2,Grap_out2,'B');
grid(handles.Graph_8,'on');
title(handles.Graph_8,'PWM Bulbs(Out)');

%% Plot the graphics for the bulbs 
handles.g5=plot(handles.Graph_5,x_temp,temp_Low,'B');
grid(handles.Graph_5,'on');
title(handles.Graph_5,'Temperature Low');
hold(handles.Graph_5,'on');
plot(handles.Graph_5,[temp temp],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_5,'off');

handles.g6=plot(handles.Graph_6,x_temp,temp_Normal,'B');
grid(handles.Graph_6,'on');
title(handles.Graph_6,'Temperature Normal');
hold(handles.Graph_6,'on');
plot(handles.Graph_6,[temp temp],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_6,'off');

handles.g7=plot(handles.Graph_7,x_temp,temp_High,'B');
grid(handles.Graph_7,'on');
title(handles.Graph_7,'Temperature High');
hold(handles.Graph_7,'on');
plot(handles.Graph_7,[temp temp],[0 1],'k--');%% Print a black line on the "X" point of this graph
hold(handles.Graph_7,'off');
%%% END Plots

%% Evalue positions to find the value into x of sensors in to vectors
pos_v_temp_X=find(x_temp==temp)
pos_v_vel_X=find(x_speed==vel)
%% and save the values of this positions

%% It shows the value where the black line intersect with graphic
% set(handles.DCL,'string',duty_cycle_Low(pos_v_vel_X));
% set(handles.DCN,'string',duty_cycle_Normal(pos_v_vel_X));
% set(handles.DCH,'string',duty_cycle_High(pos_v_vel_X));
% set(handles.TL,'string',temp_Low(pos_v_temp_X));
% set(handles.TN,'string',temp_Normal(pos_v_temp_X));
% set(handles.TH,'string',temp_High(pos_v_temp_X));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Evaluate using the maximum method
Out_Low=max(duty_cycle_Low(pos_v_vel_X),temp_Low(pos_v_temp_X))
Out_Normal=max(duty_cycle_Normal(pos_v_vel_X),temp_Normal(pos_v_temp_X))
Out_High=max(duty_cycle_High(pos_v_vel_X),temp_High(pos_v_temp_X))
Out_Result=max(Out_Low,Out_Normal);
Out_Result=max(Out_Result,Out_High)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Evaluates the first output with the result obtained
for i=1:length(x_Out1)
   if Grap_out(i)<=Out_Low;
       OutLow_1(i)=Grap_out(i);
   else
       OutLow_1(i)=Out_Low;
   end
   if Grap_out(i)<=Out_Normal
       OutNormal_1(i)=Grap_out(i);
   else
       OutNormal_1(i)=Out_Normal;
      end
   if Grap_out(i)<=Out_High
       OutHigh_1(i)=Grap_out(i);
   else
       OutHigh_1(i)=Out_High;
   end
   if Grap_out(i)<=Out_Result
       OutFinal_1(i)=Grap_out(i);
   else
       OutFinal_1(i)=Out_Result;
   end
end

%%% Evaluates the second output with the result obtained
for i=1:length(x_Out2)
   if Grap_out2(i)<=Out_Low;
       OutLow_2(i)=Grap_out2(i);
   else
       OutLow_2(i)=Out_Low;
   end
   if Grap_out2(i)<=Out_Normal
       OutNormal_2(i)=Grap_out2(i);
   else
       OutNormal_2(i)=Out_Normal;
      end
   if Grap_out(i)<=Out_High
       OutHigh_2(i)=Grap_out2(i);
   else
       OutHigh_2(i)=Out_High;
   end
   if Grap_out(i)<=Out_Result
       OutFinal_2(i)=Grap_out2(i);
   else
       OutFinal_2(i)=Out_Result;
   end
end

%%% Begin Plot the Functions (Applied Method: maximum)
%% Plot the graphics for the first output with the maximum method applied
handles.g9=plot(handles.Graph_9,x_Out1,OutLow_1,'c');
grid(handles.Graph_9,'on');
title(handles.Graph_9,'Out Low');

handles.g10=plot(handles.Graph_10,x_Out1,OutNormal_1,'c');
grid(handles.Graph_10,'on');
title(handles.Graph_10,'Out Normal');

handles.g11=plot(handles.Graph_11,x_Out1,OutHigh_1,'c');
grid(handles.Graph_11,'on');
title(handles.Graph_11,'Out High');

handles.g12=plot(handles.Graph_12,x_Out1,OutFinal_1,'c');
grid(handles.Graph_12,'on');
title(handles.Graph_12,'Out Result 1');
%% Plot the graphics for the second output with the maximum method applied
handles.g13=plot(handles.Graph_13,x_Out2,OutLow_2,'c');
grid(handles.Graph_13,'on');
title(handles.Graph_13,'Out Low');

handles.g14=plot(handles.Graph_14,x_Out2,OutNormal_2,'c');
grid(handles.Graph_14,'on');
title(handles.Graph_14,'Out Normal');

handles.g15=plot(handles.Graph_15,x_Out2,OutHigh_2,'c');
grid(handles.Graph_15,'on');
title(handles.Graph_15,'Out High');

handles.g12=plot(handles.Graph_16,x_Out2,OutFinal_2,'c');
grid(handles.Graph_16,'on');
title(handles.Graph_16,'Out Result 2');

if(sum(OutFinal_1)==0) %% If the graph is 0 the center of mass is 0
    mass_center1=0; 	
else    %% otherwise, the operation of the center of mass is performed
mass_center1=sum(OutFinal_1.*x_Out1)/sum(OutFinal_1)
end

if(sum(OutFinal_2)==0) %% If the graph is 0 the center of mass is 0
    mass_center2=0; 	
else    %% otherwise, the operation of the center of mass is performed
mass_center2=sum(OutFinal_1.*x_Out2)/sum(OutFinal_2)
end

mass_center1=(mass_center1*100)/39.7483
mass_center2=(mass_center2*100)/43.9990

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=serial('COM9'); %% Define el puerto usado por la comunicacion serial
set(s,'BaudRate',9600,'Timeout', 1); %% Inicializa la comunicaion serial, ajusta la velocidad de trasmision
set(s,'Terminator','LF');
fopen(s); %% Abre el puerto de la comunicacion serial 
fwrite (s,3);   %% Envia por el puerto serial un 1, para solicitar un dato
pause(0.005);   %%
Flag_Values=fread(s);  %% Guarda el dato enviado por el puerto serial que corresponde al valor de la temperatura


if (Flag_Values == 1)
fwrite (s,mass_center1);   %% Envia por el puerto serial un 1, para solicitar un dato
end
fwrite (s,3);   %% Envia por el puerto serial un 1, para solicitar un dato
pause(0.005);   %%
Flag_Values=fread(s);  %% Guarda el dato enviado por el puerto serial que corresponde al valor de la temperatura
if (Flag_Values == 2)
fwrite (s,mass_center2);   %% Envia por el puerto serial un 1, para solicitar un dato
end
fclose(s);  %% Cierra el puerto usado para la comunicacion serial

% hObject    handle to button1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
