function f=cout(x)
global OperationalCost resCostPos24 resCostNeg24 StartUpCost Pinit
% coût lié à la production d'énergie
cout_ope = x(1:12*24)*repmat(OperationalCost,24,1);

% coûts liés à l'utilisation de réserves positives & négatives
cout_res_pos = x(12*24+1:12*24*2)*resCostPos24;
cout_res_neg = x(12*24+1:12*24*2)*resCostNeg24;

% coût lié au démarrage
dem = zeros(1,12); % compte le nombre de démarrage
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

% coût total
f = cout_ope + cout_res_pos + cout_res_neg + cout_dem;
end