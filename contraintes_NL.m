function [ceq,cineq]=contraintes_NL(x)
global rampeDown24 rampeUp24
for k=1:12*24
    cineq(k)=x(k+1)-x(k)-rampeUp24(k);
    cineq(k+12*24)=x(k)-rampeDown24(k)-x(k+1);
end
% LES 576 premi�res lignes sont utilis�es

