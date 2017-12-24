# RackMonitor

Python scripts to read several DS18B20 1 wire digital temperature sensors. The readings will be stored in influxdb for analysis with graphana.

Kapacitor will monitor the influxdb data and alert via email for configurable thresholds. Scope for additional actions such as server shutdown if temperature exceeds limits.

