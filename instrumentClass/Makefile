instrument: instrument.o instrument_main.o
	g++ -o instrument instrument.o instrument_main.o

instrument.o: instrument.cpp
	g++ -c instrument.cpp

instrument_main.o: instrument_main.cpp
	g++ -c instrument_main.cpp

clean:
	/bin/rm -f instrument *.o