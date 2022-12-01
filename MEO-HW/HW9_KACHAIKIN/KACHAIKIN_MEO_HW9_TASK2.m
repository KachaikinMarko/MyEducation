%% Тема 9, TASK3 ДОМАШНЄ ЗАВДАННЯ КАЧАЙКІН МАРКО 

tableau = [1,2,3,5,50;...
     4,3,4,6,40;...
     1,2,5,8,60;...
     30,20,50,50,0];
reserves = tableau(1:3,5);					
needs = tableau(4,1:4);
needs = needs';
if sum(needs)==sum(reserves)
    values_matrix = tableau(1:3,1:4);
    x = optimvar('x', size(values_matrix, 1), size(values_matrix, 2), 'LowerBound', 0); 
    z = sum(x .* values_matrix, 'all'); 
    num_values_matrix = size(values_matrix, 1) + size(values_matrix, 2); 
    values_matrix = optimconstr(num_values_matrix, 1); 
    count = 1; 
    for i = 1:1:size(x, 1) 
        values_matrix(count) = sum(x(i, :)) == reserves(i); 
        count = count + 1; 
    end 
    for i = 1:1:size(x, 2) 
        values_matrix(count) = sum(x(:, i)) == needs(i); 
        count = count + 1; 
    end 
problem = optimproblem('Objective', z, 'ObjectiveSense', 'min'); 
problem.Constraints = values_matrix; 

problem = prob2struct(problem); 
[sol, zval, exitflag, output] = linprog(problem); 

disp('Допустимий базисний план'); disp(reshape(sol,[3,4]));

disp('Сумарна собівартість'); disp(zval);

else
    disp('Немає збалансованності')
end

