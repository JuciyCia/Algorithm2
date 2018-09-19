% metropolis.m
% ��metropolis׼������½�
%
%       �﷨
%                [S,R]=metropolis(S1,S2,D,T)
% ����
%  S1      -��ǰ��
%  S2      -�½�
%  D       -�����м�������
%  T        -��ǰ�¶�
%
%  ���
%  S        -��һ����ǰ��
%  R        -��һ����ǰ���·�߾���

function [S,R]=metropolis(S1,S2,D,T)
R1=pathLength(D,S1);                    % ����·�߳���
n=length(S1);                                  % ������Ŀ

R2=pathLength(D,S2);
dc=R2-R1;
if dc<0
    S=S2;
    R=R2;
elseif exp(-dc/T)>=rand
    S=S2;
    R=R2;
else
    S=S1;
    R=R1;
end