#!/bin/bash

COMMAND="ssh -i ~/.ssh/tunnel -R 80:localhost:8003 nokey@localhost.run"
nohup $COMMAND > ~/heyhey/temp_out.txt 2>&1 &

# Save the process ID
PID=$!
echo $PID

sleep 5
grep -oE 'https:\/\/[a-zA-Z0-9.-]+\.life' ~/heyhey/temp_out.txt > ~/heyhey/index.html

# Push changes to git
cd ~/heyhey
GIT_COMMIT="git commit -a --amend --no-edit"
nohup $GIT_COMMIT > ~/heyhey/git_out.txt 2>&1 &
sleep 5
cd ~/heyhey
GIT_PUSH="git push -f origin main"
nohup $GIT_PUSH > ~/heyhey/git_out.txt 2>&1 &

sleep 2700

kill $PID
