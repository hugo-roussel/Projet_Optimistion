function f=cout(x)
global OperationalCost resCostPos24 resCostNeg24 StartUpCost Pinit A
E=fct_etat(x);
% coût lié à la production d'énergie
cout_ope = x(1:12*24)*A';

% coûts liés à l'utilisation de réserves positives & négatives
cout_res=0;
% for i=1:288
%     if x(i+288)>=0
%         cout_res=cout_res+x(i+288)*resCostPos24(i);
%     else
%         cout_res=cout_res+x(i+288)*(-resCostNeg24(i));
%     end
% end

cout_dem=0;
% coût lié au démarrage
dem = zeros(1,12); % compte le nombre de démarrage
for i=1:12 % boucle sur les machines
    for k=1:24 % boucle sur les heures
        if k==1 && x(24*(i-1)+k) >0
            if Pinit(i)==0
                dem(i) = dem(i) + 1;
            end
        end
        if k~=1 && x(24*(i-1)+k) >0
            if x(24*(i-1)+k-1) == 0
                dem(i) = dem(i) + 1;
            end
        end
    end
end
cout_dem = dem*StartUpCost;

% coût total
f = cout_ope+ cout_res + cout_dem;
end