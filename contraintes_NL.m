function [ceq,cineq]=contraintes_NL(x)
% Contraintes relatives aux rampes
global rampeDown24 rampeUp24 Demand p_min24 p_max24 resPos24 resNeg24
for k=1:12*24
    cineq(k)=x(k+1)-x(k)-rampeUp24(k);
    cineq(k+12*24)=x(k)-rampeDown24(k)-x(k+1);
end
% Les 576 premières lignes sont utilisées

% Contraintes relatives aux temps de fonctionnement
global minimumDownTime minimumUpTime
Temps2Fonctionnement=temps_fonctionnement(x);
for k=1:12
    cineq(k+576)=-minimumDownTime(k)+Temps2Fonctionnement(k);
    cineq(k+12+576)=-minimumUpTime(k)+Temps2Fonctionnement(k+12);
end

% Contraintes relatives aux rampes initiales
for k=1:12
    for i=1:24:288
        cineq(end+1)=x(i)-rampeUp24(i)-Pinit(k);
        cineq(end+1)=Pinit(k)-rampeDown24-x(i);
    end
end

% Contraintes relatives à l'état de fonct. des machines
E=fct_etat(x);
for k=1:12
<<<<<<< HEAD
    for i=1:24  
=======
    for i=1:24
>>>>>>> 5b39d580f5d84004f0637e27c749c8f0a42722be
    cineq(600+24*(k-1)+i)=x(24*(k-1)+i) - E(24*(k-1)+i)*p_max24(24*(k-1)+i);
    cineq(600+288+24*(k-1)+i)=-(x(24*(k-1)+i) - E(24*(k-1)+i)*p_min24(24*(k-1)+i));
    
    cineq(600+24*(k-1)+i)=x(24*(k-1)+i+288) - E(24*(k-1)+i)*resPos24(24*(k-1)+i);
    
    cineq(600+24*(k-1)+i)=x(24*(k-1)+i+288*2) - E(24*(k-1)+i)*resNeg24(24*(k-1)+i);
    end
end

% Contraintes pour la satisfaction de la demande
P = x(1:12*24); %puissances de chaque machine pour chaque heure
Rpos = x(12*24+1:12*24*2); % réserves pos de chaque machines pour chaque heure
Rneg = x(12*24*2+1:12*24*3); % réserves neg de chaque machines pour chaque heure
for k=1:24
    ceq(k)=sum(P(k:24:12*24)) + sum(Rpos(k:24:12*24)) - sum(Rneg(k:24:12*24)) - Demand(k);
end

end
