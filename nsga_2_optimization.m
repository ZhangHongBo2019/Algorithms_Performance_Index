function [Chromosome,V]=nsga_2_optimization(Population,Generation)
%非支配排序遗传算法求解服务模块组合优化问题,三个目标的装修问题
tic;
%% 设置参数
%Population=100;
%Generation=300;                 
Crate = 0.9;                
Mrate = 0.01;
M=3;%三个目标函数
V=16;%16个模块
%% 产生一个初始种群
BaseV=[3,2,2,2,3,3,3,4,4,4,3,3,3,2,3,2];
Chromp=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],Population,1);   
Chrom= NONLCON(Chromp);
ObjV1=fitness(Chrom);  
x=[Chrom,ObjV1];
%% 初始种群的
%figure(1)
%plot3(ObjV1(:,1),ObjV1(:,2),-ObjV1(:,3),'*');
%xlabel('Service cost'); ylabel('Response time');zlabel('Service performance');
%title('Initial population');
f = non_domination_sort_mod(x, 3, 16);
Chrom = f(:,1:16);
gen=1;
%% 开始迭代
while gen<=Generation
    pool=round(Population/2);
    tour=2;
    Parent_Chromosome=tournament_selection(f, pool, tour);
    SelCh=Parent_Chromosome(:,1:16);
    SelCh=recombin('xovsp',SelCh,Crate);%重组单点交叉
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[3,2,2,2,3,3,3,4,4,4,3,3,3,2,3,2]];
    SelCh=mutbga(SelCh, fv,Mrate);
    SelCh=fix(SelCh);%变异
    SelCh1= NONLCON(SelCh);
    Chrom = [Chrom;SelCh1];
    Chrom= NONLCON(Chrom);
    ObjV=fitness(Chrom);%计算初始种群函数值
    x=[Chrom,ObjV];
    f = non_domination_sort_mod(x, 3, 16);
    f=replace_chromosome(f, M, V,Population);
    Chrom = f(:,1:16);
    disp(['第',num2str(gen),'代']);
    gen=gen+1;
end
figure(1);
ObjV1 = f(f(:,20)==1,17:19);
plot3(ObjV1(:,1),ObjV1(:,2),-ObjV1(:,3),'*r');
grid on
set(gca,'gridlinestyle','-.');
xlabel('Service cost'); ylabel('Response time');zlabel('Service performance'); 
title('Pareto solution set');
Chromosome=f(f(:,20)==1,1:21);
%Chromosome=f(:,1:21);
%BestParetoSet=decode(Chromosome);
%BestParetoSet(:,47:48)=Chromosome(:,17:18);
%BestParetoSet(:,49)=-Chromosome(:,19);
toc;
end