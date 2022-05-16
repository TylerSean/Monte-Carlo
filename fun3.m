function [y_simu,y_th]=fun3(Relay_num)

%Outage Probability

Maxpoint=fix(max(80,10)*1000);
sigma_si_2 = 0.1;
sigma_id_2 = 0.2;
sigma_ie_2 = 0.3;
SNR=0:2:40;
SNR_dB=10.^(SNR./10);
R=1;
delta=(2.^R-1)./SNR_dB;

% OP Real Value
y_th = 0;
for i_ = 0:Relay_num
    rho = -delta./sigma_si_2-delta./sigma_id_2;
    y_th = y_th + (-1).^i_.*nchoosek(Relay_num, i_).*exp(rho.*i_);
end

% Simulate
for i_ = 1:Relay_num
    h_si(i_, :) = sqrt(sigma_si_2./2).*randn(1,Maxpoint)+sqrt(-sigma_si_2./2).*randn(1,Maxpoint);
    h_id(i_, :) = sqrt(sigma_id_2./2).*randn(1,Maxpoint)+sqrt(-sigma_id_2./2).*randn(1,Maxpoint);
end

% Thereom Value
min_h = min(abs(h_si).^2,abs(h_id).^2);
for i_ = 1:Maxpoint
    max_C_s(i_) = max(min_h(:, i_));
end
i_ =1;
clear SNR SNR_dB delta
for SNR=0:2:40
    SNR_dB=10.^(SNR./10);
    delta=(2.^R-1)./SNR_dB;
    y_simu(i_)=sum(max_C_s < delta)./Maxpoint;
    i_ = i_ +1;
end

end