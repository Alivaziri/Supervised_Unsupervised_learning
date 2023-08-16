clc;
clear;
close all;
format long;
thetaFc=zeros(1,3);
thetaFc(1,1)=-0.1157;
thetaFc(1,2)=-0.1169;
thetaFc(1,3)=-0.1158;

wc1=zeros(3,1);
wc1(1,1)=0.0058;
wc1(1,2)=0.0021;
wc1(1,3)=0.0069;

xc=zeros(3,1);
wc2=zeros(1,3);
wc2(1,1)=-2.9349;
wc2(2,1)=-2.9412;
wc2(3,1)=-2.9403;

thetaLc=-0.01;

deltaWLc=zeros(3,1);
deltaWFc1=zeros(1,3);

deltaNeuronF=zeros(3,1);
y=zeros(361,1);
Erorr=zeros(361,1);
t=linspace(0,3.61,361);
y(1)=0;

P=zeros(361,1);
V=zeros(361,1);
velo=zeros(361,1);


load Position2;
load force2;

for k=2:360
for l=1:10000
%% first Layer

i=0;
    for i=1:3
          xc(i)=wc1(i,1)*force2(k)+thetaFc(i);
          xc(i)=sigmoid(xc(i));
    end
%% Last Layer

          y(k)=wc2(1,1)*xc(1)+wc2(2,1)*xc(2)+wc2(3,1)*xc(3)+thetaLc;
          y(k)=sigmoid(y(k));



%% weight upgrading with Erorr Back propagation Method
etha=0.1;
%last layer
deltaNeuronL=sigmoidD(y(k))*(force2(k)-y(k));
s=0;
for s=1:3
   deltaWLc(s,1)=etha*xc(s)*deltaNeuronL;
end

deltaThetaL=etha*1*deltaNeuronL;

%first layer
h=0;
for h=1:3
    deltaNeuronF(h)=sigmoidD(xc(h))*wc2(h,1)*deltaNeuronL;
end
v=0;
    for v=1:3
    deltaWFc1(1,v)=etha*force2(k)*deltaNeuronF(v);
    end

   
    deltaThetaF1=etha*1*deltaNeuronF(1);
    deltaThetaF2=etha*1*deltaNeuronF(2);
    deltaThetaF3=etha*1*deltaNeuronF(3);


%% new Wights
%Last layer
u=0;
    for u=1:3
        wc2(u,1)=wc2(u,1)+deltaWLc(u,1);
    end
    
%first layer
e=0;
    for e=1:3
        wc1(1,e)=wc1(1,e)+deltaWFc1(1,e);
    end

    thetaFc(1,1)=deltaThetaF1+thetaFc(1,1);
    thetaFc(1,2)=deltaThetaF2+thetaFc(1,2);
    thetaFc(1,3)=deltaThetaF3+thetaFc(1,3);
    

    
    end
end
%%Digrams
figure;
plot(t,y,'.-');
hold on;
plot(t,force2,'r');
ylabel('force');
xlabel('time');
plot(t,force2);
legend('NNI','Experiment')

b=zeros(1,361);
c=zeros(1,360);
for j=1:360
    c(j)=(force2(j+1)-y(j))^2;
    b(j)=force2(j+1)-y(j);
end

RMS=0.1*sqrt(sum(c)/360);
disp(RMS);
