% drawPath.m - (Draw Path)
% �ڳ�������ͼ�ϻ�·���켣
%       Syntax:
%               drawPath(fh,axh,Dxy,P)
%
% ���룺
%   fh      -figure���
%   axh   -axes���
%   Dxy   -�����������
%   P       -����·������
%
% �����
%   ·���켣ͼ

% Author: WKDuan
% Date: 17/7/2014

function drawPath(fh,axh,Dxy,P)

%��axh�����л����������꣬����ע���
figure(fh)
axes(axh)
hold on

% ����·����·����·������ĳ����������
P=[P P(1)];                  % ��·���еĵ�һ�����мӵ�·���������
R=Dxy(P,:);                 % ����·������P�������ɳ����������R���þ���Ԫ���ǰ�·��˳������

% ����·��P��axh�б�ע��ʼ����
plot(axh,R(1,1),R(1,2),'rv','MarkerSize',10);           % ��ע��ʼ����

% ��·���켣
n=size(R,1);            % ·���г�����Ŀ
for i=2:n
        [arrowX arrowY]=dsxy2figxy(gca,R(i-1:i,1),R(i-1:i,2));
        annotation(fh,'textarrow',arrowX,arrowY,'LineWidth',1.2,'HeadWidth',6,'color',[0 0 1]);
end
xlabel('������')
ylabel('������')
legend('����','��ʼ����',4)
% end of function



