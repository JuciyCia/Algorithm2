% newPath.m
% �����½⣨·��������
%       �﷨��
%               function S2=newPath(S1)
%
% ���룺
% S1    -��ǰ�⣨·����
%
% �����
% S2    - �½⣨·����
%
% Author:
% Date:

function S2=newPath(S1)
n=length(S1);
S2=S1;
a=round(rand(1,2)*(n-1)+1);            % �����������λ����������
w=S2(a(1));
S2(a(1))=S2(a(2));
S2(a(2))=w;                                      % �õ�һ����·��

% end of function