
![Header](https://i.imgur.com/jSZbZhY.png)
# Termometr flutter app

An application that reads the signal from the circuit and calculates the room temperature based on it.

The project began with designing and building a circuit that would respond to changes in temperature. This is how the thermometer shown in the photo was created. The main components of the circuit are an NE555 integrated circuit and a thermistor. The NE555 generates a rectangular signal, and the thermistor adjusts the frequency of the signal by changing the resistance.

The application pushes the signal back through the JACK. It then calculates the frequency of this signal, from which it calculates the temperature.

![image_1](https://i.imgur.com/joXPk2V.jpg)
## Used Packages

* **scidart**

    Used for signal processing. Fast Fourier transform to determine the frequency of a signal. 
* **flutter_audio_capture**

    Used to record a sample of the signal.
* **syncfusion_flutter_charts**

    Used to visually illustrate the result of an FFT
## Screenshots

![App Screenshot](https://i.imgur.com/LjH4IBy.gif)

