function Etat=fct_etat(x) %renvoie l'etat de fonctionnement des machines � toutes heures
global p_min24
% Etat = (x(1:12*24)>0);

Etat = (x(1:12*24)>p_min24);
end