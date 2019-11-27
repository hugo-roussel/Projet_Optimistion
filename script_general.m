%% Exportation des donn�es
[donnees,textes,lesdeux]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableaux2et3et4');

global Pinit InitState minimumUpTime minimumDownTime InitLength OperationalCost ReserveCostPos ReserveCostNeg StartUpCost rampeUp24 rampeDown24
p_min=donnees(:,4); % Puissance minimale 
p_max=donnees(:,5); % Puissance maximale
reservePos=donnees(:,6); % Capacit� de r�serve positive
reserveNeg=donnees(:,7); % Capacit� de r�serve n�gative
rampeUpRate=60*donnees(:,8); % Limite de variation de puissance UP
rampeDownRate=60*donnees(:,9); % Limite de variation de puissance DOWN
minimumUpTime=donnees(:,10); % Temps minimale de fonctionnement
minimumDownTime=-donnees(:,11); % Temps minimale d'arr�t
OperationalCost=donnees(:,12); % Cout de fonctionnelent
ReserveCostPos=donnees(:,13); % Cout de r�serve positive
ReserveCostNeg=donnees(:,14); % Cout de r�serve n�gative
StartUpCost=donnees(:,15); % Cout de d�marrage
Pinit=donnees(:,16); % Puissance production � l'instant initiale
InitState=donnees(:,17); % Etat de fonctionnement � l'instant initiale
InitLength=donnees(:,18); % Temps de fonctionnement ou d'arr�t � l'instant initiale
%% Structure du vecteur � optimiser
n(1)=12*24; % Relatif aux puissances
n(2)=12*24*2; % Relatif aux r�serves pos et neg
% n(3)=12*24; % Relatif aux �tats de fonctionnement (Utile ? avec les puissances on peut les r�cup)

% x=zeros(1,sum(n));
x=randi([0 1],1,12*24*4);
% Les 12*24 premi�res colonnes seront d�di�es aux puissances
% Les 12*24*2 aux r�servePos et reserve Neg
%% Contraintes
% Matrice contraintes de rampes de puissances
rampeUp24=[];
rampeDown24=[];
for i=1:12
    rampeUp24=[rampeUp24 ones(1,24)*rampeUpRate(i)];
    rampeDown24=[rampeDown24 ones(1,24)*rampeDownRate(i)];
end
rampeUp24=rampeUp24';
rampeDown24=rampeDown24';

% R�cup�rer le temps de fonctionnement 
"La fonction temps_fonctionnement s'en charge, utilis�e dans les contraintes_NL";

% 




