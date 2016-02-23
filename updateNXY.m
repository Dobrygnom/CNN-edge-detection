% File updateNXY.m contains function updateNXY(), that
% updates current neuron's neighbor's Xs and Ys. It takes
% neighbor neuron's as a parameters and returns updated
% value of current neuron's neighbor's Xs and Ys.
function [NX NY] = updateNXY(tmp11,tmp12,tmp13,tmp21,tmp22,tmp23,tmp31,tmp32,tmp33)
% Updating Y
  NY = [tmp11.Y tmp12.Y tmp13.Y; tmp21.Y tmp22.Y tmp23.Y;tmp31.Y tmp32.Y tmp33.Y];
% Updating X
  NX = [tmp11.X tmp12.X tmp13.X; tmp21.X tmp22.X tmp23.X;tmp31.X tmp32.X tmp33.X];