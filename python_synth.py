
import pyaudio
import time
import numpy as np
import array

from Tkinter import *

######################################################################################

WIDTH = 2 # sample size in bytes
CHANNELS = 1 # number of samples in a frame
RATE = 44100
FRAMESPERBUFFER = 256

vol1=0
# vol2=0
# vol3=0

freq1=220.0
# freq2=220.0
# frew3=220.0

waveform1=1
# waveform2=1
# waveform3=1

pw=0

######################################################################################

def get_vol1(val):
  global vol1
  vol1 = float(val)
  vol1 = vol1*0.01

def get_freq1(val):
  global freq1
  freq1=float(val)

def get_pw(val):
  global pw
  pw = float(val)
  pw = pw*0.01

class Application(Frame):
  
  def __init__(self, master):
    Frame.__init__(self, master)
    self.grid()
    self.createWidgets()

  def createWidgets(self):

    self.button1 = Button(self, text="Sine", command=sine)
    self.button1.grid(row=1, column=1)
    self.button2 = Button(self, text="Saw", command=saw)
    self.button2.grid(row=3, column=1)
    self.button3 = Button(self, text="Square", command=square)
    self.button3.grid(row=5, column=1)
    self.button4 = Button(self, text="Sweep", command=sweep)
    self.button4.grid(row=7, column=1)

    self.sineVol = Scale(self, from_=0, to=100, command=get_vol1)
    self.sineVol.config(orient=HORIZONTAL, length=150)
    self.sineVol.grid(row=2, column=4, sticky=E)
    self.sineVol.set(0)

    self.sineFreq = Scale(self, from_=0, to=3000, command=get_freq1)
    self.sineFreq.config(orient=HORIZONTAL, length=150)
    self.sineFreq.grid(row=4, column=4, sticky=E)
    self.sineFreq.set(220)
 
    self.pw = Scale(self, from_=1, to=99, command=get_pw)
    self.pw.config(orient=HORIZONTAL, length=150)
    self.pw.grid(row=6, column=4, sticky=E)
    self.pw.set(0)    


######################################################################################

#
# Function showDevices() lists available input- and output devices
#
def showDevices(p):
  info = p.get_host_api_info_by_index(0)
  numdevices = info.get('deviceCount')
  for i in range (0,numdevices):
    if p.get_device_info_by_host_api_device_index(0,i).get('maxInputChannels')>0:
      print "Input Device id ", i, " - ", p.get_device_info_by_host_api_device_index(0,i).get('name')
    if p.get_device_info_by_host_api_device_index(0,i).get('maxOutputChannels')>0:
      print "Output Device id ", i, " - ", p.get_device_info_by_host_api_device_index(0,i).get('name')

#
# Create array of signed ints to hold one sample buffer
# Make it global so it doesn't get re-allocated for every frame
#
outbuf = array.array('h',xrange(FRAMESPERBUFFER)) # array of signed ints


#
# Create the callback function which is called by pyaudio
#   whenever it needs output-data or has input-data
#
# As we are working with 16-bit integers, the range is from -32768 to 32767
#

def sine():
  global waveform1

  waveform1 = 1

def saw():
  global waveform1

  waveform1 = 2

def square():
  global waveform1

  waveform1 = 3

def sweep():
  global freq1

  originalFreq = freq1

  for freq1 in range(199, 1500):
    freq1 = freq1 + 1
    time.sleep(0.0076)
    print freq1
  freq1 = originalFreq

def callback(in_data,frame_count,time_info,status):

  global phase
  global outbuf
  global waveform1
  global sq

  for n in range(frame_count):

    phase += 2*np.pi*freq1/RATE
    # sq = np.sin(phase)
    sq=1

    if sq > pw:
      sq = 1
    else:
      sq = -1

    if waveform1 == 1:
      outbuf[n] = int(32767 * vol1* np.sin(phase))

    if waveform1 == 2:
      outbuf[n] = int(32767 * vol1* np.sin(phase % 1 * 2 - 1))

    if waveform1 == 3:
      if sq > pw:
        sq = 1
      else:
        sq = -1
      outbuf[n] = int(32767 * vol1* sq)

 
  return (outbuf,pyaudio.paContinue)


	  #########################
	  # Start of main program #
	  #########################

#
# get a handle to the pyaudio interface
#

paHandle = pyaudio.PyAudio()

# select a device
showDevices(paHandle)
outputDevice=input("Choose output device")
devinfo = paHandle.get_device_info_by_index(outputDevice)
print "Selected device name: ",devinfo.get('name')

phase=0 # sine phase

#
# open a stream with some given properties
#
stream = paHandle.open(format=paHandle.get_format_from_width(WIDTH),
		channels=CHANNELS,
		rate=RATE,
		frames_per_buffer=FRAMESPERBUFFER,
		input=False, # no input
		output=True, # only output
		output_device_index=outputDevice, # choose output device
		stream_callback=callback)

stream.start_stream()

root= Tk()

app = Application(root)

#  Make sure that the main program doesn't finish until all
#  audio processing is done
while stream.is_active():
  root.mainloop()
  time.sleep(0.1)

# in this example you'll never get here
stream.stop_stream()
stream.close()

paHandle.terminate()
