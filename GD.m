%function Score = GD(PopObj,PF)
% <metric> <min>
% Generational distance

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
load SPCT.mat;
temp=0;
N=30;
n=size(ObjV,1);
trace=zeros(1,N);
for i=1:N
[chromosome,V]=nsga_2_optimization(50,50);
PopObj= chromosome(:, V+1 : V+3);
Distance = min(pdist2(PopObj,ObjV),[],2);
trace(1,i)= norm(Distance) / length(Distance);
end
MaxGD=max(trace);
MinGD=min(trace);
AveGD=mean(trace);
StdGD=std(trace);
disp(['30次的GD的最大值为:',num2str(MaxGD)]);
disp(['30次的GD的最小值为:',num2str(MinGD)]);
disp(['30次的GD的平均值为:',num2str(AveGD)]);
disp(['30次的GD的标准差为:',num2str(StdGD)]);
figure
plot(1:N,trace(1,:),"b*-");
%end