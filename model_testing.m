set_40_mph = readmatrix('2023-05-15_17-29-06_B2051_SteadyState_AllCAN_55mph_UW');
set_40_mph_table = readtable('2023-05-15_17-29-06_B2051_SteadyState_AllCAN_55mph_UW');

air_res = 0.0706; 
roll_res = 27.93;
mass_veh = 909; 

t = set_40_mph(:, 1);
v = set_40_mph(:, 6);
%v = v .* 1000 ./ 3600; 
a = set_40_mph(:, 4);

p_inst = (air_res.*(v.^3)) + (roll_res.*v) + (mass_veh .* v .* a); 

d = (set_40_mph(484, 5) - set_40_mph(1, 5)) * 1000; 

enrgy_cons = trapz(t, p_inst) * -2.7778e-7;

p_inst_kW = p_inst .* 2.7778e-7;
p_inst_kW_meas = set_40_mph(:, 23);

enrgy_cons_meas = (set_40_mph(484, 22) - set_40_mph(1, 22));

accuracy = ((enrgy_cons_meas - enrgy_cons) / enrgy_cons_meas) * 100

figure(1);
plot(t, p_inst_kW_meas);

figure(2);
plot(t, p_inst_kW);






