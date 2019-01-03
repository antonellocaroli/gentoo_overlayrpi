#!/sbin/openrc-run

user="bubbleupnp:bubbleupnp"
logfile="/var/log/bubbleupnp.log"

start_stop_daemon_args="--user $user"

command="//bubbleupnp/./launch.sh"
#command_args="
#       -f $logfile
#"

command_background=yes
pidfile=/run/bubbleupnp.pid

depend() {
    need net
    use alsasound
    after bootmisc
}

start_pre() {
    checkpath --file --owner $user --mode 0644 $logfile
}
