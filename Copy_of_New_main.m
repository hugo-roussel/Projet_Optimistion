% Exportation des donn�es
[donnees,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableaux2et3et4');
[donnees_demande,~,~]=xlsread('Donnees_Projet_Optimisation.xlsx','Tableau1');

global Pinit InitState minimumUpTime minimumDownTime InitLength OperationalCost ReserveCostPos ReserveCostNeg StartUpCost
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

global Demand
Demand=donnees_demande(:,2); % Demande de puissance (MW)

% Matrice contraintes de rampes de puissances
global resCostPos24 resCostNeg24 rampeUp24 rampeDown24 resPos24 resNeg24 p_min24 p_max24 rampeUp23 rampeDown23 A
A=[];
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
    A=[A ones(1,24)*OperationalCost(i)];
    rampeUp24=[rampeUp24 ones(1,23)*rampeUpRate(i)];
    rampeDown24=[rampeDown24 ones(1,24)*rampeDownRate(i)];
    p_min24=[p_min24 ones(1,24)*p_min(i)];
    p_max24=[p_max24 ones(1,24)*p_max(i)];
    resPos24=[resPos24 ones(1,24)*reservePos(i)];
    resNeg24=[resNeg24 ones(1,24)*reserveNeg(i)];
    resCostPos24=[resCostPos24 ones(1,24)*ReserveCostPos(i)];
    resCostNeg24=[resCostNeg24 ones(1,24)*ReserveCostNeg(i)];
    rampeUp23=[rampeUp23 ones(1,23)*rampeUpRate(i)];
    rampeDown23=[rampeDown23 ones(1,23)*rampeDownRate(i)];
end

resCostPos24=resCostPos24';
resCostNeg24=resCostNeg24';
rampeUp24=rampeUp24';
rampeDown24=rampeDown24';

% Structure du vecteur � optimiser
n(1)=12*24; % Relatif aux puissances
n(2)=12*24; % Relatif aux r�serves pos et neg
n(3)=12*24;% Relatif aux �tats d'activations

% %contraintes ineg & eg
Aineq=zeros(276,864);
h=0;
for k=1:12*23-1
    if mod(k,23)==0
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
x0 = [zeros(1,n(1)) zeros(1,n(2)) zeros(1,n(3))];

%% Appel de GA
nvars=3*288;
intcon=577:864;
options = optimoptions('ga',options,'PlotFcn',@plotbestf);

[x,feval,exitflag,output,scores]=ga(@cout,nvars,Aineq,bineq,[],[],lb,ub,@Copy_of_contraintes_NL,intcon);
