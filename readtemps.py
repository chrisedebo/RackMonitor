#!/usr/bin/python

import os
import time

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

def temp_raw(temp_sensor):

    f = open(temp_sensor, 'r')
    lines = f.readlines()
    f.close()
    return lines

def read_temp(temp_sensor):

    lines = temp_raw(temp_sensor)
    while lines[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines = temp_raw()

    temp_output = lines[1].find('t=')

    if temp_output != -1:
        temp_string = lines[1].strip()[temp_output+2:]
        temp_c = float(temp_string) / 1000.0
        temp_f = temp_c * 9.0 / 5.0 + 32.0
        return temp_c, temp_f

def print_temps(sensorname,sensorid):
    sensorbase='/sys/bus/w1/devices/28-{}/w1_slave'
    temps=read_temp(sensorbase.format(sensorid))
    print('temperature_stats,probe={},w1id={},degrees_c={},degress_F={}'.format(sensorname,sensorid,temps[0],temps[1]))

#temp_sensor = '/sys/bus/w1/devices/28-0516a51072ff/w1_slave'
#temps=read_temp()

print_temps('cpu','0516a51072ff')
print_temps('air','0316a4be7fff')

