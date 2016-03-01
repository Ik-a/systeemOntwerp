#! /bin/bash


dirArray=( Unaltered Far Broken Weird )
path=`pwd`/Comp
d="${#dirArray[@]}"

######################################################

echo ${#a[@]}

echo ${a[(RANDOM % 5)]}

if [ $# -lt 1 ]; then
	echo "Set input extension"
	exit

else 
	printf "%s\n" "This script will modify audio files in `pwd` and put them in their respective folder" 
	printf "\t%s\n" "5 sec unaltered" "4 sec far" "2 sec broken" "6 sec weird" ""

	extIn=$1

	path="`pwd`/'${directoryArray[@]}'"

	directoryArray=( Original Normalized Unaltered Far Broken Weird )

	compDirArray=( Unaltered Far Broken Weird)

	printf "%s\n" `find *$1`
	echo "Start processing $extIn files in `pwd`? (y/N)" 
	read usrinput

	if [ $usrinput == "y" ] || [ $usrinput == "Y" ]; then

		# If a directory from directoryArray does not exist, it wil be created
		if [ ! -d '${directoryArray[@]}' ]; then
			mkdir "${directoryArray[@]}" 
		fi

		# Convert .mp3 files to .wav files
		for f in *.mp3; do 
			lame --decode "$f" "`pwd`/${f%.mp3}.wav"
		done

		mv *.mp3 ${directoryArray[0]}

		# Normalize and rename files
		for i in *.wav; do
			sox $i norm$i --norm=-6 channels 2 rate 44.1k
			echo "Normalizing `basename "${i}"`"
		 	rm ${i}
		done
		
		for i in *.wav; do
			sox $i ${directoryArray[2]}/${directoryarray[2]}_$i trim 00 05 fade h 0:01 0 0:01

			sox $i ${directoryArray[3]}/${directoryArray[3]}_$i trim 05 04 sinc -2k reverb 25 
			cd `pwd`/${directoryArray[3]}
			sox --norm=-6 "${directoryArray[3]}_$i" "${directoryArray[3]}-_$i" fade h 00:01 0 00:01	
			rm "${directoryArray[3]}_$i"
			cd ..

			sox $i ${directoryArray[4]}/${directoryArray[4]}_$i trim 09 02 sinc 1.5k-6k overdrive 20 20
			cd `pwd`/${directoryArray[4]} 
			sox --norm=-6 "${directoryArray[4]}_$i" "${directoryArray[4]}-_$i" fade h 0:01 0 0:01 
			rm "${directoryArray[4]}_$i"
			cd ..

			sox $i ${directoryArray[5]}/${directoryArray[5]}_$i trim 11 06 reverb -w reverse
			cd `pwd`/${directoryArray[5]} 
			sox --norm=-6 "${directoryArray[5]}_$i" "${directoryArray[5]}-_$i" fade h 0:01 0 0:01 
			# rm "${directoryArray[5]}_$i"
			cd ..
		done

		mv *.wav ${directoryArray[1]}
		
		printf "%b\n" "5 sec Unaltered\t-->\tUnaltered" "4 sec Far\t-->\tFar" "2 sec Broken\t-->\tBroken" "6 sec Weird\t-->\tWeird"

	elif [ $usrinput == "N" ] || [ $usrinput == "n" ]; then
		echo "User Break"
		exit
	fi

fi

#####################################################
# BELOW IS WORK IN PROGRESS!
#####################################################

# s=0
# #for i in {1..2}; do 

# lengthArray=( 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2)
# lA="${#lengthArray[@]}"
# a="${lengthArray[(RANDOM % $lA)]}"

# until [ $s -ge 60 ]; do

# 		cd ${dirArray[(RANDOM % $d)]}

# 		# Fill array with items in current folder
# 		array=( * )

# 		# Number of elements in array
# 		i="${#array[@]}"

# 		# Pick random element from array
# 		r=${array[(RANDOM % $i)]}

# 		for r in *.wav; do
# 		randomGain="$((RANDOM % 24))"

# 		sox "$r" "trimmed_$r" trim 0 "$a" fade h 0 0 0:01 gain -$randomGain
# 		# echo "$randomGain" 
# 		# rm "$r"
# 		done

# 		cp $r $path/$r

#  		cd $path

# 		for f in *.wav; do
# 			n=$(soxi -s $f)
# 			TOTAL=$(( $TOTAL + $n ))
# 			s=$(( $TOTAL / 44100 ))

# 		done

# 		echo "$s sec."
		
# 		TOTAL=0

# 		cd ..

# done

#####################################################

# lengthArray=( 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2)
# lA="${#lengthArray[@]}"
# a="${lengthArray[(RANDOM % $lA)]}"

# echo "$a"

# cd $path

# for r in *.wav; do
# 	randomGain="$((RANDOM % 24))"

# 	sox "$r" "trimmed_$r" trim 0 "$a" fade h 0 0 0:01 gain -$randomGain
# 	echo "$randomGain" 
# 	# rm "$r"
# done

# sox *.wav comp1.wav



