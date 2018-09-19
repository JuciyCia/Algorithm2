% distance(md).m
% �ú����������MD����ʾ�ĵ�֮��ľ���
%       Syntax:
%               D=distance(MD)
%
% ���룺
%    MD  -�������
%
% �����
%    D     -����������󣬶Խ���Ԫ��Ϊ0

% Author: WKDuan
% Date: 17/7/2014

function D=distance(MD)
n = size(MD,1);                             % �����Ŀ
D=zeros(n,n);                                % ��ʼ�����������
for i=1:n
    for j=i+1: n
        D(i,j)=((MD(i,1)-MD(j,1))^2+(MD(i,2)-MD(j,2))^2)^0.5;
        D(j,i)=D(i,j);
    end
end

% end function