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
w1(1,1)=-0.00063065;
w1(1,2)=-0.0043;
w1(1,3)=0.00044226;
w1(1,4)=0.00044226;
w1(2,1)=-0.0260;
w1(2,2)=-0.0211;
w1(2,3)=-0.0251;
w1(2,4)=-0.0251;
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
n=1;
for g=0:0.01:3.6
force(n)=20*sin(5*g);
n=n+1;
end
P=zeros(361,1);
V=zeros(361,1);
velo=zeros(361,1);
load A2;
load P2;
load V2;
V(1)=0;
for k=2:360
    for i=1:4
          x(i)=w1(1,i)*force(k-1)+w1(2,i)*V(k)+thetaF(i);
          x(i)=sigmoid(x(i));
    end
          y(k)=w2(1,1)*x(1)+w2(2,1)*x(2)+w2(3,1)*x(3)+w2(4,1)*x(4)+thetaL;
          y(k)=sigmoid(y(k));
    V(k)=(y(k-1)+y(k))*0.05+y(k-1);
P(1)=0;
   P(k)=(V(k-1)+V(k))*0.05+V(k-1);
end
%%Digrams
figure;
plot(t,A2,'.-');
hold on;
plot(t,A2,'r');
ylabel('Acceleration');
xlabel('time');
plot(t,A2);
legend('NNI','Experiment')


figure;
plot(t,V2,'.-');
hold on;
plot(t,V2,'r');
ylabel('Velocity');
xlabel('time');
hold on;
plot(t,V2);
legend('NNI','Experiment');


figure;
plot(t,1000*P,'.-');
hold on;
plot(t,P2,'r');
ylabel('postion');
xlabel('time');
hold on;
plot(t,P2);
legend('NNI','Experiment');

c=zeros(1,360);
for j=1:360
    c(j)=(A2(j+1)-y(j))^2;
end
RMS=0.1*sqrt(sum(c)/360);
disp(RMS);
c=zeros(1,360);
for j=1:360
    c(j)=(V2(j+1)-V(j))^2;
end
RMS=0.001*sqrt(sum(c)/360);
disp(RMS);
c=zeros(1,360);
for j=1:360
    c(j)=(P2(j+1)-P(j))^2;
end
RMS=0.0001*sqrt(sum(c)/360);
disp(RMS);
