# Final-Project-

Code created by: Chavo Salazar, Nate Johnston, Anna Tang

Written for Mathematical Biology 1 Final Project

Description
https://pubmed.ncbi.nlm.nih.gov/9124558/

This code is used to imitate the model for the concentration of melatonin in plasma throughout the day, by using the piecewise function, differential equations, and data values provided by the scientific paper “A mathematical model of diurnal variations in human plasma melatonin levels”.
The constants at the beginning of the paper were given and alternate between different subjects, they will not change values when the program is running. This program is being run in MATLAB_R2021b, it can be copied and pasted into the program.

To use this program just insert the values found for each variable. The only values that need to be changed when looking at different subject is:

t_off
t_on
tau_alpha
tau_lam
tau_C
tau_I
A_constant 


Explanation of each part of the code

The initial values of the model will start at 0 unless the values of x are altered, to simulate no noticeable amount of melatonin within the plasma.

The piecewise function is A(t) which uses a for loop to look at every minute within the time interval set as x in the values preset on top of the code. It then goes through ‘If’ statements to find what equation to use when t is a certain value, where it will make an array of values. There is no need to alter this for the statement.

The “result_final” array is interpolating the “result” array as an array of t, which is needed so that values can be used in the ODE. 

ode_RHS is the equations for dH1/dt and dH2/dt set inside a matrix. The equations for both come from the paper itself. The t_span is the span of time, but will use the max time as how long it will span. We used ode45 as the ODE solver.

The only values being plotted is that of dH2/dt, we will not use dH1/dt as that is the concentration of melatonin the pineal gland, while dH2/dt is concentration of melatonin in the plasma as described in the paper.


Troubleshooting

t_off and t_on are displayed in minutes, converting time of day to minutes. For example, it is 1412 then in minutes it will be 852 minutes.

To achieve the correct t_off and t_on set the noon to be 0000 instead of 1200. For example, t_off = 0945 (when 0000 is midnight) then, t_off = 2145 when noon is 0000. This was the only way to get the accurate measurement on the paper. 

If the graph is not showing the portion of the graph wanted, change the code axis([0 1500 0 600]) to what is suited to your needs. The only thing that needs to be changed in the code is the numbers use this as a tool to suit what parameters you want, axis([ x_min x_max y_min y_max]).




