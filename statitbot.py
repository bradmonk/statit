# STATIT REDDIT STAT BOT
import datetime
import time
import numpy as np
import scipy.io as sio
import praw
import array
import csv
import sys
reload(sys)
sys.setdefaultencoding('utf-8')



'''DATE AND TIME EPOCH SETUP'''
# --------------------------------------------------------------------
Y1 = int(sys.argv[1])
M1 = int(sys.argv[2])
D1 = int(sys.argv[3])
H1 = int(sys.argv[4])

Y2 = int(sys.argv[5])
M2 = int(sys.argv[6])
D2 = int(sys.argv[7])
H2 = int(sys.argv[8])

# The code above allows this script to be run from the command line.
# Example usage:           Y/M/D/H to Y/M/D/H
# $ python statitbot.py 2017 1 4 1 2017 1 4 12

dayA = datetime.datetime(Y1,M1,D1,H1,1,1,1)
dayB = datetime.datetime(Y2,M2,D2,H2,1,1,1)

unixtimeA = time.mktime(dayA.timetuple())
unixtimeB = time.mktime(dayB.timetuple())

print(dayA)
print(dayB)




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


'''PREALLOCATE DATA CONTAINERS'''
# --------------------------------------------------------------------
def get_date(submission):
    time = submission.created
    return datetime.datetime.fromtimestamp(time)

for submission in subreddit.top(time_filter='month', limit=1):
    dateSub = get_date(submission)


SubmissionScore = [0, 0]
SubmissionURL = ['SubmissionURL', 'SubmissionURL']
SubmissionDate = [dateSub, dateSub]



'''LOOP OVER SUBMISSIONS'''
# --------------------------------------------------------------------

for submission in subreddit.submissions(unixtimeA, unixtimeB):
    print(submission.score)  # Output: the submission's score
    print(submission.url)    # Output: the outbound URL of the submission
    print(get_date(submission))
    SubmissionScore.append(submission.score)
    SubmissionURL.append(submission.url)
    SubmissionDate.append(get_date(submission))


'''DATA EXPORT'''
# --------------------------------------------------------------------

sio.savemat('The_Donald.mat',{'SubmissionScore':SubmissionScore,'SubmissionURL':SubmissionURL},oned_as="column")


with open('The_Donald.csv', 'wb') as f:
    writer = csv.writer(f, dialect='excel')
    writer.writerow(SubmissionScore)
    writer.writerow(SubmissionURL)
    writer.writerow(SubmissionDate)
