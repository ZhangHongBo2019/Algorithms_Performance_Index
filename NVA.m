%NVA
N=200;
trace=zeros(1,N+1);
for i=1:1:(N+1)
[Chromosome,V]=nsga_2_optimization(100+(i-1),100+(i-1));
trace(1,i)=size(Chromosome,1);
end
figure
plot(1:(N+1),trace(1,:));
