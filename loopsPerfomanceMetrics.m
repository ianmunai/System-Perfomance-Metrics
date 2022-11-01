clear 
clc
close all
                        %STEP RESPONSE USING FOR LOOPS
%POV:STEP RESPONSES ARE EVALUATED FROM CLOSED LOOP AND NOT OPEN LOOP!
num1=[5];
den1=[1 11 10 0];
sys1=tf(num1,den1);
sys_one=feedback(sys1,[1]);
num2=[10];
den2=[1 11 10 0];
sys2=tf(num2,den2);
sys_two=feedback(sys2,[1]);
num3=[20];
den3=[1 11 10 0];
sys3=tf(num3,den3);
sys_three=feedback(sys3,[1]); %closed loop system
figure
hold on
step(sys_one);
gtext('K=5');
step(sys_two);
gtext('K=10');
step(sys_three);
gtext('K=20');
title('Step Responses of Three Gains');
grid on

%notice that the above code takes many lines of code and can be easily 
%fixed by a for loop as illustarated  below since the denom is the same!

K=[5 10 20];
i=length(K);
t=0:0.01:20;
figure
for n=1:i
    numg=[K(n)]; deng=[1 11 10 0]; sysg=tf(numg,deng); 
    sys=feedback(sysg,[1]);
    y(:,n)=step(sys,t) ;%step returns a complex variable

% step(sys,t) 
% this alone plots the step response of the last K and you have to include
% hold to %have all plots
%   if numg==[5]
%       gtext('K=5');
%   else if numg==[10]
%     gtext('K=10');
%       else gtext('K=20');
%       end
%       
%     hold on
%   end
end 
plot(t,y);
grid on

%a recapp of subplots. here I want 2 rows and 2 columns
subplot(2,2,1);
plot(t,y(:,1))
grid on
subplot(2,2,2);
plot(t,y(:,2))
grid on
subplot(2,2,3);
plot(t,y(:,3))
grid on

A=[1 2 3;4 5 6;7 8 9];
%recapp of extracting rows and columns from vectors
A(:,2); %extracting column 2
A(2,:);%extractiing row 2

t=0:0.01:6;
k=0;
for p=1:8
    zeta=0.6+0.05*p;
    for q=1:8
        Wn(q,:)=0.5*q
        num1=[6]; den1=[1 6 11  6]; sys1=tf(num1,den1);
        num2=[Wn^2]; den2=[1  2*zeta*Wn Wn^2]; sys2=tf(num2,den2);
        [y1,t]=step(sys1,t); [y2,t]=step(sys2,t);
        error=(y1-y2).^2;
        emax=max(error);
        if emax<0.05
            k=k+1;
            %solution(:,k)=[k zeta Wn  emax]%produces output in columns
            solution(k,:)=[k zeta Wn emax] %produces output as row vectors
        end
    end
end

%OBTAINING RISE TIME,PEAK TIME,MAX OVERSHOOT & SETTLING TIME

%system one
num=[25]; den=[1 6 25];
t=0:0.005:5; [y,x,t]=step(num,den,t);
figure
plot(t,y)
grid on
title('Unit step response 1st')

%Here, the rise time is evaluated as the time taken for the output to rise
%from 10% to 90% of final value
r1=1;while y(r1)<0.1;  r1=r1+1;end
r2=1;while y(r2)<0.9;  r2=r2+1;end
rise_time1=(r2-r1)*0.005 %obtaining the rise time
[ymax,tp]= max(y); %remember peak time is the time required to peak
peak_time1=(tp-1)*0.005 %obtaining the peak time
max_overshoot1=ymax-1
s=1001; while y(s)>0.98 && y(s)<1.02; s=s-1;end
settling_time1=(s-1)*0.005

%2nd system
num=[6.3223 18 12.811]; den=[1 6 11.3223 18 12.811]; 
t=0:0.02:20;
sys=tf(num,den);
[y,x,t]=step(num,den,t); 
figure
plot(t,y)
grid on; title('unit step response 2nd');
r1=1;while y(r1)<0.1, r1=r1+1;end
r2=1;while y(r2)<0.9,  r2=r2+1;end
rise_time2=(r2-r1)*0.02; %rise time is time required for output to rise from 
%10% to  90% of final output value
[ymax, tp]=max(y);
peak_time2=(tp-1)*0.02
max_overshoot2=ymax-1;
s=1001; while y(s)>0.98 && y(s)<1.02; s=s-1; end
settling_time2=(s-1)*0.02

%third system
num=[6]; den=[1 6 11 6]; sys=tf(num,den);
t=0:0.01:30;
[y,t]=step(sys,t);
figure
plot(t,y) 
grid on
title('step response last');
%obtaining perfomance parameters
r1=1; while y(r1)<0.1, r1=r1+1; end
r2=1; while y(r2)<0.9, r2=r2+1;end
rise_time3=(r2-r1)*0.01
[ymax tp]=max(y);
peak_time3=(tp-1)*0.01
max_overshoot3=ymax-1
s=1001; while y(s)>0.98 && y(s)<1.02; s=s-1;end
setlling_time3=(s-1)*0.01


%EXTRAS
 num=[25 35 45]; den=[1 6 25];
 t=0:0.01:10;
 sys=tf(num,den);
 [y,t]=step(sys,t);
 plot(t,y)%to use plot, vectors must  be of the same length.Use [y t] and
 %[y x t] appropriately
 
 for i=1:k
    
    num=[a(i)];
    den=[1 b(i) a(i)];
    sys=tf(num,den);
    
    y(:,i)=step(sys,t);
%     hold on
%     grid on
%     pause (1)
end

 
 
