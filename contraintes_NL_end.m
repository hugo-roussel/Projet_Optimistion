function [cineq,ceq]=contraintes_NL_end(x)
% Contraintes relatives aux rampes
global rampeDown24 rampeUp24 Demand p_min24 p_max24 resPos24 resNeg24 Pinit
cineq=[];
ceq=[];

for k=1:12*24
    cineq(end+1)=x(k+1)-x(k)-rampeUp24(k);
    cineq(end+1)=x(k)-rampeDown24(k)-x(k+1);
end
% Les 576 premi�res lignes sont utilis�es

% Contraintes relatives aux temps de fonctionnement
global minimumDownTime minimumUpTime
Temps2Fonctionnement=temps_fonctionnement(x);
% for k=1:12
%     cineq(end+1)=-minimumDownTime(k)+Temps2Fonctionnement(k);
%     cineq(end+1)=-minimumUpTime(k)+Temps2Fonctionnement(k+12);
% end
% 
% Contraintes relatives aux rampes initiales
for k=1:12
    for i=1:24:288
        cineq(end+1)=x(i)-rampeUp24(i)-Pinit(k);
        cineq(end+1)=Pinit(k)-rampeDown24(i)-x(i);        
    end
end
<<<<<<< HEAD
% 
% % Contraintes relatives � l'�tat de fonct. des machines
% E=fct_etat(x);
% for k=1:12
%     for i=1:24
%         
%         cineq(end+1)=x(24*(k-1)+i) - E(24*(k-1)+i)*p_max24(24*(k-1)+i);
%         cineq(end+1)=-(x(24*(k-1)+i) - E(24*(k-1)+i)*p_min24(24*(k-1)+i));
%         
%         cineq(end+1)=x(24*(k-1)+i+288) - E(24*(k-1)+i)*resPos24(24*(k-1)+i);
%         
%         cineq(end+1)=x(24*(k-1)+i+288*2) - E(24*(k-1)+i)*resNeg24(24*(k-1)+i);
%         
%     end
% end
% 
=======

% Contraintes relatives � l'�tat de fonct. des machines
E=fct_etat(x);
for k=1:12
    for i=1:24
        cineq(end+1)=x(24*(k-1)+i) - E(24*(k-1)+i)*p_max24(24*(k-1)+i);
        cineq(end+1)=-(x(24*(k-1)+i) - E(24*(k-1)+i)*p_min24(24*(k-1)+i));
        
        cineq(end+1)=x(24*(k-1)+i+288) - E(24*(k-1)+i)*resPos24(24*(k-1)+i);
        
        cineq(end+1)=x(24*(k-1)+i+288*2) - E(24*(k-1)+i)*resNeg24(24*(k-1)+i);
        
        cineq(end+1)=x(24*(k-1)+i) + x(24*(k-1)+i+288) - p_max24(24*(k-1)+i);
    end
end
>>>>>>> 279fbe8272e08108a2c71d4875c3e85ec9af6333

% Contraintes pour la satisfaction de la demande
P = x(1:12*24); %puissances de chaque machine pour chaque heure
R = x(12*24+1:12*24*2); % r�serves pos de chaque machines pour chaque heure

for k=1:24
<<<<<<< HEAD
    ceq(k)=sum(P(k:24:12*24)) + sum(R(k:24:12*24)) - Demand(k);
=======
    ceq(k)=sum(P(k:24:12*24)) + sum(Rpos(k:24:12*24)) - sum(Rneg(k:24:12*24)) - Demand(k)
>>>>>>> 279fbe8272e08108a2c71d4875c3e85ec9af6333
end

end
