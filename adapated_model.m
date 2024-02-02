km_in_1hr;
kWhr_per_hr;
km_range_of_battery;
category;
secs_to_full_stop;
secs_to_full_speed;
result = document.getElementById("result");
result1 = document.getElementById("result1");
result2 = document.getElementById("result2");
result3 = document.getElementById("result3");
result4 = document.getElementById("result4");

var total_descent_m = parseInt(document.getElementById("total_descent_m").value);
document.getElementById("total_descent_m-val").textContent = total_descent_m + " total_descent_m";

var max_speed = parseInt(document.getElementById("max_speed").value);
document.getElementById("max_speed-val").textContent = max_speed + " max_speed";

var stops_per_hour = parseInt(document.getElementById("stops_per_hour").value);
document.getElementById("stops_per_hour-val").textContent = stops_per_hour + " stops_per_hour";

var stop_time_secs = parseInt(document.getElementById("stop_time_secs").value);
document.getElementById("stop_time_secs-val").textContent = stop_time_secs + " stop_time_secs";

var total_climb_m = parseInt(document.getElementById("total_climb_m").value);
document.getElementById("total_climb_m-val").textContent = total_climb_m + " total_climb_m";

var regen_efficiency = parseInt(document.getElementById("regen_efficiency").value);
document.getElementById("regen_efficiency-val4").textContent = regen_efficiency + " regen_efficiency";

var kwhr_battery_size = parseInt(document.getElementById("kwhr_battery_size").value);
document.getElementById("kwhr_battery_size-val5").textContent = kwhr_battery_size + " kwhr_battery_size";

category = "Excellent Range";
secs_to_full_stop = 15;
secs_to_full_speed = 15;
km_in_1hr = ((((1-(stops_per_hour*((secs_to_full_stop+stop_time_secs+secs_to_full_speed)/60)/60))) * max_speed) + ((stops_per_hour*((secs_to_full_stop+secs_to_full_speed)/60)/60)*(max_speed/2))) + (stop_time_secs*0);
kWhr_per_hr = 0.0364*(max_speed*max_speed*max_speed)/1000*((1-(stops_per_hour*((secs_to_full_stop+stop_time_secs+secs_to_full_speed)/60)/60))) + 433*(max_speed)/1000*((1-(stops_per_hour*((secs_to_full_stop+stop_time_secs+secs_to_full_speed)/60)/60))) + (stops_per_hour*(0.5*919*max_speed*max_speed)/3600000) - ((regen_efficiency/100)*stops_per_hour*(0.5*919*max_speed*max_speed)/3600000) + (919*9.6*(total_climb_m)/3600000) - ((regen_efficiency/100)*919*9.6*(total_descent_m)/3600000) ;
km_range_of_battery = km_in_1hr * (kwhr_battery_size/kWhr_per_hr);
result.textContent = (km_in_1hr/1.609344).toFixed(2) + " mi_in_1hr";
result1.textContent = km_in_1hr.toFixed(2) + " km_in_1hr";
result2.textContent = km_range_of_battery.toFixed(2) + " km_range_of_battery";
result3.textContent = (km_range_of_battery/1.609344).toFixed(2) + " mile_range_of_battery";
result4.textContent = kWhr_per_hr.toFixed(2) + " kWhr_per_hr";