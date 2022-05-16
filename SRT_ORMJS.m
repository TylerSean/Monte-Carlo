clear
Relay_num=2;
[y_simu_IP_1, y_th_IP_1]=fun1(Relay_num);
[y_simu_OP_1, y_th_OP_1]=fun3(Relay_num);
p1 = loglog(y_simu_OP_1, y_simu_IP_1,'rs');
hold on
p2 = loglog(y_th_OP_1, y_th_IP_1,'-r');

Relay_num=4;
[y_simu_IP_2, y_th_IP_2]=fun1(Relay_num);
[y_simu_OP_2, y_th_OP_2]=fun3(Relay_num);
p3 = loglog(y_simu_OP_2, y_simu_IP_2,'go');
p4 = loglog(y_th_OP_2, y_th_IP_2,'-g');

Relay_num=6;
[y_simu_IP_3, y_th_IP_3]=fun1(Relay_num);
[y_simu_OP_3, y_th_OP_3]=fun3(Relay_num);
p5 = loglog(y_simu_OP_3, y_simu_IP_3,'b*');
p6 = loglog(y_th_OP_3, y_th_IP_3,'-b');

legend([p1 p2 p3 p4 p5 p6], ...
{'M=2时，SRT实际值', 'M=2时，SRT理论值', 'M=4时，SRT实际值',  ...
'M=4时，SRT理论值', 'M=6时，SRT实际值', 'M=6时，SRT理论值'}, ...
'Location','southeast');

xlabel('中断概率');
ylabel('窃听概率');
title('ORMJS系统的SRT性能');