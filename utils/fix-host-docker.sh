/bin/sh

# on Docker Mac and Windows, host.docker.internal refers to the host, but on Linux not.
# this is a manual fix.
# The IP of the host is needed by XDebug

echo -e "`/sbin/ip route|awk '/default/ { print $3 }'`\thost.docker.internal" | tee -a /etc/hosts > /dev/null