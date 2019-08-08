function X1 = decode(X)
for i = 1:size(X,1)
    idx = floor(X(i,1:16));
x = zeros(1,46);
 %temp = [0,3,5,7,9,12,15,18,24,27,31,33,36,39,41,43];
 temp = [0,3,5,7,9,12,15,18,22,26,30,33,36,39,41,44];
x(idx(idx>0)+temp) = 1;
 X1(i,:) = x;
end