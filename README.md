# Garmin Edge - Active data field

A garmin edge data field which adaps to what sensors you have available and your
current status, eg: stopped, descending, climbing

## Setup

- Install the Garmin SDK: https://developer.garmin.com/connect-iq/sdk/ (any
connectIQ version is find, in the devices section be sure to select all of the
edge devices) - Install Java **below** Java 12. The reason for this is, Java 12
stopped shipping with a JAR neccessary for the Garmin SDK - Update the
properties.mk file to point to your garmin SDK install location - Update the
properties.mk file to include your garmin private key

## Running in the simulator

To test out the application on the simulator you can run the command below. If
you want to change the device you can change it in the properties.mk file. You
can see a full list of supported devices in the manifest.xml


```sh make run ```