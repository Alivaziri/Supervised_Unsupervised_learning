clc;
clear;
close all;
format long;
thetaF=zeros(1,3);
thetaF(1,1)=-0.0032;
thetaF(1,2)=-0.0042;
thetaF(1,3)=-0.0031;
thetaF(1,4)=-0.0031;
w1=zeros(2,4);
w1(1,1)=-0.00061138;
w1(1,2)=-0.0043;
w1(1,3)=0.00046157;
w1(1,4)=0.00046157;
w1(2,1)=-0.0265;
w1(2,2)=-0.0216;
w1(2,3)=-0.0256;
w1(2,4)=-0.0256;
x=zeros(4,1);
w2=zeros(4,1);
w2(1,1)=-2.9338;
w2(2,1)=-2.9400;
w2(3,1)=-2.9392;
w2(4,1)=-2.9392;
thetaL=-0.01;
deltaWL=zeros(4,1);
deltaWF1=zeros(1,4);
deltaWF2=zeros(1,4);
deltaNeuronF=zeros(4,1);
y=zeros(361,1);
Erorr=zeros(361,1);
t=linspace(0,3.61,361);
y(1)=0;
force(1)=0;
P=zeros(361,1);
V=zeros(361,1);
velo=zeros(361,1);
force=zeros(361,1);
load Acceleration;
load Position;
load force;
load Velocity;
for k=2:360
for l=1:5000
%% first Layer
force(1)=0;
i=0;
    for i=1:4
          x(i)=w1(1,i)*force(k)+w1(2,i)*V(k)+thetaF(i);
          x(i)=sigmoid(x(i));
    end
%% Last Layer

          y(k)=w2(1,1)*x(1)+w2(2,1)*x(2)+w2(3,1)*x(3)+w2(4,1)*x(4)+thetaL;
          y(k)=sigmoid(y(k));


%% integrator
V(1)=0;
    V(k)=(y(k-1)+y(k))*0.05+V(k-1);
P(1)=0;
   P(k)=(V(k-1)+V(k))*0.05+P(k-1);
          
 
%% weight upgrading with Erorr Back propagation Method
etha=0.001;
%last layer
deltaNeuronL=sigmoidD(y(k))*(Acceleration(k)-y(k));
s=0;
for s=1:4
   deltaWL(s,1)=etha*x(s)*deltaNeuronL;
end

deltaThetaL=etha*1*deltaNeuronL;

%first layer
h=0;
for h=1:4
    deltaNeuronF(h)=sigmoidD(x(h))*w2(h,1)*deltaNeuronL;
end
v=0;
    for v=1:4
    deltaWF1(1,v)=etha*force(k)*deltaNeuronF(v);
    end
r=0;
    for r=1:4
    deltaWF2(2,r)=etha*V(k)*deltaNeuronF(r);
    end
    
    deltaThetaF1=etha*1*deltaNeuronF(1);
    deltaThetaF2=etha*1*deltaNeuronF(2);
    deltaThetaF3=etha*1*deltaNeuronF(3);
    deltaThetaF4=etha*1*deltaNeuronF(4);

%% new Wights
%Last layer
u=0;
    for u=1:4
        w2(u,1)=w2(u,1)+deltaWL(u,1);
    end
    
%first layer
e=0;
    for e=1:4
        w1(1,e)=w1(1,e)+deltaWF1(1,e);
    end
a=0;
    for a=1:4
        w1(2,a)=w1(2,a)+deltaWF2(2,a);
    end
    
    thetaF(1,1)=deltaThetaF1+thetaF(1,1);
    thetaF(1,2)=deltaThetaF2+thetaF(1,2);
    thetaF(1,3)=deltaThetaF3+thetaF(1,3);
    thetaF(1,4)=deltaThetaF4+thetaF(1,4);

    
    end
end
%%Digrams
figure;
plot(t,y,'.-');
hold on;
plot(t,Acceleration,'r');
ylabel('Acceleration');
xlabel('time');
plot(t,Acceleration);
legend('NNI','Experiment')


figure;
plot(t,10*V,'.-');
hold on;
plot(t,Velocity,'r');
ylabel('Velocity');
xlabel('time');
hold on;
plot(t,Velocity);
legend('NNI','Experiment');


figure;
plot(t,P,'.-');
hold on;
plot(t,Position,'r');
ylabel('postion');
xlabel('time');
hold on;
plot(t,Position);
legend('NNI','Experiment');

c=zeros(1,360);
for j=1:360
    c(j)=(Acceleration(j+1)-y(j))^2;
end
RMS=sqrt(sum(c)/360);
disp(RMS);
c=zeros(1,360);
for j=1:360
    c(j)=(Velocity(j+1)-V(j))^2;
end
RMS=sqrt(sum(c)/360);
disp(RMS);
c=zeros(1,360);
for j=1:360
    c(j)=(Position(j+1)-P(j))^2;
end
RMS=sqrt(sum(c)/360);
disp(RMS);
