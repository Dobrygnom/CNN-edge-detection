% File CNN.m contains description of cellular neural network 
% Constant characteristics of CNN are bias ( = I ), feedback
% functional and control functional matrix( A & B ) and time
% step ( = TStep ). Function CNN takes 3 parameters: 
% Ys of current neuron's neighbors, Xs of current neuron's
% neigbors and current parametr of picture, which lies
% in 0 .. 255 range
function CNN = CNN(InpY,InpX,X)
CNN.t = 0;                              % Current time
CNN.NY = InpY;                          % Neighbour's Ys
CNN.NX = InpX;                          % Neighbour's Xs
CNN.I = -1.5;                           % Bias of CNN
CNN.TStep = 0.3;                        % Time step
% X is a characteristic of picture, x = [-1;1], input x
% lies in 0 .. 255 range
CNN.X = (double(X)-127.5)/127.5;        
% Y is a non-linear function of X
CNN.Y = 0.5*(abs(CNN.X+1) - abs(CNN.X-1));
% Feedback functional matrix
CNN.A = [0 0 0; 0 2000*tanh(CNN.X) 0; 0 0 0];    
% Control functional matrix
CNN.B = [-0.25 -0.25 -0.25;-0.25 2000*tanh(CNN.X) -0.25; -0.25 -0.25 -0.25];
