% ģ���˻𷨽��TSP����
% ���룺
%  city.txt     -���������ı��ļ�
%
%  �����
%   ���·��ͼ������·��ͼ
%   �����·�����䳤�ȡ�����·�����䳤��

clear
clc
close all

%% ��ʼ��������
tic
Tinit=1500;               % ��ʼ�¶�
Tend=1e-3;              % ��ֹ�¶�
L=200;                      % ���¶��µĵ���������������
q=0.9;                      % ��������

%��ȡ���������ļ���city.txt�����õ�������������Dxy
%[Title,Dxy]=readData('city.txt'); 

% City=importdata('city.txt');
% Dxy=City.data;

citydata=importdata('citydata.xls');
Dxy=citydata.data.Sheet1;

% ���û�·��ͼ��axh1��axh2����������ʾ
lb=floor(min(Dxy));                  % ������СX��Y���꣬����ȡ��
ub=ceil(max(Dxy));                   % �������X��Y���꣬����ȡ��
Tick=[lb(1) ub(1) lb(2) ub(2)];  
% �����·�ߵ�figure��axes
fh1=figure(1);
axh1=axes();
axis(Tick);                                       % �������������С�����ֵ
title('���·�߹켣ͼ')

% ������·�ߵ�figure��axes
fh2=figure(2);
axh2=axes();
axis(Tick);                                       % �������������С�����ֵ
title('���Ž�켣ͼ')

% ���Ż����̵�figure��axes
fh3=figure(3);
axh3=axes();

 % ���ݳ�����������Dxy���������������������D
N=size(Dxy,1);                                %  �����������Ŀ
D=distance(Dxy);                            % ���������������������D

%% ��axh1�����л������е�ͼ
drawMap(axh1,Dxy);

%% ����ʼ�⣨���·�ߣ��켣
S1=randperm(N);                     % �������һ����ʼ�⣨���·�ߣ�
drawPath(fh1,axh1,Dxy,S1);      %����ʼ�⣨���·�ߣ��켣

%%  ��Command Window �����ʼ·��
Plength=pathLength(D,S1);                               % �����ʼ·���ܳ���
disp('���·��')
outputPath(S1);                                                 % �����ʼ·��
disp(['�ܾ��룺',num2str(Plength)]);                   % �����ʼ·���ܳ���

%%
%���������Times
Times=ceil(double(solve(['1000*(0.9)^x=',num2str(1e-3)])));
count=0;
Obj=zeros(Times,1);                         % Ŀ��ֵ�����ʼ��
track=zeros(Times,N);                      % ÿ��������·�߾����ʼ��

% ����
while Tinit>Tend
    count=count+1;
    temp=zeros(L,N+1);
    for k=1:L
        S2=newPath(S1);                         %�����½�
        [S1,R]=metropolis(S1,S2,D,Tinit); 
        temp(k,:)=[S1,R];                         % ��¼��һ·�߼�·�߳���
    end

    % ��¼ÿ�ε������̵�����·��
    [d0,index]=min(temp(:,end));          % ��ǰ�¶��µ�����·��
    if count==1 || d0<Obj(count-1)
        Obj(count)=d0;                           % �����ǰ�¶�������·��С����һ·�̣����¼��ǰ·��
    else
        Obj(count)=Obj(count-1);          % �����ǰ�¶�������·�̴�����һ·�̣����¼��һ·��
    end
    track(count,:)=temp(index,1:end-1);     % ��¼��ǰ�¶ȵ�����·��
    Tinit=q*Tinit;                                        %����
    fprintf(1,'%s','.')                                    % ����
end
fprintf(1,'������%d��\n',count)                 % �����ǰ��������
%% �Ż����̵���ͼ
figure(fh3);
axes(axh3);
plot(1:count,Obj)
xlabel('��������')
ylabel('����')
title('�Ż�����')

%% �����Ž�·��ͼ
drawMap(axh2,Dxy);
drawPath(fh2,axh2,Dxy,track(end,:));

%% ������Ž�·�ߺ��ܾ���
disp('���Ž�')
S=track(end,:);
p=outputPath(S);
disp(['�ܾ���:',num2str(pathLength(D,S))]);
disp('----------------------------------------------------------------')
toc

% end of program
