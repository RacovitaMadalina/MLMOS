FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y && apt-get update
RUN apt install -y python3.6
RUN apt install -y python3.6-dev
RUN apt install -y python3.6-venv
RUN apt install -y wget
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py
RUN ln -sv /usr/bin/python3.6 /usr/local/bin/python3
RUN rm -rf /usr/local/bin/pip3
RUN ln -sv /usr/local/bin/pip /usr/local/bin/pip3

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    git \
    ca-certificates \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

WORKDIR /opt
ADD . /opt/app
WORKDIR /opt/app

RUN python3 setup.py build \
 && python3 setup.py install

ADD docker/run.sh /opt/run.sh

WORKDIR /opt
RUN git clone https://github.com/lanhel/pywumpus

WORKDIR /opt/app
EXPOSE 57575

CMD ["butterfly.server.py", "--unsecure", "--host=0.0.0.0"]
ENTRYPOINT ["docker/run.sh"]
