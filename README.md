# RackMonitor

Python scripts to read several DS18B20 1 wire digital temperature sensors connected to the GPIO pins on a raspberry pi. The readings will be stored in influxdb for analysis with graphana.

Kapacitor will monitor the influxdb data and alert via email for configurable thresholds. Scope for additional actions such as server shutdown if temperature exceeds limits.

Telegraf will execute the scritps and collect the temperature stats. It will also collect statitics from the raspberry pi host.
