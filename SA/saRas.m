clear
clc
ObjectiveFunction=@Rastrigin;                 % Ŀ�꺯�����
X0=[-2.5 2.5];                                              % ��ʼֵ
lb=[-5 -5];                                                  % �����½�
ub=[5 5];                                                    % �����Ͻ�
options=saoptimset('MaxIter',500,'StallIterLim',500,'TolFun',1e-10,'AnnealingFcn',@annealingfast,...
    'InitialTemperature',100,'TemperatureFcn',@temperatureexp,'ReannealInterval',500,...
    'PlotFcns',{@saplotbestx,@saplotbestf,@saplotx,@saplotf});
[x,fval]=simulannealbnd(ObjectiveFunction,X0,lb,ub,options);