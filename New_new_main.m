% Exportation des données
[donnees,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableaux2et3et4');
[donnees_demande,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableau1');

global nbr_heures
nbr_heures=2;

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

% Matrice contraintes de rampes de puissances
global resCostPos24 resCostNeg24 rampeUp24 rampeDown24 resPos24 resNeg24 p_min24 p_max24 rampeUp23 rampeDown23 CoutOPE
CoutOPE=[];
rampeUp24=[];
rampeUp23=[];
rampeDown23=[];
rampeDown24=[];
p_min24=[];
p_max24=[];
resPos24=[];
resNeg24=[];
resCostPos24=[];
resCostNeg24=[];

for i=1:12
    CoutOPE=[CoutOPE ones(1,nbr_heures)*OperationalCost(i)];
    rampeUp24=[rampeUp24 ones(1,nbr_heures)*rampeUpRate(i)];
    rampeDown24=[rampeDown24 ones(1,nbr_heures)*rampeDownRate(i)];
    p_min24=[p_min24 ones(1,nbr_heures)*p_min(i)];
    p_max24=[p_max24 ones(1,nbr_heures)*p_max(i)];
    resPos24=[resPos24 ones(1,nbr_heures)*reservePos(i)];
    resNeg24=[resNeg24 ones(1,nbr_heures)*reserveNeg(i)];
    resCostPos24=[resCostPos24 ones(1,nbr_heures)*ReserveCostPos(i)];
    resCostNeg24=[resCostNeg24 ones(1,nbr_heures)*ReserveCostNeg(i)];
    rampeUp23=[rampeUp23 ones(1,nbr_heures-1)*rampeUpRate(i)];
    rampeDown23=[rampeDown23 ones(1,nbr_heures-1)*rampeDownRate(i)];
end

resCostPos24=resCostPos24';
resCostNeg24=resCostNeg24';
rampeUp24=rampeUp24';
rampeDown24=rampeDown24';

% Structure du vecteur à optimiser
n(1)=12*nbr_heures; % Relatif aux puissances
n(2)=12*nbr_heures; % Relatif aux réserves pos et neg
n(3)=12*nbr_heures;% Relatif aux états d'activations

% %contraintes ineg & eg
Aineq=zeros(12*(nbr_heures-1),12*nbr_heures*length(n));
h=0;
for k=1:12*(nbr_heures-1)-1
    if mod(k,nbr_heures-1)==0
        h=h+2;
    else
        h=h+1;
    end
    Aineq(k,h)=-1;
    Aineq(k,h+1)=1;
end
AineqDouble=-Aineq;

Aineq=vertcat(Aineq,AineqDouble);
bineq=[rampeUp23 rampeDown23];

Aeq=[];
beq=[];

%bornes basses & hautes
lb = [zeros(1,n(1)) -resNeg24 zeros(1,n(3))];
ub = [p_max24 resPos24 ones(1,n(3))];

%vecteur initialisation
% x0 = [zeros(1,n(1)) zeros(1,n(2)) zeros(1,n(3))];

%% Appel de GA
nvars=length(n)*12*nbr_heures;
intcon=n(1)+n(2)+1:n(1)+n(2)+n(3);
options = optimoptions('ga','Display','iter');
% options.InitialPopulationMatrix = x0;

% [x,feval,exitflag,output,scores]=ga(@pond_cout,nvars,Aineq,bineq,[],[],lb,ub,@pond_cont,intcon,options);
feval
exitflag

