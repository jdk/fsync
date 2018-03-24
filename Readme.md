# fsync

We have a limited data cap at home, but not at the office. So we download at the
office, sync to our computer locally, and then dump the files at home.

The problem is that we don't don't want to keep the files on our computer, but
we don't want to re-sync files either. 

So when we are at the office, we sync the files to the computer, and create a
file list of all the files succesfully synced. 

When we get home, we sync them back to our home server, and if succesful, we
remove them from the computer.

Output is logged for debugging and evertyhing can be configured.

We determine if we are at work or at home by pinging our nas at each location
checking for a response.

A lock file is created when we start a sync at work. If it doesn't finish, the
lock file remains. If we get home, we should still dump everything off on our
home NAS, but don't delete the local files, as they may be incomplete and
we don't want to start over. 
