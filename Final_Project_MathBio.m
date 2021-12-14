clear; clc;

%Minutes in a day is 1440 minutes, extended by hour to get a more readable
%graph. 
x = (0:1:1500);
n = length(x);
%time of day in minutes, having noon = 0000 in 24 hour clock
t_off = 886;
t_on = 527;
%constants provided by the paper
tau_alpha = 88.62;
tau_lam = 13;
%If alpha and lambda is given edit out the top two variables and change the
%variables below.
alpha = log(2)./tau_alpha;
lam = log(2)./tau_lam;
A_constant = 5.78;
result=zeros(1,n);
%half lifes provided by the paper
tau_C = 59.93;
tau_I = 2.84;
%values of betas used in the ODE
beta_C = log(2)./tau_C;
beta_I = log(2)./tau_I;
%intial values of the ODE for the model
x0 = 0;
y0 = 0;
intial = [x0, y0];

%solving for A(t)
for i=1:n 
  if (t_off <= i)
   result(i)=piecewise1(x(i),t_off,alpha,A_constant);
  end
  if (t_on<=i && i<t_off)
   result(i)=piecewise2(x(i),t_on,t_off,lam,A_constant);
  end
end

%converts the piecewise array
result_final = @(t) interp1(x,result,t);

%solves the ODE given by paper using the "result" array
ode_RHS = @(t,x) [-beta_I.*x(1) + result_final(t);...
                  beta_I.*x(1) - beta_C.*x(2);];
t_span = [0 n];
[t,x] = ode45(@(t,x) ode_RHS(t,x), t_span, intial);

%plotting the dH2/dt from the ODE
figure(1); clf;
plot(t,x(:,2),'LineWidth',4); 
axis([0 1500 0 600]);
title("Melatonin levels throughout the day: Subject 15")
ylabel("Melatonin in Plasma (pmol/L)");
xlabel("time (Minutes)")

%Piecewise functions dependent on time of day, provided by the paper.
function result_off = piecewise1(x,t_off,alpha,A_constant)
    result_off = A_constant.*exp(-alpha.*(x-t_off));
end

function result_on = piecewise2(x,t_on,t_off,lam,A_constant)
    result_on = A_constant.*((1-exp(-lam.*(x-t_on)))./(1-exp(-lam.*(t_off-t_on))));
end

  



