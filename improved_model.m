clear;

set_40_mph = readmatrix('2023-05-15_17-35-19_B2051_Transient_Fast_AllCAN_UW');
set_40_mph_table = readtable('2023-05-15_17-35-19_B2051_Transient_Fast_AllCAN_UW');


p = 1.225;
drag_coef = 0.8;
FA = 8.052; 
M_veh = 11000; 
M_veh_ton = M_veh / 1000; 
RRC = 3.5;
g = 9.8; 

% Assumptions

SPC = 50; % idle power consumption in kW 
p_loss = 0.8; % energy loss from power at batt -> tract power


v = set_40_mph(:, 6) ./ 3.6; %kmph to m/s
a = set_40_mph(:, 4); % already in m/s^2

t = set_40_mph(:, 1);

filler_term = ((-a .* v .* M_veh) / 1000) + 226; %filler for regenerative breaking 

aero_drag_term = (0.5 * p * FA * drag_coef) .* (v .^ 3); 
accel_term = M_veh .* a .* v; 
rr_term = (M_veh_ton * RRC * g) .* v; 


p_inst = aero_drag_term + accel_term + rr_term; 
p_inst_kw = p_inst ./ 1000;
p_inst_kw = p_inst_kw + filler_term;

batt_v = set_40_mph(:, 14);
batt_A = set_40_mph(:, 15);

p_batt = batt_v .* batt_A;
p_batt_kw = batt_v .* batt_A ./ 1000;

p_batt_adj = (p_batt_kw - SPC) .* p_loss; 

p_perc_diff = (p_batt_adj - p_inst_kw) ./ p_batt_adj * 100; 

p_diff = (p_batt_adj - p_inst_kw);

p_consump_batt = trapz(t, p_batt_adj) * (set_40_mph(end, 1) / 3600)
p_consump_calc = trapz(t, p_inst_kw) * (set_40_mph(end, 1) / 3600)

p_consump_meas = (set_40_mph(1, 22) - set_40_mph(end, 22)) * -1000


mean(abs(p_perc_diff));

% figure(1);
% plot(t, p_diff);
% 
figure(2);
plot(t, p_inst_kw);

figure(3);

plot(t, p_batt_adj);
% 
% figure(4);
% 
% plot(t, filler_term);


