function [y_simu,y_th]=fun2(Relay_num)

%Optimal Relay and Single Jammer
%Intercept Probability

Maxpoint=fix(max(80,10)*1000);
sigma_si_2 = 0.1;
sigma_id_2 = 0.2;
sigma_ie_2 = 0.3;
SNR=0:2:40;
SNR_dB=10.^(SNR./10);
R=1;
delta=(2.^R-1)./SNR_dB;

% Real Value
y_th = 0;
for i_ = 0:Relay_num-1
    y_th = y_th + Relay_num.*exp(-delta./sigma_ie_2).*nchoosek(Relay_num-1, i_).*(-1).^i_./(2.^R.*(i_+1));
end

% Simulate
for i_ = 1:Relay_num
    h_si(i_, :) = sqrt(sigma_si_2./2).*randn(1,Maxpoint)+sqrt(-sigma_si_2./2).*randn(1,Maxpoint);
    h_id(i_, :) = sqrt(sigma_id_2./2).*randn(1,Maxpoint)+sqrt(-sigma_id_2./2).*randn(1,Maxpoint);
    h_ie(i_, :) = sqrt(sigma_ie_2./2).*randn(1,Maxpoint)+sqrt(-sigma_ie_2./2).*randn(1,Maxpoint);
end

% Best Relay
for i_ = 1:Maxpoint
    [max_num(i_), best_relay(i_)] = max(min(abs(h_si(:, i_)).^2,abs(h_id(:, i_)).^2));
end

% Thereom Value
for i_ = 1:Maxpoint
    h_be_2(i_) = abs(h_ie(best_relay(i_), i_)).^2;
    rand_h_je_2(i_) = abs(h_ie(mod(best_relay(i_), Relay_num) + 1, i_)).^2;
end
clear SNR SNR_dB delta
j_ = 1;
for SNR=0:2:40
    SNR_dB=10.^(SNR./10);
    delta=(2.^R-1)./SNR_dB;
    y_simu(j_)=sum(h_be_2 > rand_h_je_2.*(2.^R-1) + delta)/Maxpoint;
    j_ = j_ + 1;
end

end