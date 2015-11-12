##Midterm Writeup
Daniel Bishop

###Table of Contents
1. [Specifications](#specifications)
  1. [I/O](#io)
  2. [Operational Modes](#operational-modes)
    1. [FSM](#finite-state-machine)
  3. [Dimensions](#dimensions)
2. [Block Diagram](#block-diagram)
3. [Schematic](#schematic)
  1. [Top Level](#total-circuit)
  2. [Input Conditioner](#input-conditioner)
  3. [Shifter](#shifter)

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
![fsm image](http://i.imgur.com/S7b8XpO.png)  

####Dimensions
<TODO>

###Block Diagram
![block diagram image](http://i.imgur.com/WXlwaXM.png)

###Schematic  

####Total Circuit  
![schematic high level](http://i.imgur.com/te9xqFK.png)
This circuit uses an input conditioner to debounce the physical button input. On the rising edge of the button signal (when the button is pressed down), a 4-stage ring-counter increments by 1. The output of this ring-counter is the current mode of the LED, using a one-hot encoding. This 4-bit value is passed on to an 8-to-1 multiplexer which passes the corresponding driver signal to the LED. The multiplexer is an 8-to-1 instead of a 4-to-1 because of the one-hot encoding of the mode, where the 4 modes correspond to values of 1 (0b0001), 2 (0b0010), 4 (0b0100), and 8 (0b1000). The ON and OFF driver circuits are fairly self-explanatory, they hold values at 1 and 0 respectively. The BLINKING driver circuit uses a 100-stage ring-counter to toggle the LED every second. The DIM driver circuit wires the system clock (100Hz) directly to a 2-to-1 multiplexer to toggle the LED value every .01 seconds. This results in a 50% duty cycle for the LED, effectively dimming the LED by half.

####Input Conditioner  
![schematic input conditioner](http://i.imgur.com/8cwSvZ1.png)
The input conditioner synchronizes a noisy input signal (coming from the button) and debounces it with a wait time of 3 clock cycles (.03 seconds) using a version of a ring-counter. The input conditioner outputs a filtered input signal, as well as signals for detecting rising and falling edges in the filtered signal.

####Shifter  
![schematic shifter](http://i.imgur.com/qClMSGM.png)
This component takes a 4-bit number and shifts the bits to the left by one place. The Least Significant Bit is filled with a 0.