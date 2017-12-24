#! /bin/sh
#====================================================================#
#                                                                    #
#    Description: Install and configure Metrics Stack                #
#         Author: Chris Nicel                                        #
#           Date: 2017-12-24                                         #
#        Summary: Install telegraf, influxdb, graphana and kapacitor #
#                 for colelction, storage, analysis and monitoring/  #
#                 alerting                                           #
#                                                                    #
#====================================================================#

#Install https transport for apt
sudo apt install apt-transport-https -y

#Add gpg keys for influxdata and graphana
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
curl https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -

#Add influxdata repository
echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
echo "deb https://dl.bintray.com/fg2it/deb stretch main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install influxdb telegraf kapacitor grafana -y

