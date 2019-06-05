#!/bin/bash
if [ "$1" == "-h" -o "$1" == "" ]; then
	echo "./zaliczenie "tekst" -d kreska -k kropka -s separator -r readfile -w writefile"
	exit
else
	tekst=$1
	shift
fi

while [ "$1" != "" ]; do
	case $1 in
		"-d")
			shift
			kreska=$1
			shift
			;;
		"-k")
			shift
			kropka=$1
			shift
			;;
		"-s")
			shift
			spacja=$1
			shift
			;;
		"-r")
			shift
			_read=$1
			shift
			;;
		"-w")
			shfit
			_write=$1
			shift
			;;
	esac
done

dl=`echo $tekst | wc -m`
odpowiedz=""
literka=""
tmp=""

for i in `seq 1 1 $dl`; do 
	literka=`echo $tekst | cut -c $i`
	if [ "$literka" == " " ]; then
		odpowiedz="$odpowiedz|"
		continue
	fi
	tmp=`cat slownik | grep $literka 2>/dev/null | cut -d '#' -f 2`
	odpowiedz="$odpowiedz $tmp"
done

echo $odpowiedz
