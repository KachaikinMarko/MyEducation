%% Тема 10, TASK1 ДОМАШНЄ ЗАВДАННЯ КАЧАЙКІН МАРКО 
clear, close, clc
% Розв'язати бінарну ЗЛП про призначення
% Що задана матрицею витрат:
% C =[ 5  41 8
%      31 30 3
%      12 21 10]

% Формуємо вектор цільової функції
f = [5;41;8;31;30;3;12;21;10];
% Формування матриці та вектора обмежень-нерівностей A*x <= b :
A = []; b=[];
% Формування матриці та вектора обмежень-рівностей Aeq*x = beq :
o = [1,1,1]; z = [0,0,0]; n = length(z);
Aeq = [o,z,z;...
       z,o,z;...
       z,z,o];
o = o'; beq = [o;o]; clear z o;
o = eye(n); e = [o,o,o];
Aeq = [Aeq;e]; clear o e;

lb = zeros(1,n^2);   ub = ones(1,n^2);
intcon = 1:n^2;
[x, fval, exitflag, output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);
put_bint('Бінарна ЗЛП', x, fval, exitflag);
%output
disp('Матриця призначень X:');
disp(reshape(x',n,n)');

 
function put_bint(txt, x, fval, exitflag)
% Друк результатів розв'язання бінарної ЗЛП
e = fix(exitflag); disp(txt); disp('Код закінчення:'); disp(e);
switch e
    case -6
        disp('Перевищено допустиму кількість числа ітерацій LP-солвера MaxRLP');
    case -5
        disp('Перевищено допустиму кількість часу виконання MaxTime');
    case -4
        disp('Перевищено допустиму кількість перебору вузлів MaxNodes');
    case -2
        disp('Задача не має розв’язків');
    otherwise
        if e == 0
            disp('Перевищено допустиму кількість ітерацій MaxIter');
            disp('Вектор x:'); disp(x);
        else
            disp('Знайдено деякий розв’язок:'); disp(x');
        end
        disp('Значення цільової функції:'); disp(fval);
end
end