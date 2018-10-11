#!/bin/sh

# script that patches pfSense to include an external (persistent) xinetd config directory
# the config directory is only used for Check_MK agent in TCP mode (optionally with caching agent)
# based off forum post https://forum.pfsense.org/index.php?topic=111517.0 


TMPFILE=/etc/inc/filter.inc.temp
SRCFILE=/etc/inc/filter.inc


edit_missing_include() {
    echo "config replaced"
    awk '/Close file handle/{print "        fwrite($xinetd_fd, \"includedir /opt/etc/xinetd.d\");"}1' \
        $SRCFILE > $TMPFILE
    return $?
}


patch_config() {
    # if the file has the path as mentioned on forums
    echo "config replaced"
    if grep -q -E "includedir.*/opt/etc/xinetd.d" $SRCFILE ; then
        sed -i "" 's%/opt/etc/xinetd.d.*%/opt/check_mk/etc/xinetd.d");%' $SRCFILE
        exit 0
    fi

}


replace_config() {
    echo "config replaced"
    mv $TMPFILE $SRCFILE
    return $?
}


main() {
    # if the file is already valid
    if grep -q -E "includedir /opt/check_mk/etc/xinetd.d" $SRCFILE ; then
        exit 0
    fi
    patch_config
    # finally, if nothing was there, patch it
    edit_missing_include &&
    replace_config
    return $?
}


main
exit $?
