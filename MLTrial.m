data = readtable('2023-05-15_17-07-32_B2051_SteadyState_AllCAN_40mph_UW.csv');

features = data{:, {'VehicleSpeed_kph_', 'VehicleAcceleration_m_s_2_', 'BatterySOC___', 'MotorPower_calc_kW_', }};
target = data{:, 'TotalVehicleDistance_km_'};

rng(42);
split_ratio = 0.8; 
split_idx = randperm(size(data, 1), round(split_ratio * size(data, 1)));

train_data = data(split_idx, :);
test_data = data(setdiff(1:size(data, 1), split_idx), :);

X_train = train_data{:, {'VehicleSpeed_kph_', 'VehicleAcceleration_m_s_2_', 'BatterySOC___', 'MotorPower_calc_kW_'}};
y_train = train_data{:, 'TotalVehicleDistance_km_'};
X_test = test_data{:, {'VehicleSpeed_kph_', 'VehicleAcceleration_m_s_2_', 'BatterySOC___', 'MotorPower_calc_kW_'}};
y_test = test_data{:, 'TotalVehicleDistance_km_'};

mdl = fitlm(X_train, y_train);

y_pred = predict(mdl, X_test);
mse = mean((y_test - y_pred).^2);
disp(['Mean Squared Error: ', num2str(mse)]);

figure;
scatter(y_test, y_pred);
hold on;
plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], '--k');
xlabel('Actual Range');
ylabel('Predicted Range');
title('Actual vs. Predicted Range');
legend('Predictions', 'Perfect Fit');
