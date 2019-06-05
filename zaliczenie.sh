#!/bin/bash

while [ "$#" != 1 ]; do
	case $1 in
		"-h")
			shift
			echo "translator alfabetu lacinskiego na morsa"
			echo "uzyj bez argumentow lub ze switchem -h aby wyswietlic pomoc"
			echo "uzyj switcha -w plik_wyjsciowy.txt aby zapisac do pliku"
			echo -e "uzyj switcha -r plik_wejsciowy.txt \"\" pamietajac o dodaniu pustych \"\" na koncu komendy aby wczytac tekst z pliku wejsciowego"
			echo "uzyj switchy -d znak -k znak -s znak aby ustawic symbol kreski kropki i odstepu respectively"
			echo "example: ./morse.sh -d s -s v -k @ -w wyzszosc_pp_nad_uamem.txt \"FOEIJS OEIJF OIWE\""
			echo "nalezy pamietac o wpisywaniu tekstu zlzonego z wielu slow w cudzyslow"
			exit
			;;
		"")
			shift
			echo "./zaliczenie "tekst" -d kreska -k kropka -s separator -r readfile -w writefile"
			exit
			;;

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
			shift
			_write=$1
			shift
			;;
	esac
done

tekst=$1

if [ "$_read" != "" ]; then
	tekst=`cat $_read`
fi

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

if [ "$kropka" != "" ]; then
	odpowiedz=`echo $odpowiedz | tr '.' $kropka`
fi


if [ "$kreska" != "" ]; then
	odpowiedz=`echo $odpowiedz | tr '_' $kreska`
fi

if [ "$spacja" != "" ]; then
	odpowiedz=`echo $odpowiedz | tr ' ' $spacja`
fi

if [ "$_write" != "" ]; then
	echo "$odpowiedz" > "$_write"
	exit
fi

echo $odpowiedz
