Label descriptions for 2023 UW project
* Time [s] = time in seconds
* TotalVehicleDistance [km] = Same as vehicle mileage in km. Use to determine distance traveled between data points.
* VehicleSpeed [kph] = Vehicle speed in kph
* VehicleAcceleration [m/s^2] = Vehicle acceleration as measured by the telematics, may be useful?
* AmbientAirTemperature [C] = Outside air temperature
* AcceleratorPedalPosition [%] = "Gas" or throttle pedal position in percent of travel. Will be 0 if cruise control is used
* CruiseControlActive = To know why accel pedal may be at 0 but vehicle is moving
* BrakePedalActive = To know when the brake is being used to slow down (instead of or with regeneration)
* BatteryVoltage [V] = Current battery voltage
* BatteryCurrent [A] = Current battery current
* BatterySOC [%] = Battery state of charge as a percentage (like your phone % charged)
* BatterySOH [%] = Battery state of health as a percentage to show battery system degradation
* BatteryMaxSOC [%] = Maximum SOC allowed
* BatteryMinSOC [%] = Minimum SOC allowed (can't go to 0)
* MotorSpeed [rpm] = electric motor speed
* RegenTorqueAvailable [Nm] = Maximum amount of regen torque available (slow down)
* TractionTorqueAvailable [Nm] = Maximum amount of traction torque available (forward movement)
* BatteryMaxVoltage [V] = Maximum voltage allowed
* BatteryMinVoltage [V] = Minimum voltage allowed
* CommandedMotorTorque [Nm] = Amount of torque system is delivering (+ is draining battery, - is charging battery)
* BatteryMaxEnergy [kWh] = Battery storage capacity maximum
* BatteryEnergy_calc [kWh] = Current battery energy calculated (BatteryMaxEnergy * BatterySOC)
* MotorPower_calc [kW] = current power used by the system calculated (BatteryVoltage * BatteryCurrent)

Truck is a KW270E with 355hp motor and 141kWh battery
* Frontal Area = 96" x 151"
