#!/sbin/openrc-run

user="root:root"
logfile="/var/log/roonserver.log"

start_stop_daemon_args="--user $user"

command="//RoonServer/./start.sh"
command_args="
	-f $logfile
"

command_background=yes
pidfile=/run/roonserver.pid

depend() {
    need net
    use alsasound
    after bootmisc
}

start_pre() {
    checkpath --file --owner $user --mode 0644 $logfile
}

