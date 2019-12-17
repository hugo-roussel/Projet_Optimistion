function [cineq,ceq]=contraintes_NL_end(x)
% Contraintes relatives aux rampes
global rampeDown24 rampeUp24 Demand p_min24 p_max24 resPos24 resNeg24 Pinit minimumDownTime minimumUpTime rampeDown23 rampeUp23
cineq=[];
ceq=[];

h=1;
for k=1:12*23-1
    if mod(k,23)==0
        h=h+2;
    else
        h=h+1;
    end
    cineq(end+1)=x(h+1)-x(h)-rampeUp23(k);
    cineq(end+1)=x(h)-rampeDown23(k)-x(h+1);
end
% Les 576 premières lignes sont utilisées

% Contraintes relatives aux temps de fonctionnement
% % Temps2Fonctionnement=temps_fonctionnement(x);
% for k=1:12
%     cineq(end+1)=-minimumDownTime(k)+Temps2Fonctionnement(k);
%     cineq(end+1)=-minimumUpTime(k)+Temps2Fonctionnement(k+12);
% end

% Contraintes relatives aux rampes initiales
i=1:24:288;
for k=1:12
    cineq(end+1)=x(i(k))-rampeUp24(i(k))-Pinit(k);
    cineq(end+1)=Pinit(k)-rampeDown24(i(k))-x(i(k));
end


% % Contraintes relatives à l'état de fonct. des machines
% E=fct_etat(x);
% for k=1:12
%     for i=1:24
%         
%         cineq(end+1)=x(24*(k-1)+i) - E(24*(k-1)+i)*p_max24(24*(k-1)+i);
%         cineq(end+1)=-(x(24*(k-1)+i) - E(24*(k-1)+i)*p_min24(24*(k-1)+i));
%         
%         cineq(end+1)=x(24*(k-1)+i+288) - E(24*(k-1)+i)*resPos24(24*(k-1)+i);
%         
% %         cineq(end+1)=x(24*(k-1)+i+288) - E(24*(k-1)+i)*resNeg24(24*(k-1)+i);
%         
%     end
% end

% % Contraintes pour la satisfaction de la demande
% P = x(1:12*24); %puissances de chaque machine pour chaque heure
% R = x(12*24+1:12*24*2); % réserves pos de chaque machines pour chaque heure
% 
% for k=1:24
%     ceq(k)=sum(P(k:24:12*24)) + sum(R(k:24:12*24)) - Demand(k);
% end

end
