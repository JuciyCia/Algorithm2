% drawMap.m         -(Draw Map)
% ���ݳ������껭���е�ͼ
%       Syntax:
%               drawPath(axh,Dxy)
%
% ���룺
%   axh   -��������
%   Dxy   -�����������
%
% �����
%   ��������ͼ

% Author: WKDuan
% Date: 17/7/2014

function drawMap(axh,Dxy)

%��axh�����л����������꣬����ע���
axes(axh);
hold on
plot(axh,Dxy(:,1),Dxy(:,2),'ro');
for i=1:size(Dxy,1)
    text(Dxy(i,1)+0.2,Dxy(i,2)+0.2,num2str(i));
end
hold off
% end of function



