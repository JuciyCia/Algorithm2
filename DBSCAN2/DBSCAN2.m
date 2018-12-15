%% DBSCAN TEST 2
clear;clc;close all;
%% �������ݵ�浽�ļ���
%�ڰ뾶����������,Ӧ�÷ֳ�4�࣬���ε㣬�����������ɣ�һ��num��

[x1] = GenCyclicData(1,0.2,40);
[x2] = GenCyclicData(2,0.2,100);
[x3] = GenCyclicData(3,0.2,160);
[x4]=  GenCyclicData(4,0.2,200);

X = [x1;x2;x3;x4];

%DBSCAN.exe�������
num = 500;%��������ú�������ܺ�һ����
eps = '.75 ';
MinPits='7 ';
OutputPath = 'points.txt';
%д���ļ�
fid = fopen(OutputPath,'w');
for i=1:num
    fprintf(fid,'%f %f \n',X(i,1),X(i,2));
end

%% ���ó�����ദ��
cppProgram = 'DBSCAN.exe';
input = [cppProgram,blanks(2),OutputPath,blanks(2),MinPits,eps,blanks(2),num2str(num)]
 if(dos(input)~=1)
    display('����ʧ��\n');
 end
 
 
%% ������ͼ��C++���ɵ��ļ�


Y=load('out1.txt');
hold on;
[m,n]=size(Y);
k1=1;k2=0;
cnt=1;% �任����ʽ
hold on;

xlim=[0,10];
ylim=[0,10];

s=['r*';'b*';'g*';'k*';'y*';'m*';'c*'];%����ʽ�л�

for i=1:m
    if i==num
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(mod(cnt,6)+1,:));
        break;
    end
    if Y(i,1)~=Y(i+1,1)
        k1=k2+1;
        k2=i;
        scatter(Y(k1:k2,2),Y(k1:k2,3),s(mod(cnt,6)+1,:));
        cnt=cnt+1;
    end
end
str = ['DBSCAN������� ',' MinPits = ',MinPits,' eps = ',eps,'points num = ',num2str(num),' C= ',num2str(cnt-1)];
title(str);
hold off;