all: preclean source_zip cleanup

install_bot:
	rm -rf flowbot-barebones
	rm -rf flowbot-github
	git clone git@github.com:SpiderOak/flowbot-github.git
	# We don't need the tests dir
	rm -rf flowbot-github/src/tests

	# Remove this when flowbot_barebones becomes public, this just installs the
	# boilerplate bot alongside the github bot so that it can be imported as if
	# it were installed.
	git clone git@github.com:SpiderOak/flowbot-barebones.git
	mv flowbot-barebones/src flowbot-github/src/flowbot

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

	cp avatar.png tmp/avatar.png

	# zip everything up!
	cd tmp; zip -r source.zip *
	mv tmp/source.zip source.zip

preclean:
	rm -f source.zip
	rm -rf flowbot-barebones

cleanup:
	rm -rf tmp
	rm -rf flowbot-github
	rm -rf flowbot-barebones