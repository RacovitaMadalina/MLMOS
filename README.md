# MLMOS
My work during MLMOS laboratory classes in the third year of my bachelor studies

Pentru ca serviciul de autentificare sa se faca prin intermediul cheilor RSA
si nu prin solicitarea parolei, a trebuit sa generez un set de cheie publica/privata
pentru userul meu de git:

     sudo ssh-keygen -t rsa -b 4096 -C "madalina.racovita97@yahoo.com"

Cheile nou generate au fost salvate in etc/ssh sub denumirea de id_rsa_git si id_rsa_git.pub

Pornim agentul de ssh prin comanda: 
     
     exec ssh-agent bash

Adaugam cheia privata RSA, agentului ssh: 
      
     ssh-add /etc/ssh/id_rsa_git

Pentru a testa daca functioneaza: 
      
     ssh -T -y git@github.com
     
Pentru a clona repo-ul de git via ssh: 

     git clone git@github.com:RacovitaMadalina/MLMOS.git
     
Cheia publica se va afla de asemenea si in:

      ~/.ssh/authorized_keys

Toate serviciile existente in sistem se gasesc la locatia: /usr/lib/systemd/system

     cd /usr/lib/systemd/system
     
Fisierul other_service_functionalities.sh contine comenzile care vor trebuie executate odata cu pornire serviciului. Pentru a-l rula:
     
     exec ssh-agent bash | ssh-add /etc/ssh/id_rsa_git | . other_service_functionalities.sh "new hostname"
