clear;

drive_cycle = readmatrix('PACCARTruckDatav2');
drive_cycle_table = readtable('PACCARTruckDatav2');


% New coefficients
p = 1.225;
drag_coef = 0.5; 
FA = 10.3905; % m^2
M_veh = 36000; 
M_veh_ton = M_veh / 1000; 
RRC = 5; % converted * 1000
g = 9.8; 

% Assumptions

SPC = 50; % idle power consumption in kW 
p_loss = 0.8; % energy loss from power at batt -> tract power

data_size = size(drive_cycle);

t = (1:1:data_size(1))';
v = drive_cycle(:, 17) * .278;
h = drive_cycle(:, 18);

accel = zeros(size(v));
dh = zeros(size(h));

for i = 1:(data_size(1) - 1) 
    accel(i + 1) = v(i + 1) - v(i);
    dh(i + 1) = h(i + 1) - h(i);
end

brake_pos = drive_cycle(:, 6);


ratio = dh./v;
% ratio(isnan(ratio)) = 0; 
% ratio(isinf(ratio)) = 0; 
slope_grad_raw = asin(ratio);
slope_grad_raw = sqrt(real(ratio).^2 + imag(ratio).^2); 
slope_grad = real(asin(ratio));

slope_grad_adj = zeros(size(dh));
slope_grad_adj(dh < 0) = slope_grad_raw(dh < 0) .* -1; 
slope_grad_adj(dh > 0) = slope_grad_raw(dh > 0);
slope_grad_adj(isinf(slope_grad_adj)) = 0; 
slope_grad_adj(isnan(slope_grad_adj)) = 0; 



grav_term = (M_veh * g) .* slope_grad_adj .* v;
aero_drag_term = (0.5 * p * FA * drag_coef) .* (v .^ 3); 
accel_term = M_veh .* accel .* v; 
rr_term = (M_veh_ton * RRC * g) .* v; 
brake_term = (M_veh .* v .* accel .* 0.85);

motor_p = (drive_cycle(:, 7) .* drive_cycle(:, 9)) + (drive_cycle(:,8) .* drive_cycle(:, 10));
motor_p_kw = motor_p / 1000; 


p_calc = grav_term + aero_drag_term + accel_term + rr_term + brake_term;  
p_calc_kw = p_calc / 1000; 
p_calc_adj = p_calc_kw * 1.15; 

% 
% 
figure(1);
plot(t, p_calc_kw);
title("Overall Instantaneous Power");
xlabel("Time (s)");
ylabel("Power (kW)");


figure(2);
plot(t, motor_p_kw);
title("Motor Power");
xlabel("Time (s)");
ylabel("Power (kW)");



figure(3);
plot(t, (p_calc_kw - motor_p_kw));
title("Difference");

% 
% figure(4);
% plot(t, grav_term);
% title("Gravity Term");
% figure(5);
% plot(t, grav_term_new);
% title("New Gravity Term");

% 
% figure(5);
% plot(t, aero_drag_term);
% title("Aero Drag Term");
% 
figure(6);
plot(t, accel_term);
title("Accel Term");
% 
% figure(7);
% plot(t, rr_term);
% title("Rolling Res Term");
% 
% figure(8);
% plot(t, brake_pos);


p_consump_prediction = trapz(t, p_calc_kw)
p_consump_motor = trapz(t, motor_p_kw)


