%Test_IAF.m

alpha = 1;
beta = 1;
gcinputs = [1,0.5,2;2,0.5,1;5,0.1,4;7,2,0.2];

for alpha = 0.01:0.01:4
    IAFNeuron(alpha,beta,gcinputs);
    pause(0.001)
end
