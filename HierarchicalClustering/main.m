%% 2d����������
% X����Ϊ100����Ϊ2d��������������������Է�����̬�ֲ���MU=[5 5]����ָ��Э������󡣴�0~10
clear all;clc;
close all;
MU = [5 5];
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
cppProgram = 'Hclustering.exe';
input = [cppProgram,blanks(2),OutputPath];
 if(dos(input)~=1)
    display('����ʧ��\n');
 end
%% ������ͼ��C++���ɵ��ļ�
clear;clc;
close all;
num=100;

Y=load('out.txt');

%% draw
dendrogram(Y);
title('�����Ӳ�ξ���')