#! /usr/bin/env php
<?php
include "pkg-utils.inc";
// I found this local check somewhere but can't find the source location anymore to give a link
// (c) would go to whoever wrote (and shared it)


$info = get_system_pkg_version();

if ($info["installed_version"] == $info["version"]) {
    echo "0 pfSense_Version - No new update available\n";
} else {
    echo "1 pfSense_Version - Version " . $info["version"] . " available\n";
}
