%clears the screen
clear all; close all; clc;

%% Part 2 - Simulation of a Rotor with Gear Train Driving a Propeller 

%Declaring all the global variables 
global N1 N2 b1 b2 ct kt J1 J2 Jm a bm cnl mu
N1 = 2.1;
N2 = 1.5;
b1 = 0.21;
b2 = 0.12;
ct = 0.075;
kt = 5; % kt {5,15,50,100,500,1000}
J1 = 18;
J2 = 45;
cnl = 0;
mu = 0;

% Defining Matrices A,B,C and D computed by hand
A = [0 1 0 0;(-kt/(J1*(N1*N2)^2)) (-(ct+(b1*(N1*N2)^2))/(J1*(N1*N2)^2)) (kt/(J1*N1*N2)) ((ct)/(J1*N1*N2));0 0 0 1;kt/(J2*N1*N2) ct/(J2*N1*N2) -kt/J2 -(b2+ct)/J2];
Bi = [0 ; 1/J1 ; 0 ; 0];
Bs = [0 ; 200/J1 ; 0 ; 0];
C = [0  0  0  1];
D = [0];

%Find the impulse response to the system and plot it
[y1,T1] = impulse(ss(A,Bi,C,D),1000);

figure(1)
plot(T1,y1);
title (['k_{T}=',num2str(kt)]);
xlabel('Time (t)');
ylabel ('$$ Angular \hspace{1mm} velocity \hspace{2mm} \dot{\theta}_{p} $$','Interpreter', 'Latex');


% Find the step response to the system and plot it
[y2,T2] = step(ss(A,Bs,C,D),1000);
figure(2)
plot(T2,y2);
title (['k_{T}=',num2str(kt)]);
xlabel('Time (t)');
ylabel ('$$ Angular \hspace{1mm} velocity \hspace{2mm} \dot{\theta}_{p} $$','Interpreter', 'Latex');

%% Solving for Part C, Electromechanical system response with Non-linear effects 

Jm = 15;
bm = 1;
a = 100; % alpha = {100,200,400} 

% time span for simulation
ts = [0,1000];

% initial conditions
x0 = [0,0,0,0,0];

% set tolerance to avoid numerical errors
opts = odeset('RelTol',1e-9);


%Finding the response to the linear system
[Tl,zl]=ode45(@NonLin,ts,x0,opts);  

figure(3)
hold on 
plot(Tl,zl(:,4),'-m');
title(['\alpha = ',num2str(a)]);
xlabel('Time (t)');
ylabel('$$ Angular \hspace{1mm} velocity \hspace{2mm} \dot{\theta}_{p} $$','Interpreter', 'Latex');

% Finding the response to the non-linear system
cnl = 7.25*(10^(-5));
mu = 3.15*(10^(-6));

[Tnl,znl]=ode45(@NonLin,ts,x0,opts);
plot(Tnl,znl(:,4),'-b');
legend('linear','Non-Linear');

