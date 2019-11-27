%% Exportation des donn�es
[donnees,textes,lesdeux]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableaux2et3et4');

global OperationalCost ReserveCostPos ReserveCostNeg StartUpCost
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
global Pinit
Pinit=donnees(:,16); % Puissance production � l'instant initiale
global InitState
InitState=donnees(:,17); % Etat de fonctionnement � l'instant initiale
global InitLength 
InitLength=donnees(:,18); % Temps de fonctionnement ou d'arr�t � l'instant initiale
%% Structure du vecteur � optimiser
n(1)=12*24; % Relatif aux puissances
n(2)=12*24*2; % Relatif aux r�serves pos et neg
%n(3)=12*24; % Relatif aux �tats de fonctionnement (Utile ? avec les puissances on peut les r�cup)

% x=zeros(1,sum(n));
x=randi([0 1],1,12*24*4);
% Les 12*24 premi�res colonnes seront d�di�es aux puissances
% Les 12*24*2 aux r�servePos et reserve Neg
%% Contraintes
% Matrice contraintes de rampes de puissances
global rampeUp24 rampeDown24
rampeUp24=[];
rampeDown24=[];
p_min24=[];
p_max24=[];
resPos24=[];
resNeg24=[];
for i=1:12
    rampeUp24=[rampeUp24 ones(1,24)*rampeUpRate(i)];
    rampeDown24=[rampeDown24 ones(1,24)*rampeDownRate(i)];
    p_min24=[p_min24 ones(1,24)*p_min(i)];
    p_max24=[p_max24 ones(1,24)*p_max(i)];
    resPos24=[resPos24 ones(1,24)*reservePos(i)];
    resNeg24=[resNeg24 ones(1,24)*reserveNeg(i)];
end
rampeUp24=rampeUp24';
rampeDown24=rampeDown24';

% R�cup�rer le temps de fonctionnement 
"La fonction temps_fonctionnement s'en charge, utilis�e dans les contraintes_NL";

%% Optimisation
%fonction co�t � optimiser
fun = @(x)cout(x);

%contraintes ineg & eg
Aineq = [];
bineq=[];

Aeq=[];
beq=[];

%bornes basses & hautes
lb = [zeros(1,n(1)) zeros(1,n(2))];
ub = [p_max24 resPos24 resNeg24];

%vecteur initialisation
x0 = [p_min24 zeros(1,n(2))];

% Options li�es � l'utilisation de fmincon 
options = optimoptions('fmincon','Display','iter','Diagnostics','on');

% Appel de fmincon
[x,fval,flag,out]=fmincon(fun,x0,Aineq,bineq,Aeq,beq,lb,ub,@contrainte_NL,options);





