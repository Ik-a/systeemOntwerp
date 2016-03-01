#include <string>


class instrument
{
public:
	instrument(void);
	void makeSound(std::string sound);
	void playTone(void);
	void makeMultipleSounds(int numTimes);
};