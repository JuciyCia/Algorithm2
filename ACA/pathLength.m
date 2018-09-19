% pathLength.m
% ����·���ܳ���
%       Syntax:
%               len=pathLength(D,P)
%
% ���룺
%   D    -����������
%   P     -·������
% �����
%   len  -·���ܳ���

% Author: WKDuan
% Date: 17/7/2014

function len=pathLength(D,P)
R=[P,P(1)];                         % ��·���е����ӵ�����γɻ�·
len=0.0;
n=length(R);
for i=2:n
    len=len+D(R(i-1),R(i));
end

% end of function

