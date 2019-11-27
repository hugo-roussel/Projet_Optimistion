function Liste=temps_fonctionnement(x)
global InitLength Pinit
Liste=zeros(12,24);
for i=1:12 % Numéro de la machine
    for j=1:24 % Indice du temps
        if x(24*(i-1)+j)>0 % Si jamais la machine est en marche alors,
            if j==1 % A l'initialisation
                if Pinit(i)==0 % Si elle était éteinte avant, on remet le temps de fonctionnement à 0 heure
                    Liste(i,j)=0;
                else % Sinon, on augmente son temps de marche de 1 heure
                    Liste(i,j)=InitLength(i)+1;
                end
            else % Pour tous les temps
                if x(24*(i-1)+j-1)==0 % Si elle était éteinte avant, on remet le temps de fonctionnement à 0 heure
                    Liste(i,j)=0;
                else % Sinon, on augmente son temps de marche de 1 heure
                    Liste(i,j)=Liste(i,j-1)+1;
                end
            end
        else % Si la machine est à l'arrêt
            if j==1 % A l'initialisation
                if Pinit(i)==0 % Si elle était éteinte avant, on diminue son temps de 1 heure
                    Liste(i,j)=InitLength(i)-1;
                else % Sinon, on la met à 0 heure de fonctionnement
                    Liste(i,j)=0;
                end
            else % Pour tous les temps
                if x(24*(i-1)+j-1)==0 % Si elle était éteinte avant, on diminue son temps de 1 heure
                    Liste(i,j)=Liste(i,j-1)-1;
                else % Sinon, on reset son temps de fonctionnement à 0
                    Liste(i,j)=0;
                end
            end
        end
    end
end
end
