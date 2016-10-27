FROM python:2.7

# Download & Install Semaphor
RUN apt-get update
RUN apt-get install curl
RUN apt-get -y install libxss1
RUN curl -O -J https://spideroak.com/releases/semaphor/debian
RUN dpkg -i semaphor*.deb
RUN apt-get install -f

# Install flowbot-github locally
RUN git clone https://github.com/SpiderOak/flowbot-github.git
RUN cd flowbot-github; pip install -r requirements.txt

# Copy local files over (setting.json, image file)
COPY . flowbot-github/src
WORKDIR /flowbot-github/src

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["app.py"]