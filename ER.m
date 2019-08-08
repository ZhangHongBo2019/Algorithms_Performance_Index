%function e=ER(Population, Generation )
%load SPCT.mat;
temp=zeros(1,30);
gen=30;
nn=size(ObjV1);
for k=1:1:gen
[chromosome,V]=nsga_2_optimization(800,800);
N=size(chromosome,1);
func = chromosome(:, V+1 : V+3);
e=ones(1,N);
for i=1:N
    for j=1: nn
    if(func(i,:)==ObjV1(j,:))
        e(i)=0;
        break
    end
    end
end
temp(1,k)=sum(e)/nn;
end
MaxER=max(temp);
MinER=min(temp);
MeanER=mean(temp);
StdER=std(temp);
%disp(['ER的值为:',num2str(e)]);
figure;
plot(1:gen,temp(1,:),'ro-');
xlabel('次数');ylabel('ER 值');
title("算法30次独立运行求得的ER指标统计数据比较");
%end