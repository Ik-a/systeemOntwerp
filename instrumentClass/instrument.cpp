#include <iostream>
#include "instrument.h"
#include <string>


using namespace std;


//--------------------------------------------------------------

instrument::instrument(void)
{
	
}

//--------------------------------------------------------------

void instrument::makeSound(string sound)
{
	cout << sound << endl;
}

//--------------------------------------------------------------

void instrument::playTone(void)
{

	// int midiNote = rand() % 128;
	// int midiVel = rand() % 128;

	cout << "\nMIDI note value:\t" << rand() % 128 << endl;
	cout << "MIDI velocity value:\t" << rand() % 128 << endl; 
}

//--------------------------------------------------------------

void instrument::makeMultipleSounds(int numTimes)
{
	string array[] = {"Ratatakatata", "Tenenene tenene", "Bm Bm tsssk", "Brapababap bap bap", "Dunke dunk krak"};
	// int randIndex = rand() % 3;
	// thing = array[randIndex];

	cout << endl;

	for(int n=0; n < numTimes; n++){
		int randIndex = rand() % 5;
		string stuff = array[randIndex];
		this->instrument::makeSound(stuff);
	}
}