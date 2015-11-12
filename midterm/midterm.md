##Midterm Writeup
Daniel Bishop

###Table of Contents
1. [Specifications][]
  1. [I/O][]
  2. [Operational Modes][]
    1. [Finite State Machine][]
  3. [Dimensions][]]

###Specifications
####I/O
User provides input via one push-button.
System provides output to one LED whose state can either be ON or OFF.
####Operational Modes
1. ON: LED is powered
2. OFF: LED is unpowered
3. BLINKING: LED switches between ON and OFF states every second (1Hz frequency)
4. DIM: LED switches between ON and OFF states every hundredth of a seconds (100Hz frequency).
#####Finite State Machine
![FSM](http://i.imgur.com/S7b8XpO.png)  
####Dimensions
