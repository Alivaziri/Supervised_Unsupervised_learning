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
y(1)=0.016;
P=zeros(361,1);
V=zeros(361,1);
force=zeros(361,1);
load Acceleration2;
load Position2;
load Position;
load force2;
load Velocity2;
for k=2:361
for l=1:5000
%% first Layer
thetaFc=zeros(1,3);
thetaFc(1,1)=-1.1035;
thetaFc(1,2)=-0.1057;
thetaFc(1,3)=-0.5613;
w1c=zeros(2,3);
w1c(1,1)=-128.028504526027;
w1c(1,2)=-36.9068268685505;
w1c(1,3)=-36.8894836919845;
xc=zeros(3,1);
w2c=zeros(3,1);
w2c(1,1)=-21.2506490968369;
w2c(2,1)=-2.94178338406683;
w2c(3,1)=-2.94094679487272;
thetaLc=-0.01;
yc=zeros(1,1);
deltaWLc=zeros(3,1);
deltaWFc=zeros(1,3);
deltaNeuronFc=zeros(3,1);
Erorr=zeros(1,361);
tc=linspace(0,3.61,361);
Error(1)=0.02;
force(1)=1;
%% first Layer
yc(1)=0;
    for ic=1:3
          xc(ic)=w1c(1,ic)*1000*Error+w1c(2,ic)*0.01*yc+thetaFc(ic);
          xc(ic)=sigmoid(xc(ic));
    end
%% Last Layer

          yc(k)=w2c(1,1)*xc(1)+w2c(2,1)*x(2)+w2c(3,1)*x(3)+thetaLc;
          yc(k)=sigmoid(yc(k));


%% weight upgrading with Erorr Back propagation Method
ethac=0.01;
%last layer
deltaNeuronLc=sigmoidD(yc(k))*(yc(k)-yc(k-1));
sc=0;
for sc=1:3
   deltaWLc(sc,1)=ethac*xc(sc)*deltaNeuronLc;
end

deltaThetaLc=ethac*1*deltaNeuronLc;

%first layer
hc=0;
for hc=1:3
    deltaNeuronFc(hc)=sigmoidD(xc(hc))*w2(hc,1)*deltaNeuronLc;
end
vc=0;
    for vc=1:3
    deltaWF1c(1,vc)=ethac*1000*Error*deltaNeuronFc(vc);
    end
rc=0;
    for rc=1:3
    deltaWF2c(2,rc)=ethac*0.01*yc(k)*deltaNeuronFc(rc);
    end
    
    deltaThetaF1c=ethac*1*deltaNeuronFc(1);
    deltaThetaF2c=ethac*1*deltaNeuronFc(2);
    deltaThetaF3c=ethac*1*deltaNeuronFc(3);
    
%% new Wights
%Last layer
uc=0;
    for uc=1:3
        w2c(uc,1)=w2(uc,1)+deltaWLc(uc,1);
    end
    
%first layer
ec=0;
    for ec=1:3
        w1c(1,ec)=w1c(1,ec)+deltaWF1c(1,ec);
    end
ac=0;
    for ac=1:3
        w1c(2,ac)=w1c(2,ac)+deltaWF2c(2,ac);
    end
    
    thetaFc(1,1)=deltaThetaF1c+thetaFc(1,1);
    thetaFc(1,2)=deltaThetaF2c+thetaFc(1,2);
    thetaFc(1,3)=deltaThetaF3c+thetaFc(1,3);
 
%% Neuarl Network Model

i=0;
    for i=1:4
          x(i)=w1(1,i)*yc(k)+w1(2,i)*Velocity2(k)+thetaF(i);
          x(i)=sigmoid(x(i));
    end
% Last Layer

          y(k)=w2(1,1)*x(1)+w2(2,1)*x(2)+w2(3,1)*x(3)+w2(4,1)*x(4)+thetaL;
          y(k)=sigmoid(y(k));


% integrator
V(1)=0;
    V(k)=(y(k-1)+y(k))*0.05+V(k-1);
P(1)=0;
   P(k)=(V(k-1)+V(k))*0.05+P(k-1);
          
      Error=(P(k-1)-(Position(k)));
 
% weight upgrading with Erorr Back propagation Method
etha=0.01;
%last layer
deltaNeuronL=sigmoidD(y(k))*(Velocity2(k)-V(k));
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
    deltaWF1(1,v)=etha*yc(k-1)*deltaNeuronF(v);
    end
r=0;
    for r=1:4
    deltaWF2(2,r)=etha*Velocity2(k)*deltaNeuronF(r);
    end
    
    deltaThetaF1=etha*1*deltaNeuronF(1);
    deltaThetaF2=etha*1*deltaNeuronF(2);
    deltaThetaF3=etha*1*deltaNeuronF(3);
    deltaThetaF4=etha*1*deltaNeuronF(4);

%new Wights
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
plot(t,position2,'r');
hold on;
plot(t,P,'.-');
ylabel('postion');
xlabel('time');
legend('on off Position','NNC Position');

c=zeros(1,36);
for j=1:360
    c(j)=(position2(j+1)-P(j))^2;
end
RMS=sqrt(sum(c)/360);
disp(RMS);
