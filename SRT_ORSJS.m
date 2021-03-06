clear
Relay_num=2;
[y_simu_IP_1, y_th_IP_1]=fun2(Relay_num);
[y_simu_OP_1, y_th_OP_1]=fun3(Relay_num);
p1 = loglog(y_simu_OP_1, y_simu_IP_1,'rs');
hold on
p2 = loglog(y_th_OP_1, y_th_IP_1,'-r');

Relay_num=4;
[y_simu_IP_2, y_th_IP_2]=fun2(Relay_num);
[y_simu_OP_2, y_th_OP_2]=fun3(Relay_num);
p3 = loglog(y_simu_OP_2, y_simu_IP_2,'go');
p4 = loglog(y_th_OP_2, y_th_IP_2,'-g');

Relay_num=6;
[y_simu_IP_3, y_th_IP_3]=fun2(Relay_num);
[y_simu_OP_3, y_th_OP_3]=fun3(Relay_num);
p5 = loglog(y_simu_OP_3, y_simu_IP_3,'b*');
p6 = loglog(y_th_OP_3, y_th_IP_3,'-b');


Relay_num=2;
[y_simu_IP_1, y_th_IP_1]=fun1(Relay_num);
[y_simu_OP_1, y_th_OP_1]=fun3(Relay_num);
p7 = loglog(y_simu_OP_1, y_simu_IP_1,'rs');
hold on
p8 = loglog(y_th_OP_1, y_th_IP_1,'-r');

Relay_num=4;
[y_simu_IP_2, y_th_IP_2]=fun1(Relay_num);
[y_simu_OP_2, y_th_OP_2]=fun3(Relay_num);
p9 = loglog(y_simu_OP_2, y_simu_IP_2,'go');
p10 = loglog(y_th_OP_2, y_th_IP_2,'-g');

Relay_num=6;
[y_simu_IP_3, y_th_IP_3]=fun1(Relay_num);
[y_simu_OP_3, y_th_OP_3]=fun3(Relay_num);
p11 = loglog(y_simu_OP_3, y_simu_IP_3,'b*');
p12 = loglog(y_th_OP_3, y_th_IP_3,'-b');

legend([p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12], ...
{'M=2时，ORSJS SRT实际值', 'M=2时，ORSJS SRT理论值', 'M=4时，ORSJS SRT实际值',  ...
'M=4时，ORSJS SRT理论值', 'M=6时，ORSJS SRT实际值', 'M=6时，ORSJS SRT理论值', ...
'M=2时，ORMJS SRT实际值', 'M=2时，ORMJS SRT理论值', 'M=4时，ORMJS SRT实际值',  ...
'M=4时，ORMJS SRT理论值', 'M=6时，ORMJS SRT实际值', 'M=6时，ORMJS SRT理论值'}, ...
'Location','southwest');

xlabel('中断概率');
ylabel('窃听概率');
title('ORSJS和ORMJS的SRT性能对比');