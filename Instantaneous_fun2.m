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
{'M=2ʱ����������ʵ��ֵ', 'M=2ʱ��������������ֵ', 'M=4ʱ����������ʵ��ֵ',  ...
'M=4ʱ��������������ֵ', 'M=6ʱ����������ʵ��ֵ', 'M=6ʱ��������������ֵ'}, ...
'Location','southeast');

xlabel('����ȣ�SNR��');
ylabel('��������ʵ��ֵ������ֵ�Ա�');
title('ORSJS ��������ʵ��ֵ������ֵ�Ա�');