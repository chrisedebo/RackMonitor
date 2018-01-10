#! /bin/sh
#====================================================================#
#                                                                    #
#    Description: Configure Metrics Stack                            #
#         Author: Chris Nicel                                        #
#           Date: 2017-12-24                                         #
#        Summary: Configure telegraf, influxdb, graphana and         #
#                 kapacitor for colelction, storage, analysis and    #
#                 monitoring/alerting                                #
#                                                                    #
#====================================================================#

#Create and configure Influx metrics DB, users and permissions
influx -execute "CREATE USER admin WITH PASSWORD 'bananas' WITH ALL PRIVILEGES"
influx -execute "CREATE USER telegraf WITH PASSWORD 'blackcurrants' WITH ALL PRIVILEGES"
influx -execute "CREATE USER grafana WITH PASSWORD 'apples'"
influx -execute "CREATE USER kapacitor WITH PASSWORD 'oranges' WITH ALL PRIVILEGES"
influx -execute "CREATE USER rackmonitor WITH PASSWORD 'strawberries'"
influx -execute "CREATE DATABASE rackmonitor"
influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE RETENTION POLICY onemonth ON rackmonitor DURATION 30d REPLICATION 1 DEFAULT"
influx -database "rackmonitor" -execute "GRANT READ ON rackmonitor TO grafana"
influx -database "rackmonitor" -execute "GRANT WRITE ON rackmonitor TO rackmonitor"
influx -database "telegraf" -execute "GRANT READ ON telegraf TO grafana"

#Enable Influx Authentication
sudo sed -i 's/  # auth-enabled = false/auth-enabled = true/' /etc/influxdb/influxdb.conf
sudo service influxdb restart

#Configure Kapacitor
sudo sed -i '0,/  username = ""/s//  username = "kapacitor"/' /etc/kapacitor/kapacitor.conf
sudo sed -i '0,/  password = ""/s//  password = "oranges"/' /etc/kapacitor/kapacitor.conf
sudo service kapacitor restart

#Configure Telegraf
sudo sed -i 's/  # password = "metricsmetricsmetricsmetrics"/  password = "blackcurrants"/' /etc/telegraf/telegraf.conf
sudo service telegraf restart

