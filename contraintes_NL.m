function [ceq,cineq]=contraintes_NL(x)
% Contraintes relatives aux rampes
global rampeDown24 rampeUp24
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

ceq=[]

