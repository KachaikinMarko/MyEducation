
%% Тема № 2. Задача № 1 
clear, close, clc
%	Вибір варіанта: ---------------------------------------------------------
g = 4; % Згідно списку
k = 5; % Kachaikin is fifth in list of gr
d = 173; % Birthday - 22 June, 173 day of Year
ep = 1e-6;	%	точність отриманих коренів

%	Функція рівняння	f(x) = 0 ----------------------------------------------
f = @(x) x.*(x.^3-g)+sin(k./d.*x+5.35)-15.0123.*g;
%	Похідна	f'(x)
df = @(x) 4.*x.^3-g+k./d.*cos(k./d.*x+5.35);
%	2-га похідна	f''(x)
d2f = @(x) 12.*x.^2-(k./d)^2.*sin(k./d.*x+5.35);

%	Графічне визначення інтервалу розташування кореня рівняння ---------------
X = linspace(2.75,3.1,100);		% Розбиття відрізка вузлами
plot(X, f(X));		% Графік функції y = f(x)
grid on; xlabel('x'); ylabel('y');
title(strcat('g=',int2str(g),'; k=',int2str(k),'; d=',int2str(d)));
pause 
clear X

R = cell(6,4);		% Масив комірок для формування таблиці відповідей

R{1,1} = 'дихотомії';	%----------------------------------------------------
disp('Метод дихотомії ---------------------------')
D = input('Діапазон кореня = ');
a = D(1); b = D(2); k = 0;
fa = f(a); fb = f(b);
if fa*fb < 0
   while b-a>ep
      c = 0.5.*(a+b); fc = f(c); k = k+1;
      if fc*fb <= 0
          a = c; fa = fc;
      else
          b = c; fb = fc;
      end
   end
   x = 0.5*(a+b);
   R{1,2} = x; R{1,3} = k; R{1,4} = f(x);
else
	disl('Умови існування кореня не виконані!!!')
end
R{2,1} = 'простої ітерації';	%----------------------------------------------
disp('Метод простої ітерації ---------------------------')
x = linspace(2,2.5,101);	% Розбиття відрізку розташування розв'язку вузлами
z = input('Перше наближення до кореня = ');
Df = df(x);			% Масив значень похідної f' (для визнач. max f' та min f')
max_df = max(Df);		min_df = min(Df);
if max_df*min_df >0				% f' зберігає знак?
	tau = 2/(max_df+min_df);	% оптимальний параметр простої ітерації
	fi = @(x)(x-tau*f(x));		% Стискаюче відображення методу простої ітерації
	dfi = @(x)(1-tau*df(x));	% Похідна від стискаючого відображ.
	Y = dfi(x); q = max(Y); K = q/(1-q);	% Коеф-т оцінки похибки
	x1 = z; k = 0;
	while 1
		x = fi(x1); k = k+1;
		if  or(K*abs(x-x1)<ep,k>10000)  % Я добавив умову на обмеження кількості ітерацій
			break
		end
		x1 = x;
	end
	R{2,2} = x; R{2,3} = k; R{2,4} = f(x);
else
	disp('Умови методу простої ітерації не виконуються!!!')
end

R{3,1} = 'Ейткена-Стеффенсена';	%------------------------------------------
%Реалізация методу Ейткена-Стеффенсена
disp('Метод Ейткена-Стеффенсена ---------------------------')
z = input('Перше наближення до кореня = ');
x0 = z;  k = 0;
while 1
    x1 = f(x0);
    x2 = f(x1);
    x = x0 - ((x0 - x1)*(x0-x1))/ (x0 - 2*x1 + x2);
    k=k+1;
    y = x0; % Проміжний запис змінної x0 для перевірки умови в if
    x0 =x;
    if or(abs(y-x)<=eps,k>10000) % Я добавив умову на обмеження кількості ітерацій
        break
    end
end 

R{3,2} = x; R{3,3} = k; R{3,4} = f(x);





R{4,1} = 'Ньютона';	%------------------------------------------------------
disp('Метод Ньютона ---------------------------')
z = input('Перше наближення до кореня = ');
x = z; k = 0;
while 1
   x1 = f(x)/df(x); x = x-x1; k = k+1;
   if abs(x1) <= ep
		break
   end
end
R{4,2} = x; R{4,3} = k; R{4,4} = f(x);

R{5,1} = 'січних';	%------------------------------------------------------
%Реалізація методу січних
disp('Метод січних -----------------------------')
z1 = input('Перше наближення до кореня = ');
z2 = input('Друге наближення до кореня = ');
x1 = z1; x2 = z2;  k = 0;
while 1
    x = x2 - ((x2-x1)*f(x2))/(f(x2)-f(x1));
    x1 = x2;
    x2 = x;
    k = k+1;
    if abs(x-x1) <= ep  % На цьому кроці x-x1 = ((x2-x1)*f(x2))/(f(x2)-f(x1))
		break
    end

end
R{5,2} = x; R{5,3} = k; R{5,4} = f(x);


R{6,1} = 'Курчатова';%------------------------------------------------------
%  Реалізація методу Курчатова
disp('Метод Курчатова')
z1 = input('Перше наближення до кореня = ');
z2 = input('Друге наближення до кореня = ');
x1 = z1; x2 = z2;  k = 0;
while 1
    x = x2 - (2*(x2-x1)*f(x2))/(f(2*x2-x1)-f(x1));
    x1 = x2;
    x2 = x;
    k = k+1;
    if abs(x-x1) <= ep  % На цьому кроці x-x1 = (2*(x2-x1)*f(x2))/(f(2*x2-x1)-f(x1))
		break
    end


end

R{6,2} = x; R{6,3} = k; R{6,4} = f(x);



format long
disp(R)