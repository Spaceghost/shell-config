set SSH_ENV $HOME/.ssh/environment

function start_ssh_agent
  echo "Initializing new SSH agent..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
  ssh-add
end

function test_ssh_identities
  ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
    ssh-add
    if [ $status -eq 2 ]
      start_ssh_agent
    end
  end
end

if [ -n "$SSH_AGENT_PID" ]
  ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_ssh_identities
  end
else
  if [ -f $SSH_ENV ]
    source $SSH_ENV > /dev/null
  end

  ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_ssh_identities
  else
    start_ssh_agent
  end
end