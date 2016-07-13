#!/bin/bash
rm ./settings/*.json
rm ./monitor/*.json
rm output.json

#openaps preflight
#let error=$?
#if [ $error -ne 0 ]; then
#	echo "preflight failed, error code $error"
#	exit 1
#fi

openaps monitor-cgm
let error=$?
if [ $error -ne 0 ]; then
	echo "nonitor-cgm failed, error code $error"
	exit 1
fi

openaps monitor-pump
let error=$?
if [ $error -ne 0 ]; then
	echo "monitor-pump failed, error code $error"
	exit 1
fi

openaps settings-pump
let error=$?
if [ $error -ne 0 ]; then
	echo "settings-pump failed, error code $error"
	exit 1
fi

openaps settings-profile
let error=$?
if [ $error -ne 0 ]; then
	echo "settings-profile failed, error code $error"
	exit 1
fi

openaps calc-iob
let error=$?
if [ $error -ne 0 ]; then
	echo "calc-iob failed, error code $error"
	exit 1
fi

openaps calc-basal
let error=$?
if [ $error -ne 0 ]; then
	echo "calc-basal failed, error code $error"
	exit 1
fi

cp enact/suggested.json enact/enacted.json
echo "enact/enacted.json step is incorrect. please fix it soon..."

openaps ns-prepare
let error=$?
if [ $error -ne 0 ]; then
	echo "ns-prepare failed, error code $error"
	exit 1
fi

openaps ns-send
let error=$?
if [ $error -ne 0 ]; then
	echo "ns-send failed, error code $error"
	exit 1
fi
