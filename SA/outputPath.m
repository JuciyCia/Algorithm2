% outputPath.m
% ��ʽ�����·��P
%
%       �﷨
%                R=outputPth(P)
%
% ���룺
%   P       -·������
%
% �����
%   R       -��ʽ��·������
%
% Author: WKDuan
% Date: 17/7/2014

function R=outputPath(P)
P=[P,P(1)];                         % ��·�����ӵ���󣬹��ɻ�·
n=length(P);
R=num2str(P(1));
for i=2:n
    R=[R,'->',num2str(P(i))];
end
disp(R)

% end of funtion

