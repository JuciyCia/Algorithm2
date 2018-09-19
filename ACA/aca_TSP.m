%% ��ջ�������

clear all
close all
clc

tic
%% ������������ļ���citydata.xls�����õ������������cityaxes
citydata=importdata('citydata.xls'); 
Cityaxes=citydata.data.Sheet1;
ncity=size(Cityaxes,1);

%% ���ݳ����������Cityaxes�������е�ͼ
lb=floor(min(Cityaxes));                  % ������СX��Y���꣬����ȡ��
ub=ceil(max(Cityaxes));                   % �������X��Y���꣬����ȡ��
Tick=[lb(1) ub(1) lb(2) ub(2)];

% �����·�ߵ�figure��axes
fh1=figure(1);
axh1=axes();
axis(Tick);
title('���·�߹켣ͼ')

% ������·�ߵ�figure��axes
fh2=figure(2);
axh2=axes();
axis(Tick)
title('���Ž�켣ͼ')

% ������̾���
fh3=figure(3);
axh3=axes();
xlabel('��������')
ylabel('����')
title('������̾���')

%% ��axh1�����л������е�ͼ
drawMap(axh1,Cityaxes);

%% ����ʼ�⣨���·�ߣ��켣
S1=randperm(ncity);                       % �������һ����ʼ�⣨���·�ߣ�
drawPath(fh1,axh1,Cityaxes,S1);      %����ʼ�⣨���·�ߣ��켣

%% ������м��໥���루���о������Citydist�Խ�����Ԫ����Ϊ1e-4���Ա��ڼ�������������
Citydist=zeros(ncity,ncity);
for i=1:ncity
    for j=1:ncity
        if (i~=j)
            Citydist(i,j)=sqrt((Cityaxes(i,1)-Cityaxes(j,1)).^2+(Cityaxes(i,2)-Cityaxes(j,2)).^2);
        else
            Citydist(i,j)=1e-4;
        end
    end
end

%%  ��Command Window �����ʼ���·��
Plength=pathLength(Citydist,S1);                       % �����ʼ·���ܳ���
disp('���·��')
outputPath(S1);                                                 % �����ʼ·��
disp(['�ܾ��룺',num2str(Plength)]);                   % �����ʼ·���ܳ���

%% ��ʼ������
nant= ncity;                                                        % ��������
alpha=1;                                                             % ��Ϣ����Ҫ�̶�����
beta = 5;                                                             % ����������Ҫ�̶�����
rho=0.1;                                                              % ��Ϣ�ػӷ�����
Q=1;                                                                   % ��ϵ��
Eta=1./Citydist;                                                   % ��������
Tau=ones(ncity,ncity);                                        % ��Ϣ�ؾ���
Route=zeros(nant,ncity);                                    % ·����¼��
iter=1;                                                                 % ����������ֵ
iter_max=200;                                                     % ����������
Route_best=zeros(iter_max,ncity);                     % �������·��
Len_bestRoute=zeros(iter_max,1);                     % �������·���ĳ���
Avg_Route=zeros(iter_max,1);                           % ����·����ƽ������

%% ����Ѱ�����·��
disp(['������ɴ�����'])
while iter<=iter_max
    % ��������������ϵ�������
    Start=zeros(nant,1);
    Temp=randperm(ncity);
    Start(:,1)=Temp(1,1:nant);
    Route(:,1)=Start;
        
    % ������ռ䣨���б�ţ�
    Index_city=1:ncity;
    % �������·��ѡ��
    for i=1:nant
        % �������·��ѡ��
        for j=2:ncity
            Tabu=Route(i,1:(j-1));                                            % �ѷ��ʳ��м��ϣ����ɱ�
            Logic_allow=~ismember(Index_city,Tabu);           % �����ʳ����߼�������1-�����ʣ�0-�ѷ��ʣ�
            Allow=Index_city(Logic_allow);                             % �����ʵĳ��м���
                                                             
            % ������м�ת�Ƹ��ʣ��ӽ��ɱ�Tabu�����һ��Ԫ�ص������ʱ�Allow�и�Ԫ�صĸ��ʣ�
            P=zeros(1,length(Allow));                                               
            for k=1:length(Allow)
                P(k)=(Tau(Tabu(end),Allow(k)))^alpha*(Eta(Tabu(end),Allow(k)))^beta;
            end
            P=P/sum(P);
            
            % ���̶ķ�ѡ����һ�����ʳ���
            Pc=cumsum(P);                                      % �ۼ�ֵ
            Index_target=find(Pc>=rand);               % �ۼ�ֵ��С�������������
            target=Allow(Index_target(1));               % ��ת�Ƶ��ĳ��б��
            Route(i,j)=target;
        end
    end
    
    % ��������ϵ�·�����루����㵽���������лص����ľ��룩
    Len_path=zeros(nant,1);
    for i=1:nant
        Path=Route(i,:);
        for j=1:ncity-1
            Len_path(i)=Len_path(i)+Citydist(Path(j),Path(j+1));
        end
         Len_path(i)=Len_path(i)+Citydist(Path(ncity),Path(1));
    end
    
    % �������·�����뼰ƽ������
    if iter==1
        [min_length,min_index]=min(Len_path);     % min_index - ���ϱ�ţ�min_length - ���Ϊmin_index�����ϵ�·������
        Len_bestRoute(iter)=min_length;
     %   Avg_Route(iter)=mean(Len_Path);
        Route_best(iter,:)=Route(min_index,:);
    else
        [min_length,min_index]=min(Len_path);     % ���������·�����ȼ����ϱ��
        Len_bestRoute(iter)=min(Len_bestRoute(iter-1),min_length);  % ��������iter���������·��������Ϊ��������һ�������·�����ȵ���Сֵ
       % Avg_Route(iter)=mean(Len_Path)               
       
        if  Len_bestRoute(iter)==min_length
            Route_best(iter,:)=Route(min_index,:);
        else
            Route_best(iter,:)=Route_best((iter-1),:);
        end
    end
    
    % ������Ϣ��
    Delta_tau=zeros(ncity,ncity);
    
    % ������ϼ���
    for i=1:nant
        for j=1:(ncity-1)
            Delta_tau(Route(i,j),Route(i,j+1))=Delta_tau(Route(i,j),Route(i,j+1))+Q/Len_path(i);
        end
        Delta_tau(Route(i,ncity),Route(i,1))=Delta_tau(Route(i,ncity),Route(i,1))+Q/Len_path(i);
    end
    
    Tau=(1-rho)*Tau+Delta_tau;              % ������Ϣ��
    
    % �����������   
    fprintf(1,'%d  ',iter);
     if mod(iter,25)==0
        fprintf(1,'\n');
    end;
    
    % ����������1�����·����¼��
    iter=iter+1;
    Route=zeros(nant,ncity);
end
fprintf(1,'\n');

%%  ��Command Window ������Ž�·��
[length_shortest,index]=min(Len_bestRoute);
Route_shortest=Route_best(index,:);                           % ����·��
Plength=pathLength(Citydist,Route_shortest);            % ��������·���ܳ���
disp('����·��')
outputPath(S1);                                                            % �������·��
disp(['�ܾ��룺',num2str(Plength)]);                             % �������·���ܳ���

%% ������·��ͼ
drawMap(axh2,Cityaxes);
drawPath(fh2,axh2,Cityaxes,Route_shortest);

%% ������̾���ͼ
axes(axh3);
hold on
plot(1:iter_max,Len_bestRoute');
toc
