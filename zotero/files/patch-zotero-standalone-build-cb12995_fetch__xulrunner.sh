--- zotero-standalone-build-cb12995/fetch_xulrunner.sh.orig	2017-12-19 20:54:27 UTC
+++ zotero-standalone-build-cb12995/fetch_xulrunner.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/local/bin/bash
 set -euo pipefail
 
 # Copyright (c) 2011  Zotero
@@ -26,7 +26,7 @@ function usage {
 	cat >&2 <<DONE
 Usage: $0 -p platforms
 Options
- -p PLATFORMS        Platforms to build (m=Mac, w=Windows, l=Linux)
+ -p PLATFORMS        Platforms to build (m=Mac, w=Windows, l=Linux f=FreeBSD)
 DONE
 	exit 1
 }
@@ -34,6 +34,7 @@ DONE
 BUILD_MAC=0
 BUILD_WIN32=0
 BUILD_LINUX=0
+BUILD_FREEBSD=0
 while getopts "p:" opt; do
 	case $opt in
 		p)
@@ -43,6 +44,7 @@ while getopts "p:" opt; do
 					m) BUILD_MAC=1;;
 					w) BUILD_WIN32=1;;
 					l) BUILD_LINUX=1;;
+					f) BUILD_FREEBSD=1;;
 					*)
 						echo "$0: Invalid platform option ${OPTARG:i:1}"
 						usage
@@ -55,7 +57,7 @@ while getopts "p:" opt; do
 done
 
 # Require at least one platform
-if [[ $BUILD_MAC == 0 ]] && [[ $BUILD_WIN32 == 0 ]] && [[ $BUILD_LINUX == 0 ]]; then
+if [[ $BUILD_MAC == 0 ]] && [[ $BUILD_WIN32 == 0 ]] && [[ $BUILD_LINUX == 0 ]] && [[ $BUILD_FREEBSD == 0 ]]; then
 	usage
 fi
 
@@ -159,6 +161,27 @@ if [ $BUILD_WIN32 == 1 ]; then
 	cd ..
 	
 	rm "Firefox%20Setup%20$GECKO_VERSION.exe"
+fi
+
+
+if [ $BUILD_FREEBSD == 1 ]; then
+	GECKO_VERSION="esr-52.6.0_3,1"
+	DOWNLOAD_URL="https://ftp.mozilla.org/pub/firefox/releases/$GECKO_VERSION"
+	rm -rf firefox
+	rm -rf freebsd-pkg-foo
+	
+	#curl -O "$DOWNLOAD_URL/linux-i686/en-US/firefox-$GECKO_VERSION.tar.bz2"
+	sudo pkg fetch -y firefox-$GECKO_VERSION
+	mkdir freebsd-pkg-foo
+	tar -xf /usr/local/tmp/firefox-$GECKO_VERSION.txz --strip-components 3 -C freebsd-pkg-foo
+	mv freebsd-pkg-foo/lib/firefox firefox
+	arch=amd64
+	rm -rf firefox-$arch
+	mv firefox firefox-$arch
+	cd firefox-$arch
+	modify_omni
+	extract_devtools
+	cd ..
 fi
 
 if [ $BUILD_LINUX == 1 ]; then
@@ -187,4 +210,4 @@ if [ $BUILD_LINUX == 1 ]; then
 	rm "firefox-$GECKO_VERSION.tar.bz2"
 fi
 
-echo Done
\ No newline at end of file
+echo Done
