FROM python:2.7

# Download & Install Semaphor
RUN apt-get update
RUN apt-get install curl
RUN apt-get -y install libxss1
RUN curl -o semaphor.deb https://spideroak.com/releases/semaphor/debian
RUN dpkg -i semaphor.deb
RUN apt-get install -f

ADD requirements.txt /src/requirements.txt
RUN cd /src; pip install -r requirements.txt

# Copy code
COPY . /src
WORKDIR /src

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["app.py"]