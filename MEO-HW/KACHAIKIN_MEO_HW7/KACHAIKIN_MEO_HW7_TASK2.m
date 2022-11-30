%% Тема 7, TASK2 ДОМАШНЄ ЗАВДАННЯ КАЧАЙКІН МАРКО 
clear, close, clc
% Качайкін, варіант 11:
%30 7 0.8 1.5 0.12 0.1 12.5 3.7
% Початкові параметри
x0 = 30;
y0 = 7;
a = 0.8;
b = 1.5;
c = 0.12;
d = 0.1;
k1 = 12.5;
k2 = 3.7;


fun = @(t,U) [a*(1-U(1)/k1)*U(1) - (b*U(1)*U(2))/(k2+U(1)) ;...
    (c - d*(U(2)/U(1)))*U(2)]; % функція що описує праву частину СДР
Y0 = [x0;y0]; %ПУ
[T,Y1] = ode45(fun, [0 20], Y0); % Солвер матлаб для вект задачі Коші


% Фазові портрети

% Графіки отриманого розв'язку
subplot(1,2,1)
plot(T, Y1(:,1), T, Y1(:,2),'r','LineWidth',2), grid on
legend('x','y','Location','Best')
title('Модель "Хижак-Жертва" Холлінга-Теннера')
xlabel('t'), ylabel('x,y')

subplot(1,2,2)
plot(Y1(:,1), Y1(:,2), 'r','LineWidth',2), grid on
title('Фазові траєкторії')
xlabel('x'), ylabel('y')