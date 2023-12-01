#!/bin/sh
########################################################################
# Begin scriptname
#
# Description :
#
# Authors     :
#
# Version     : LFS x.x
#
# Notes       :
#
########################################################################

### BEGIN INIT INFO
# Provides:            v2ray
# Required-Start:      $network
# Should-Start:        networkmanager
# Required-Stop:       $network
# Should-Stop:         networkmanager
# Default-Start:       2 3 4 5
# Default-Stop:        0 1 6
# Short-Description:   Starts v2ray services.
# Description:         Starts v2ray services.
# X-LFS-Provided-By:   BLFS
### END INIT INFO

#Rely on file installed path,Read offical manual books.
DAEMON="/usr/bin/v2ray"
DAEMON_OPTS="-confdir=/etc/v2ray"

. /lib/lsb/init-functions

case "$1" in
    start)
        log_info_msg "Starting v2raya..."
  	    start_daemon -f $DAEMON $DAEMON_OPTS 1>/dev/null 2>&1 &
        #start_daemon -f /usr/bin/v2ray -confdir=/etc/v2ray 1>/dev/null 2>&1 &
	evaluate_retval
        pid=`cat /run/v2ray.pid 2>/dev/null`
        ;;

    stop)
        log_info_msg "Stopping v2ray..."
        killproc -p "/run/v2raya.pid" /usr/bin/v2ray
        evaluate_retval
        ;;


    restart)
        $0 stop
        sleep 1
        $0 start
        ;;

    status)
        statusproc /usr/bin/v2ray
        ;;

    *)
        echo "Usage: $0 {start|stop|reload|restart|status}"
        exit 1
        ;;
esac

exit 0

# End scriptname
