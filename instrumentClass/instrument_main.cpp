#include "instrument.h"
#include <cstdlib>

int main()
{
	srand(time(NULL));

	instrument inst;

	inst.makeSound("Tenenenenenene nehh nehhhhh");

	inst.playTone();
	inst.playTone();
	inst.playTone();

	inst.makeMultipleSounds(5);
}