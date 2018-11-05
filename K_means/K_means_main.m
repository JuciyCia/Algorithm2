%% 2d����������
% X����Ϊ100����Ϊ2d��������������������Է�����̬�ֲ���MU=[5 5]����ָ��Э������󡣴�0~10
clear all;clc;
close all;
MU = [5 3];
SIGMA = [1 0 ; 
         0 1];
num = 100;
OutputPath = 'points.txt';

X = mvnrnd(MU,SIGMA,num);%�������ʸ��
% �����ļ�·��
fid = fopen(OutputPath,'w');
for i=1:num
    fprintf(fid,'%f %f \n',X(i,1),X(i,2));
end
%% C++����
cppProgram = 'K_means.exe';
input = [cppProgram,blanks(2),OutputPath];
 if(dos(input)~=1)
    display('����ʧ��\n');
 end
%% ������ͼ��C++���ɵ��ļ�
clear;clc;
close all;
num=100;

Y=load('out.txt');
Je=load('out2.txt');
hold on;

[m,n]=size(Y);
k1=1;k2=0;
cnt=1;% �任����ʽ
hold on;

xlim=[0,10];
ylim=[0,10];
title('�������');
s=['r*';'b*';'g*';'m*';'y*'];%����ʽ�л�
for i=1:m
    if i==100
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(cnt,:));
        break;
    end
    if Y(i,1)~=Y(i+1,1)
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(cnt,:));
        cnt=cnt+1;
    end
end
hold off;
figure();
plot(Je,'r');
title('Je');
 
