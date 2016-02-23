% File readImage contains function readImage(), that reads
% file and create a matrix containing the image data.
% Function takes 1 parameters - file name of current picture
% and returns 2 parameters: current picture's data and
% zero matrix of current picture containing edge picture.
function [Pict,EdgePict] = readImage(filename)
Pict = imread(filename);                    % Reading file
EdgePict = zeros(size(Pict,1),size(Pict,2));% Creating edge picture