IMAGE = avatar.jpg

all: preclean source_zip cleanup

install_bot:
	rm -rf flowbot
	rm -rf flowbot-github
	git clone git@github.com:SpiderOak/flowbot-github.git
	# We don't need the tests dir
	rm -rf flowbot-github/src/tests

	# Remove this when flowbot becomes public, this just installs the
	# boilerplate bot alongside the github bot so that it can be imported as if
	# it were installed.
	git clone git@github.com:SpiderOak/flowbot.git
	mv flowbot/src flowbot-github/src/flowbot

source_zip: install_bot
	# Create a temportary folder, we will eventually zip it's contents.
	mkdir tmp

	# Copy the flowbot source into the tmp folder
	cp -r flowbot-github/src/ tmp/
	cp flowbot-github/requirements.txt tmp/

	# Copy these local settings into the temporary folder
	cp Dockerfile tmp/Dockerfile
	cp Dockerrun.aws.json tmp/Dockerrun.aws.json
	cp settings.json tmp/settings.json

	# Copy over the avatar image.
	cp ${IMAGE} tmp/${IMAGE}

	# zip everything up!
	cd tmp; zip -r source.zip *
	mv tmp/source.zip source.zip

preclean:
	rm -f source.zip
	rm -rf flowbot

cleanup:
	rm -rf tmp
	rm -rf flowbot-github
	rm -rf flowbot