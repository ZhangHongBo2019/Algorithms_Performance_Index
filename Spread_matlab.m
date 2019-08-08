%function spread = Spread_matlab(PF, truePF)
load SPCT.mat;
N=30;
trace=zeros(1,N);
for i=1:N
[chromosome,V]=nsga_2_optimization(100,100);
PF=chromosome(:, V+1 : V+3);
%STEP 1. Obtain the maximum and minimum values of the Pareto front
m1 = size(PF, 1);
m = size(ObjV, 1);
maxVals = max(ObjV);
minVals = min(ObjV);

%STEP 2. Get the normalized front
normalizedPF = (PF - repmat(minVals, m1, 1)) ./ repmat(maxVals - minVals, m1, 1);
normalizedTruePF = (ObjV - repmat(minVals, m, 1)) ./ repmat(maxVals - minVals, m, 1);

%STEP 3. Sort normalizedFront and normalizedParetoFront;
normalizedPF = sortrows(normalizedPF);
normalizedTruePF = sortrows(normalizedTruePF);

%STEP 4. Compute df and dl (See specifications in Deb's description of the metric)
diff = normalizedPF(1, :) - normalizedTruePF(1, :);
df = sqrt(sum(diff.^2, 2));
diff = normalizedPF(m1, :) - normalizedTruePF(m, :);
dl = sqrt(sum(diff.^2, 2));

%STEP 5. Calculate the mean of distances between points i and (i - 1). (the poins are in lexicografical order)
diff = normalizedPF(1:m1-1,:) - normalizedPF(2:m1,:);
distNears = sqrt(sum(diff.^2, 2));
meanVal = mean(distNears);

%STEP 6. If there are more than a single point, continue computing the metric. In other case, return the worse value (1.0, see metric's description).
if m1 > 1
    diversitySum = sum(abs(distNears - repmat(meanVal, m1-1, 1)));
    spread = (df +dl + diversitySum) / (df + dl + (m1-1) * meanVal);
else
    spread = 1.0;
end
trace(1,i)=spread;
end
Maxspread=max(trace);
Minspread=min(trace);
Avespread=mean(trace);
Stdspread=std(trace);
disp(['30次的spread的最大值为:',num2str(Maxspread)]);
disp(['30次的spread的最小值为:',num2str(Minspread)]);
disp(['30次的spread的平均值为:',num2str(Avespread)]);
disp(['30次的spread的标准差为:',num2str(Stdspread)]);
figure;
plot(1:N,trace(1,:),"r*-");
xlabel("次数");ylabel("spread 值");
title("30次运算的spread的值的变化");
%end