function GD = GD_matlab(PF, truePF)

q = 2; %the parameter of GD
%STEP 1. Obtain the maximum and minimum values of the Pareto front
m1 = size(PF, 1);
m = size(truePF, 1);
maxVals = max(truePF);
minVals = min(truePF);

%STEP 2. Get the normalized front
normalizedPF = (PF - repmat(minVals, m1, 1)) ./ repmat(maxVals - minVals, m1, 1);
normalizedTruePF = (truePF - repmat(minVals, m, 1)) ./ repmat(maxVals - minVals, m, 1);

%STEP 3. Sum the distances between each point of the front and the nearest point in the true Pareto front
GD = 0;
for i = 1:m1
    diff = repmat(normalizedPF(i,:), m, 1) - normalizedTruePF;
    dist = sqrt(sum(diff.^2, 2));         
    GD = GD + min(dist)^q;
end
GD = GD^(1.0/q)/m1;

end