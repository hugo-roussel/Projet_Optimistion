<<<<<<< HEAD
function Etat=fct_etat(x)
Etat=(x(1:12*24)>0)
Etat=(x(1:12*24>
=======
function Etat=fct_etat(x) %renvoie l'etat de fonctionnement des machines à toutes heures
global p_min24
% Etat = (x(1:12*24)>0);
>>>>>>> 9fcdabb16d1adfdbb7df08ee8ee4f8ed22900023

Etat = (x(1:12*24)>p_min24);
end