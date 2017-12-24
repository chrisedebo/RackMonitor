#!/usr/bin/env python

import os
import json
import time
import configparser

#Load w1 modules
os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

#Parse config
config = configparser.ConfigParser()
config.read('readtemps.cfg')
path = config.get('Config','sensorpath')
sensors = config.get('Config','sensors')

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

def print_temps(spath,sname,sid):
    temps=read_temp(spath)
    print('temperature_stats,probe={},w1id={} degrees_c={},degress_F={}'.format(sname,sid,temps[0],temps[1]))

for sensor in json.loads(sensors):
    sensorpath = '{}/{}/w1_slave'.format(path,sensor['id'])
    print_temps(sensorpath,sensor['name'],sensor['id'])

