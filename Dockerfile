FROM python:3.8-bullseye

ARG UID
RUN mkdir -p /home/clonecognition
RUN useradd -u ${UID} clonecognition 

RUN apt-get update \
 && apt-get install -y --no-install-recommends  \
        build-essential \
        debhelper \
        devscripts \
        gcc \
        gettext \
        libffi-dev \
        libjpeg-dev \
        libmemcached-dev \
        libpq-dev \
        libxml2 \
        libxml2-dev \
        libxslt1-dev \
        memcached \
        netcat \
        python3-dev \
        python3-gdal \
        python3-ldap \
        python3-lxml \
        python3-pil \
        python3-pip \
        python3-psycopg2 \
        zip \
        zlib1g-dev \
        default-jre \
        default-jdk \
        python \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/clonecognition
COPY . .

# separate venv for python2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output /home/get-pip.py
RUN python2 /home/get-pip.py
RUN python2 -m pip install virtualenv
RUN python2 -m virtualenv /home/.venvpy2
RUN /home/.venvpy2/bin/pip install --upgrade pip
RUN /home/.venvpy2/bin/pip install -r requirements.txt

RUN chown -R clonecognition ./
RUN chown -R clonecognition:clonecognition ../.venvpy2

USER clonecognition
WORKDIR /home/clonecognition