%% Тема 3, Задача 2
clear, close, clc
%	Вибір варіанта: ---------------------------------------------------------
g = 4; % Згідно списку
k = 5; % Kachaikin is fifth in list of gr
d = 173; % Birthday - 22 June, 173 day of Year
% ---------------------------------------------------------------------------

X = [18,20,22,24,26]; % Регресор, Ціни акцій фірми "Бобік"
Y = [12,14,16,18,20]; % Регрессант, Ціни акцій фірми "Жучка"
M = zeros(length(X),length(Y));
M(1,1) = g ; M(1,2) = 2;           M(1,3) = 7; M(1,4) = 11; M(1,5) = 15;
M(2,1) = 2 ; M(2,2) = floor(k/10); M(2,3) = 3; M(2,4) = 3;  M(2,5) = 5;
M(3,1) = 3 ; M(3,2) = 2;           M(3,3) = 1; M(3,4) = 2;  M(3,5) = 2;
M(4,1) = 5 ; M(4,2) = 2;           M(4,3) = 2; M(4,4) = 0;  M(4,5) = 1;
M(5,1) = 17; M(5,2) = 9;           M(5,3) = 3; M(5,4) = 2;  M(5,5) = floor(d/10);
disp(sum(M(1:5,1)));

% Створюємо кореляційну таблицю
%------------------------------------------------------------
C = cell((size(M,1)+2),((size(M,2)+2)));
C{1,1} = "X\Y";
C{1,size(M,1)+2} = "mxi";
C{size(M,1)+2,1} = "mxj";
for i = 2:(size(M,1)+1)
    C{i,1} = X(i-1);
    C{size(M,1)+2,i} = sum(M(1:5,i-1));
    for j = 2:(size(M,2)+1)
        C{i,j} = M(i-1,j-1);
        C{1,j} = Y(j-1);
        C{j,size(M,1)+2} = sum(M(j-1,1:5));
    end
end
if sum(sum(M')) == sum(sum(M))
    C{(size(M,1)+2),((size(M,2)+2))} = sum(sum(M));
else 
    disp("Матриця частот введена неправильно")
end
disp("Кореляційна таблиця")
disp(C);
% Кореляційна залежність
%-------------------------------------------

Xy = zeros(1,length(Y));
Yx = zeros(1,length(X));
Mx = sum(M');
My = sum(M);
% Тут, Х та У мають однакову розмірність, тому для оптимальності всі
% операції проведемо в одному циклі
if length(Y) == length(X)
    for k = 1:length(Y)
        Xy(k) = X*M(:,k)./My(k);
        Yx(k) = Y*(M(k,:))'./Mx(k);
    end
end
disp('Кореляційна залежність X,Yx :'); disp([X;Yx]);
disp('Кореляційна залежність Y,Xy :'); disp([Y;Xy]);

% Емпірічні лінії регрессії Х по У, та У по Х.
subplot(1,2,1);
plot(X,Yx,'k -',X,Yx,'ro ');
xlabel('X'); ylabel('Yx');
title('Емпірична лінія регресії Y по X');
subplot(1,2,2);
plot(Y,Xy,'k -',Y,Xy,'ro ');
xlabel('Y'); ylabel('Xy');
title('Емпірична лінія регресії X по Y');
% Числові характеристики двовимірного статистичного ряду 
n = sum(sum(M));
Xc = dot(X,Mx)./n; Yc = dot(Y,My)./n; % X*mx' Y*my'
disp('Загальні середні Xc,Yc :'); disp([Xc,Yc]);
XYc = X*(M*Y')./n; covXY = XYc-Xc.*Yc;
disp(strcat('Коваріація :',num2str(covXY)));
for i=1:length(X)
v = (Y-Yx(i)).^2;
S2x(i) = dot(v,M(i,:))./Mx(i);
end
disp('Групова дисперсія :'); disp(S2x);
Sc2 = dot(S2x,Mx)./n;
disp(strcat('Внутрішньогрупова дисперсія :',num2str(Sc2)));
d2 = dot((Yx-Yc).^2,Mx)./n;
disp(strcat('Міжгрупова дисперсія :',num2str(d2)));
S2y = Sc2+d2;
disp(strcat('Загальна дисперсія :',num2str(S2y)));
R2 = d2./S2y;
disp(strcat('Емпіричний коефіцієнт детермінації :',num2str(R2)));
r = sign(covXY).*sqrt(R2);
disp(strcat('Емпіричний коефіцієнт кореляції :',num2str(r)));
disp(strcat('Модуль емпіричного коефіцієнту кореляції :',num2str(abs(r))));
disp("Висновок - Дуже слабкий зв'язок між регресантом У та регресором Х")

% Рівняння лінійної регрессії МНК
G1 = [X(1)-1,X(length(X))+1,Y(1)-1,Y(length(Y))+1];
G2 = [Y(1)-1,Y(length(Y))+1,X(1)-1,X(length(X))+1];
X2c = dot(X.^2,Mx)./n; S2x = X2c-Xc.*Xc;
a = covXY./S2x; b = (X2c.*Yc-Xc.*XYc)./S2x;
syms x; % x - символ !
fi = a*x+b;
disp(strcat('Рівняння лінійної регресії :=',char(fi)));
disp(strcat('в дійсних числах з 5-ю знаками :=',char(vpa(fi,5))));
XX = linspace(G1(1),G1(2),50*length(X)+1);
YY = subs(fi,x,XX);

plot(X,Yx,'k -',X,Yx,'mo ',XX,YY,'b -',Xc,Yc,'r* ');
axis(G1); grid on; xlabel('X'); ylabel('Yx');
title('ЕЛР Y по X і лінійна регресія');
legend('Yx(X)','(X,Yx)','fi(x)','(Xc,Yc)','Location','Best');
