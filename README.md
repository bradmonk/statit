# statit
Reddit stats harvesting

## Documentation

The run this bot first you need to open the python script and edit the section...

    '''Authenticated instance of Reddit'''
    # --------------------------------------------------------------------
    reddit = praw.Reddit(client_id='yourClientID',
                         client_secret='yourSecretCode',
                         user_agent='reddit stat bot by /u/username',
                         username='username',
                         password='password')

    reddit.read_only = True

    subreddit = reddit.subreddit('The_Donald')
    # --------------------------------------------------------------------

...with your personal app information. You should also set the subreddit to the desired sub.

You can run the python script from bash command line, like so...

    $ python statitbot.py 2017 1 4 1 2017 1 4 12

where the first four input parameters after statitbot.py (2017 1 4 1) represent the YEAR, MONTH, DAY, HOUR to start your scrape search and where the next four input parameters (2017 1 4 12) represent the YEAR, MONTH, DAY, HOUR to end your scrape search.

You can also using the MATLAB script 'redditPRAWgraph_TD.m' to run this command and generate figures like this one:


<img src="http://bradleymonk.com/img/TD_vs_ETS.png" alt="TD_vs_ETS" width="600" border="10" />




