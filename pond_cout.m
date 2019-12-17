function cout=pond_cout(x)

global resCostPos24 resCostNeg24 StartUpCost Pinit CoutOPE nbr_heures

% co�t li� � la production d'�nergie
cout_ope = x(1:12*nbr_heures)*CoutOPE';

% co�ts li�s � l'utilisation de r�serves positives & n�gatives

logpos=x(12*nbr_heures+1:12*nbr_heures*2)>0;
costpos=x(12*nbr_heures+1:12*nbr_heures*2).*logpos*resCostPos24;
logneg=x(12*nbr_heures+1:12*nbr_heures*2)<0;
costneg=x(12*nbr_heures+1:12*nbr_heures*2).*logneg*(-resCostNeg24);

cout_res=costneg+costpos;

cout=cout_ope+cout_res;
end