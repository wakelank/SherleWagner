## Deployment

First, make sure you have the latest gems including Capistrano, our deployment tool:

```
bundle install
```

Next, invoke Capistrano. Tell it the environment you wish to target (e.g. `production`) and the command you wish to run (almost always `deploy`):

```
cap production deploy
```

You will be prompted for the password for the `rails` user, which runs the application server (_not_ root). If you leave the password blank, Capistrano will attempt to use SSH key authentication. For the latter to work, place your public key in `/home/rails/.ssh/authorized_keys` on the remote machine.

That's it! Capistrano will now:

# Pull the latest code from the `master` branch
# Precompile static assets (javascript, CSS, images, etc)
# Run any new or pending database migrations
# Restart Passenger (application server) to pick up those changes

Any users accessing the application during deployment should be unaffected. There is only a small window of time (< 1 second) where the application cannot take requests, and Nginx will queue them transparently to the user rather than rejecting them.
