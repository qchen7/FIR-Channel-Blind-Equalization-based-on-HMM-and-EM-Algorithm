function Make_plot_L1(A, A_est, O, T, H, h, H_vector, L_Y_vector, n)
n1 = 0:n;
Hline = zeros(3,n+1);
t= 1:T;
hline = zeros(8,T);

for n2 = 0:n;
    for k = 1:3
        Hline(k,n2+1) = H(k);
    end
end
for t1 = 1:T;
    for k = 1:8
        hline(k,t1) = h(k);
    end
end
    
close all;
plot(n1,Hline(1,n1+1),'--k');
hold on;
plot(n1,Hline(2,n1+1),'--k');
hold on;
plot(n1,Hline(3,n1+1),'--k');
hold on;
axis([0 n 0 1]);
title('Channel Impulse Response Estimation')
xlabel('n (number of iterations)');
ylabel('H');
pause(5);

l1=line(NaN,NaN, 'Marker', 'o', 'linesty','-','erasemode','none');
l2=line(NaN,NaN, 'Marker', 'o', 'linesty','-','erasemode','none');
l3=line(NaN,NaN, 'Marker', 'o', 'linesty','-','erasemode','none');
tt = 1:n+1;

for test1 = 1:n+1;
set(l1, 'xdata', n1(1:test1), 'ydata', H_vector(1,tt(1:test1)));

set(l2, 'xdata', n1(1:test1), 'ydata', H_vector(2,tt(1:test1)));

set(l3, 'xdata', n1(1:test1), 'ydata', H_vector(3,tt(1:test1)));


% subplot(1,2,2);
% plot(n1(test1),L_Y_vector(1,n1+1));
% title('Weighted likelihood function')
% xlabel('n (number of iterations)');
% ylabel('Likelihood function');
pause(0.35);
end

% figure(2);
% plot(t,hline(1,t),'--k');
% hold on;
% plot(t,hline(2,t),'--k');
% hold on;
% plot(t,hline(3,t),'--k');
% hold on;
% plot(t,hline(4,t),'--k');
% hold on;
% plot(t,hline(5,t),'--k');
% hold on;
% plot(t,hline(6,t),'--k');
% hold on;
% plot(t,hline(7,t),'--k');
% hold on;
% plot(t,hline(8,t),'--k');
% hold on;
% plot(t,O(t),'+',t,O(t));
% xlim([0 T]);
% title('Observed sequence');
% xlabel('t');
% ylabel('O(t)');
% 
% t1 = [t;t+1];
% t2 = t1(:);
% A1 = [A;A];
% A2 = A1(:);
% A_est1 = [A_est;A_est];
% A_est2 = A_est1(:);
% 
% figure(3);
% subplot(2,1,1);
% plot(t2,A2);
% axis([1 T+1 -1.5 1.5]);
% title('Orignial information symbols');
% xlabel('t');
% ylabel('A(t)');
% 
% subplot(2,1,2);
% plot(t2,A_est2);
% axis([1 T+1 -1.5 1.5]);
% title('Estimated information symbols');
% xlabel('t');
% ylabel('A_est(t)');


