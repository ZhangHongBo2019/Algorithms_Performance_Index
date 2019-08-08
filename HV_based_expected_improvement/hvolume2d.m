function h=hvolume2d(P,x)
    S=sortrows(P);
    h=0;
    if (not(length(P))==0)
        k=length(S(:,1));
        for i=1:k
            if(i==1)
                h= h + (x(1)-S(i,1)) *  (x(2)-S(i,2));
            else
                h= h + (x(1)-S(i,1)) *  (S(i-1,2)-S(i,2));
            end
        end
    end

       

