Documentation second homewok

Task: Ne dorim să oferim posibilitatea pasionaților de jocuri vechi – în linia de comandă, de exemplu Hunt the Wumpus – să poată juca unul dintre aceste jocuri într-un browser. În acest scop va trebui să pregătiți o imagine de docker care să conțină un server web care să expună jocul ales de voi.

First step: Clone the repository https://github.com/paradoxxxzero/butterfly:
    
    git clone https://github.com/paradoxxxzero/butterfly
   
Second step: In the folder where the repo has been cloned in the previous step, replace the Dockerfile from the root, with the Dockerfile in this repository. The Dockerfile installs the necessary dependecies for running the butterfly in a web browser. 

Butterfly uses python packeges like tornado that requieres a python version >= 3.6. The initial Dockerfile from paradoxxxzero's repository installs python 2.7 (when we will run the docker image this will fail with a syntax error if the python version will remain 2.7)

That's why I have installed python3.6, after that I removed from the initial Dockerfile the unnecessary commands for installing python, pip and I addapted the rest.

After that, I cloned a repo with the wumpus game implemented in pyhthon 3.6: 

    git clone https://github.com/lanhel/pywumpus

The game will be located in /opt/pywumpus.

For building the docker image, the following command will construct a docker image from the entire directory that will have the alias 'butterfly-terminal':

    docker build -t butterfly-terminal .

For running the created docker image:

    docker run -p 57575:57575 butterfly-terminal
    
To test:

    wget http://127.0.0.1:57575 (on centos virtual machine)
    
Another option for testing the result: Access it from your browser on your local computer by accessing the link:

    http://192.168.56.101:57575/
    
If a password is required, type 'password'.

Now, access the game:
  
    cd /opt/pywumpus
    python3 pywumpus.py
