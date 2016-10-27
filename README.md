> Please Note: This project has not undergone a security review.
> 
> Deploying Semaphor bots to hosted services like AWS compromises the promise of "Zero Knowledge"
> since the bot has access to all messages in channels to which it belongs (and therefore so does the host service).
> However, Semaphor channels are each cryptographically secure, so consider only adding these bots to channels that
> don't contain sensitive messages.


# flowbot-github-aws
A demonstration of a [flowbot-github](https://github.com/SpiderOak/flowbot-github) bot running on an Elastic Beanstalk docker deployment. This bot responds to GitHub webhook events and sends messages to [Semaphor](https://spideroak.com/solutions/semaphor). 



## Installation on AWS (Elastic Beanstalk)

1. Download/clone this repo

	```
	git clone git@github.com:SpiderOak/flowbot-github-aws.git
	```

2. Modify `settings.json` w/ your bot's desired settings:
	- `username` **required**: the username of your desired bot; Semaphor usernames must be unique.  
	- `password` **required**: the password used to authenticate your bot; you will want to make sure to keep this password secure.
	- `org_id` **requred**: this is the identifier provided to you by the team admin; this is where your bot will live.
	- `github_webhook_secret` **required**: This is a secret string that github will use to validate itself to your bot.
	- `display_name` *recommended*: This is the name your bot will have in the channel, (e.g. `@github`). If no display name is given, the bot will use it's username.
	- `github_webhook_url` *recommended*: This is the relative url that webhooks should be directed. Defaults to `/hooks`.
	- `biography`: A short description of your bot.
	- `photo`: An avatar image to use for the bot (e.g. "avatar.jpg"; must be in this directory at the time you run the `make` step below).

  		> Note: The Makefile expects a photo file with the name `avatar.jpg`; if you include a photo file with a different name, make sure you either update the Makefile to refernce the new [filename](https://github.com/SpiderOak/flowbot-github-aws/blob/master/Makefile#L1) or run the make command with an explicit reference to your image name: `make IMAGE=myimage.png`
	


3. Run the command `make` in a terminal from this dir. This will produce a `source.zip` file which you will need when uploaded to AWS.
4. Create a new [Elastic Beanstalk Single Container Instance](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/docker-singlecontainer-deploy.html). When prompted to upload a source bundle, select the `source.zip` file from above.
5. Once your Elastic Beanstalk app is running, make note of the url.
6. As soon as the app is running, a join request will automatically be triggered in the Semaphor org for which it was configured (see `org_id` in settings above). The admin of the Semaphor team should approve this request and then add the github bot to any channels desired.


Your bot is now ready to listen for webhooks!

## Configure a GitHub repo
1. Visit the github repo you want to connect to your bot (e.g. https://github.com/SpiderOak/flowbot-github-aws)
2. You should see a **Settings** tab at the top of the page, if you do not, then you may not have the proper permissions; talk to the administrator of the repo.
3. From the **Settings** tab, click **Webhooks** and **Add Webhook**
4. In **Payload Url** input area, enter your AWS app url with the `github_webhook_url` setting you configured above:

	```
	http://myappname-env.us-west-2.elasticbeanstalk.com/hooks	
	```

5. In the **Secret** input area, enter the `github_webhook_secret` setting you configured above.
6. Select **Send me everything**
7. Complete the setup by clicking the **Add Webhook** button.

Github will immediately send a test webhook, you should confirm that a `200` response is received (Github will either show a red or green status message, it should be obvious).

You can also create a dummy issue or pull request to confirm that the setup completed successfull.