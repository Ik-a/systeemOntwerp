#! /bin/bash

#Converter


if [ $# -lt 2 ]; then
	printf "%s\n" "Set input extension: .wav or .aiff" "Convert to extension: .mp3, .flac or .ogg"
	exit

else
	extIn=$1
	extOut=$2

	if 	([ $extIn == ".wav" ] || [ $extIn == ".aiff" ]) &&
		([ $extOut == ".mp3" ] || [ $extOut == ".flac" ] || [ $extOut == ".ogg" ]); then

		path="`pwd`/Converted_Files"

		echo `find *$1`
		printf "%s\n" "Convert $extIn files in `pwd` to $extOut files? (y/N)" 
		read usrinput

		if [ $usrinput == "y" ]; then

			if [ ! -d "$path" ]; then
				mkdir "$path"
			fi

			for i in *$extIn; do
				echo "Converting ${i}"
				outFile="`basename "${i}" $extIn`"
				lame -V2 "${i}" "${path}/${outFile}$2"
			done

			echo "Converted files can be found in `pwd`/Converted_Files"
			#CONVERT

		elif [ $usrinput == "N" ] || [ $usrinput == "n" ]; then
			echo "User break"
			exit
		fi

	else 
		printf "%s\n" "Invalid file type" "Input extension: .wav or .aiff" "Output extension: .mp3, .flac or .ogg"
		exit
	fi
fi