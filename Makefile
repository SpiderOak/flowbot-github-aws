IMAGE = avatar.jpg

all: preclean source_zip cleanup

source_zip:
	# Create a temportary folder, we will eventually zip it's contents.
	mkdir tmp

	# Copy these local settings into the temporary folder
	cp Dockerfile tmp/Dockerfile
	cp Dockerrun.aws.json tmp/Dockerrun.aws.json

	# Copy over the settings.json file
	cp settings.json tmp/settings.json

	# Copy over the avatar image.
	cp ${IMAGE} tmp/${IMAGE}

	# zip everything up!
	cd tmp; zip -r source.zip *
	mv tmp/source.zip source.zip

preclean:
	rm -rf tmp
	rm -f source.zip

cleanup:
	rm -rf tmp