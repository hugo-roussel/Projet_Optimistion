function [ceq,cineq]=contraintes_NL(x)
global rampeDown24 rampeUp24
for k=1:2:12*24
    cineq(k)=x(k+1)-x(k)-rampeUp24(k);
    cineq(k+1)=x(k)-rampeDown24(k)-x(k+1);
end
