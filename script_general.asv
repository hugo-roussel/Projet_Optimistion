%% Exportation des données
[donnees,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableaux2et3et4');
[donnees_demande,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableau1');

global Pinit InitState minimumUpTime minimumDownTime InitLength OperationalCost ReserveCostPos ReserveCostNeg StartUpCost
p_min=donnees(:,4); % Puissance minimale 
p_max=donnees(:,5); % Puissance maximale
reservePos=donnees(:,6); % Capacité de réserve positive
reserveNeg=donnees(:,7); % Capacité de réserve négative
rampeUpRate=60*donnees(:,8); % Limite de variation de puissance UP
rampeDownRate=60*donnees(:,9); % Limite de variation de puissance DOWN
minimumUpTime=donnees(:,10); % Temps minimale de fonctionnement
minimumDownTime=-donnees(:,11); % Temps minimale d'arrêt
OperationalCost=donnees(:,12); % Cout de fonctionnelent
ReserveCostPos=donnees(:,13); % Cout de réserve positive
ReserveCostNeg=donnees(:,14); % Cout de réserve négative
StartUpCost=donnees(:,15); % Cout de démarrage
Pinit=donnees(:,16); % Puissance production à l'instant initiale
InitState=donnees(:,17); % Etat de fonctionnement à l'instant initiale
InitLength=donnees(:,18); % Temps de fonctionnement ou d'arrêt à l'instant initiale

global Demand
Demand=donnees_demande(:,2); % Demande de puissance (MW)
%% Structure du vecteur à optimiser
n(1)=12*24; % Relatif aux puissances
n(2)=12*24*2; % Relatif aux réserves pos et neg
% n(3)=12*24; % Relatif aux états de fonctionnement (Utile ? avec les puissances on peut les récup)
% x=zeros(1,sum(n));
x=randi([0 1],1,12*24*4);
% Les 12*24 premières colonnes seront dédiées aux puissances
% Les 12*24*2 aux réservePos et reserve Neg
%% Contraintes
% Matrice contraintes de rampes de puissances
global resCostPos24 resCostNeg24 rampeUp24 rampeDown24
rampeUp24=[];
rampeDown24=[];
p_min24=[];
p_max24=[];
resPos24=[];
resNeg24=[];
resCostPos24=[];
resCostNeg24=[];
for i=1:12
    rampeUp24=[rampeUp24 ones(1,24)*rampeUpRate(i)];
    rampeDown24=[rampeDown24 ones(1,24)*rampeDownRate(i)];
    p_min24=[p_min24 ones(1,24)*p_min(i)];
    p_max24=[p_max24 ones(1,24)*p_max(i)];
    resPos24=[resPos24 ones(1,24)*reservePos(i)];
    resNeg24=[resNeg24 ones(1,24)*reserveNeg(i)];
    resCostPos24=[resCostPos24 ones(1,24)*ReserveCostPos(i)];
    resCostNeg24=[resCostNeg24 ones(1,24)*ReserveCostNeg(i)];
end
resCostPos24=resCostPos24';
resCostNeg24=resCostNeg24';
rampeUp24=rampeUp24';
rampeDown24=rampeDown24';

% Récupérer le temps de fonctionnement 
"La fonction temps_fonctionnement s'en charge, utilisée dans les contraintes_NL";

%% Optimisation
%fonction coût à optimiser
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

% Options liées à l'utilisation de fmincon 
options = optimoptions('fmincon','Display','iter','Diagnostics','on');

% Appel de fmincon
[x,fval,flag,out]=fmincon(fun,x0,Aineq,bineq,Aeq,beq,lb,ub,@contrainte_NL,options);





