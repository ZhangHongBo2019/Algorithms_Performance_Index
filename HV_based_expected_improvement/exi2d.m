function res=exi2d(P,r,mu,s)
% P: approximation set 2xK, r: reference point, mu: mean vector, s:stdev
% vector
% Example: exi2d([0,2;1,1;2,0],[3,3],[0,0],[0.1,0.1]) should approximately
% result in 3
% 
% determine all lower left corner cell coordinates
S=sortrows(P);
k=length(S);

c2 = sort(S(:,2));
c1 = sort(S(:,1));

for i=0:k     % hoogte van beneden naar boven; hight from below to above
    for j=0:(k-i) % first coordinate (length) of cell grid
        % c1(i), c2(j) are now the cell coordinates according Fig. 2   
        % For coordinate j determine hight fMax2 
        if (j==0) fMax2=r(2); else fMax2 = c2(k+1-j); end;
        % For coordinate i determine the width of the staircase fMax1 
        if (i==0) fMax1=r(1); else fMax1 = c1(k+1-i); end;
        % get cell coordinates
        if (j==0) cL1= -inf; else cL1 = c1(j); end; 
        if (i==0) cL2= -inf; else cL2 = c2(i); end;
        if (j==k) cU1 = r(1); else cU1 = c1(j+1); end;
        if (i==k) cU2 = r(2); else cU2 = c2(i+1); end;
        % SM = points that are dominated or equal to upper cell bound  
        SM=[;]; 
        for m=1:k
            if (cU1 <= S(m,1) && cU2 <= S(m,2))
                SM=[[S(m,1),S(m,2)];SM];
            end             
        end
        sPlus = hvolume2d(SM, [fMax1,fMax2]);
        %Marginal integration over the length of a cell
        Psi1 = exipsi(fMax1,cU1,mu(1),s(1)) - exipsi(fMax1,cL1,mu(1),s(1));
        %Marginal integration over the height of a cell
        Psi2 = exipsi(fMax2,cU2,mu(2),s(2)) - exipsi(fMax2,cL2,mu(2),s(2));
        %Cumulative Gaussian over length for correction constant
        GaussCDF1 = gausscdf((cU1-mu(1))/s(1)) - gausscdf((cL1-mu(1))/s(1));
        %Cumulative Gaussian over length for correction constant
        GaussCDF2 = gausscdf((cU2-mu(2))/s(2)) - gausscdf((cL2-mu(2))/s(2));
        %ExI Kontribution fuer die aktuelle Zelle
        c(i+1,j+1)= Psi1*Psi2-sPlus*GaussCDF1*GaussCDF2;
    end
end

res=sum(sum(max(c,0)));
