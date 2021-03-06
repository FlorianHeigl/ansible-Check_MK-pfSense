#!/bin/sh


TMPFILE=/etc/inc/filter.inc.temp
SRCFILE=/etc/inc/filter.inc


edit_missing_include() {
    awk '/Close file handle/{print "        fwrite($xinetd_fd, \"includedir /opt/etc/xinetd.d\");"}1' \
        $SRCFILE > $TMPFILE
    return $?
}


replace_config() {
    mv $TMPFILE $SRCFILE
    return $?
}

# if the file is already valid
if grep -q -E "includedir.*/opt/check_mk/etc/xinetd.d" $SRCFILE ; then
    exit 0
fi
# if the file has the path as mentioned on forums
if grep -q -E "includedir.*/opt/etc/xinetd.d" $SRCFILE ; then
    sed -i "" /opt/etc/xinetd.d /opt/check_mk/etc/xinetd.d $SRCFILE
    exit 0
fi

# finally, if nothing was there, patch it
edit_missing_include &&
replace_config

exit $?
