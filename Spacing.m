%function Score = Spacing(PopObj,PF)
% <metric> <min>
% Spacing

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

N=30;
trace=zeros(1,N);
for i=1:N
    [chromosome,V]=nsga_2_optimization(50,50);
    PopObj = chromosome(:, V + 1 : V + 3);
    Distance = pdist2(PopObj,PopObj,'cityblock');
    Distance(logical(eye(size(Distance,1)))) = inf;
    trace(1,i)= std(min(Distance,[],2));
end
MaxSpacing=max(trace);
MinSpacing=min(trace);
AveSpacing=mean(trace);
StdSpacing=std(trace);
disp(['30次的Spacing的最大值为:',num2str(MaxSpacing)]);
disp(['30次的Spacing的最小值为:',num2str(MinSpacing)]);
disp(['30次的Spacing的平均值为:',num2str(AveSpacing)]);
disp(['30次的Spacing的标准差为:',num2str(StdSpacing)]);
plot(1:N,trace(1,:),"r*-");
xlabel("次数");ylabel("Spacing 值");
title("30次的Spacing值的变化");
%end