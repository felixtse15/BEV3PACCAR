clear;

set_40_mph = readmatrix('2023-05-15_17-07-32_B2051_SteadyState_AllCAN_40mph_UW');
set_40_mph_table = readtable('2023-05-15_17-07-32_B2051_SteadyState_AllCAN_40mph_UW');


p = 1.225;
drag_coef = 0.67;
FA = 8.052; 
M_veh = 20000; 
M_veh_ton = M_veh / 1000; 
RRC = 0.87;
g = 9.8; 

% Assumptions

SPC = 20; % idle power consumption in kW 
p_loss = 0.8; % energy loss from power at batt -> tract power


v = set_40_mph(:, 6) ./ 3.6; %kmph to m/s
a = set_40_mph(:, 4);
t = set_40_mph(:, 1);

aero_drag_term = (0.5 * p * FA * drag_coef) .* (v .^ 3); 
accel_term = M_veh .* a .* v; 
rr_term = (M_veh_ton * RRC * g) .* v; 

p_inst = aero_drag_term + accel_term + rr_term; 
p_inst_kw = p_inst ./ 1000; 

batt_v = set_40_mph(:, 14);
batt_A = set_40_mph(:, 15);


p_batt_kw = batt_v .* batt_A ./ 1000;

p_batt_adj = (p_batt_kw - SPC) .* p_loss; 

p_perc_diff = (p_batt_adj - p_inst_kw) ./ p_batt_adj * 100; 

mean(abs(p_perc_diff))



