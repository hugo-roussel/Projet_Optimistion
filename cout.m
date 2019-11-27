function f=cout(x)
global OperationalCost resCostPos24 resCostNeg24 StartUpCost Pinit
% co�t li� � la production d'�nergie
cout_ope = x(1:12*24)*repmat(OperationalCost,24,1);

% co�ts li�s � l'utilisation de r�serves positives & n�gatives
cout_res_pos = x(12*24+1:12*24*2)*resCostPos24;
cout_res_neg = x(12*24+1:12*24*2)*resCostNeg24;

% co�t li� au d�marrage
dem = zeros(1,12); % compte le nombre de d�marrage
for i=1:12 % boucle sur les machines
    for k=1:24 % boucle sur les heures
        if k==1 && x(24*(i-1)+k) ~=0
            if Pinit(i)==0
                dem(i) = dem(i) + 1;
            end
        end
        if k~=1 && x(24*(i-1)+k) ~= 0
            if x(24*(i-1)+k-1) == 0
                dem(i) = dem(i) + 1;
            end
        end
    end
end
cout_dem = dem*StartUpCost;

% co�t total
f = cout_ope + cout_res_pos + cout_res_neg + cout_dem;
end