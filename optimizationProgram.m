no_var = 8;  %number of variables
lb = [0 0 0 0 0 0 0 0]; % lower bound
up = [Inf Inf Inf Inf Inf Inf Inf Inf]; % high bound
%initial = [17.7282    2.5092   15.7849    6.5301    8.3972   17.9916    6.6981    6.9647];
initial = [19.5190    4.4961   16.2164    6.7200   15.6652   17.8432   17.9789   16.9811];

%GA OPTIONS
%try
ga_opt = gaoptimset('Display','off','Generations',15,'PopulationSize',5, ...
    'InitialPopulation',initial,'PlotFcns',@gaplotbestf);
obj_fun = @(k)myObjectiveFunction(k);

[k,bestblk] = ga((obj_fun),no_var,[],[],[],[],lb,up,[],ga_opt);

disp(k);