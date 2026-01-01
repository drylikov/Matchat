
# Matchat

In the spirit of [everyone in the world](https://github.com/github/hubot/network) 
reinventing [Hubot](http://hubot.github.com), I've decided to jump on the 
[bandwagon](https://github.com/teddziuba/hubot). But much like Ted,
I favour the simplest thing that works. Which in this case means not using
Campfire. I'll check my misgivings about Campfire at the door, and simply state
that I already use a networked communication system all day every day: Jabber. I
need to keep track of another website (or run another client) like I need a 
hole in the head.

Up until today, I've used the most excellent
[Partychat](http://partychapp.appspot.com/) service to make this happen. It's
such a well built tool, and works so transparently that I've always wondered
why more people didn't use it. However, it isn't without its quirks:

* Because multiple rooms are managed through a single contact, the required use 
  of `/join` for new users makes it hard to add bot functionality to it.
* It's impossible to add commands to the room (short of running your own
  partychat server)
* It's annoying to have people paste in links with no context. The room should
  look up the name of the Youtube video or the caption on the imgur lolcat and
  annotate the link

Thus, Matchat was born.

Matchat is the simplest thing that can pass as a multi-user chatroom. 

## Installing it

This part is easy (these instructions assume you already have a Heroku account.
If not, getting one [takes no time at all](https://api.heroku.com/signup)).

1. Create a Jabber account somewhere for this room to use. This can be as
   simple as creating a new gmail user.

2. Clone this repo

        git clone git@github.com/drylikov/matchat
        cd matchat

3. Create a heroku app to host it in (the name of the app doesn't matter, so
   just leave it blank unless you have a better name for it)

        heroku apps:create --stack cedar

4. Specify the credentials of your user from step 1

        heroku config:add \
          JABBER_USERNAME=mychatroom@gmail.com \
          JABBER_PASSWORD=sekrit \
          MEMBERS="you@yourself.com someoneelse@them.com"

    The purpose of `MEMBERS` is to define the set of people
    able to connect to the chatroom. Only people listed here will be able to add the
    chatroom account to their roster and communicate through it. The list
    should be a set of Jabber IDs, space separated.

5. Deploy your app, scale up your bot worker, and scale down your web worker
   (to stay within Heroku's free tier)

        git push heroku master
        heroku ps:scale web=0 bot=1

6. Anyone listed in `MEMBERS` will be allowed to connect to the
   chatroom simply by adding the Jabber user you created in step 1 to their
   roster. Messages sent there will be forwarded to all other members of the
   chatroom.

## Using it

In addition to its basic functionality as a chatroom, Matchat has a number of
commands to make life more fun.

- `/snooze <duration>`: This will temporarily stop delivery of messages to you
  until the specified amount of time has elapsed, or until you write something
  to the chatroom. Duration can be specified in plain English -- something like
  `/snooze 1 hour` or `/snooze 10m` should work fine.

- `/nick <nickname>`: Changes your nickname to be the specified name. Does not
  check for conflicts within the chatroom, and currently doesn't remember you
  nickname across server restarts.

## Extending it

In progress -- fork and add your own plugin





















