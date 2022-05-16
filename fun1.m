function [y_simu,y_th]=fun1(Relay_num)

%Optimal Relay and All Jammers
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
rho = 1./sigma_ie_2;
lambda = sigma_ie_2.*(2.^R-1);
y_th = 0;
sum_1 = 0;

for j_ = 0:Relay_num-1
    sum_1 = sum_1 + nchoosek(Relay_num-1, j_).*(-1).^j_./(j_+1);
end

for i_ = 1:Relay_num
    sum_ = 0;
    for k_ = 0:Relay_num-2
        sum_ = sum_ + rho.*exp(-rho.*delta).*(rho+1./lambda).^(-k_-1)./lambda.^k_;
    end
    y_th = y_th + (exp(-rho.*delta)-sum_).*sum_1;
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
sum_ = 0;
for i_ = 1:Relay_num
    sum_ = sum_ + abs(h_ie(i_)).^2;
end
sum_h_ie(Relay_num, Maxpoint) = 0;

for i_ = 1:Maxpoint
    h_be(i_) = abs(h_ie(best_relay(i_), i_)).^2;
    for j_ = 1:Relay_num
        sum_h_ie(i_) = sum_h_ie(i_) + abs(h_ie(j_, i_)).^2;
    end
    sum_h_ie_ex_b(i_) = sum_h_ie(i_) - h_be(i_);
end

i_ = 1;
for SNR=0:2:40
    SNR_dB=10.^(SNR./10);
    delta=(2.^R-1)./SNR_dB;
    y_simu(i_)=sum(h_be > sum_h_ie_ex_b.*(2.^R-1) + delta)/Maxpoint;
    i_ = i_ + 1;
end

end