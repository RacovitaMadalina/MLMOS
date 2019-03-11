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
     sau:  ssh-agent bash -c 'ssh-add /etc/ssh/id_rsa_git; git clone git@github.com:RacovitaMadalina/MLMOS.git'
     
Cheia publica se va afla de asemenea si in:

      ~/.ssh/
      
Pentru a copia cheia pe o alta masina se va executa comanda:
     
       ssh-copy-id username@remote_host ->>>> ssh-copy-id madalina@192.168.56.101
    
Si prin modificarea cheii de PasswordAuthentication = no in fisierul /etc/ssh/sshd_config se va permite conectarea fara parola, 
daca se doreste conectarea de pe o alta masina virtuala la masina mea, iar cheile RSA public/private in momentul in care se face conexiunea vor face match.

Toate serviciile existente in sistem se gasesc la locatia: /usr/lib/systemd/system

     cd /usr/lib/systemd/system
     
Fisierul other_service_functionalities.sh contine comenzile care vor trebuie executate odata cu pornire serviciului. Pentru a-l rula:
     
     exec ssh-agent bash | ssh-add /etc/ssh/id_rsa_git | . other_service_functionalities.sh "new hostname"
     
Toate serviciile de sistem le gasim prin comanda:
     
     cd /usr/lib/systemd/system 

Un serviciu va fi construit dupa urmatoarea structura:

     [Unit] -> description + dependecies
     [Service]
          type: single/forking/dbas etc
          ExecStart: path to binary file that we want to execute
     [Install]
          WantedBy: multi-user.target/desktop.target
          
Dupa ce cream nnoul serviciu, acesta nu va fi recunoscut din prima. De aceea trebuie sa rulam urmatoarele comenzi:
     
          systemctl daemon system reload
          systemctl list-units --type=service #pentru a vedea serviciile care ruleaza in momentul curent
          systemctl start/stop/restart tema1.service
          systemctl status tema1.service
          
Pentru a porni la startup:
          
          systemctl enable tema1.service
