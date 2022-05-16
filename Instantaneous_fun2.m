clear
Relay_num=2;
[y_simu,y_th]=fun2(Relay_num);
x = 0:2:40;
p1 = semilogy(x, y_simu,'rs');
hold on
p2 = semilogy(x, y_th,'-r');

Relay_num=4;
[y_simu1,y_th1]=fun2(Relay_num);
p3 = semilogy(x, y_simu1,'go');
p4 = semilogy(x, y_th1,'-g');

Relay_num=6;
[y_simu2,y_th2]=fun2(Relay_num);
p5 = semilogy(x, y_simu2,'b*');
p6 = semilogy(x, y_th2,'-b');

legend([p1 p2 p3 p4 p5 p6], ...
{'M=2时，窃听概率实际值', 'M=2时，窃听概率理论值', 'M=4时，窃听概率实际值',  ...
'M=4时，窃听概率理论值', 'M=6时，窃听概率实际值', 'M=6时，窃听概率理论值'}, ...
'Location','southeast');

xlabel('信噪比（SNR）');
ylabel('窃听概率实际值与理论值对比');
title('ORSJS 窃听概率实际值与理论值对比');