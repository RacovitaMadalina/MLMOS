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
