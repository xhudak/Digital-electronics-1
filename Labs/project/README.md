# Lab 9-13: Ultrazvukový měřič vzdálenosti HC-SR04. Výstup na 7segmentovém displeji.

#### Objectives

TBD


## Hardware description
&nbsp;
  ![HC-SR04](../../Images/ultrazvuk_A.jpg)
&nbsp;

Senzor HC-SR04 merá vzdialenosť pomocou vysielaných ultrazvukových vĺn o frekvencií 40k Hz.

Konfigurácia pinov:
- VCC: +5V
- TRIG - vysielač
- ECHO - prijímač
- GND - zem

&nbsp;&nbsp;
  ![HC-SR04](../../Images/ultrazvuk_B.jpg)
&nbsp;

Pomocou senzoru dokážeme merať vzdialenosť dobou, ktorá uplynie od vyslania pulzu, odrazenia sa od objeku po jeho príjem.

distance = (traveltime/2) * speed_of_sound
343 m/s = 0.0343 cm/us

cm = (durations/2) * 0.0343

## Code description

TBD


## Video

TBD


## References

https://create.arduino.cc/projecthub/abdularbi17/ultrasonic-sensor-hc-sr04-with-arduino-tutorial-327ff6
