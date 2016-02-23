% FILE solveCNNED.m contains main function solveCNNED()
% that solves our problem( creates and shows picture with
% input picture's edge). It takes 1 parameter - filename
% of current picture. It returns 2 matrix: current picture's
% data and edge picture's data for external control.
function [EdgePict, Pict] = solveCNNED(filename)
% Making empty neuron for updateNXY function
Empty = CNN(zeros(3,3),zeros(3,3),0);       
Empty.X = 0;
Empty.Y = 0;
[Pict,EdgePict] = readImage(filename);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creating CNN massive
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1:(size(Pict,1))
    for j = 1:1:(size(Pict,2))
        Web(i,j) = CNN(zeros(3,3),zeros(3,3),Pict(i,j));
    end
end
for i = 1:1:(size(Pict,1))
    for j = 1:1:(size(Pict,2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Updating neighbour's Y,X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if i~= 1 && j~=1 && i~=size(Pict,1) && j ~=size(Pict,2)
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Web(i-1,j-1),Web(i,j-1),Web(i+1,j-1),Web(i-1,j),Web(i,j),Web(i+1,j),Web(i-1,j+1),Web(i,j+1),Web(i+1,j+1));
        end
        if j == 1 && i ~=1 && i~= size(Pict,1)   
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Empty,Empty,Empty,Web(i-1,j),Web(i,j),Web(i+1,j),Web(i-1,j+1),Web(i,j+1),Web(i+1,j+1));
        end
        if i == 1 && j~=1 && j~= size(Pict,2)
            [Web(1,j).NX Web(1,j).NY] = updateNXY(Empty,Web(i,j-1),Web(i+1,j-1),Empty,Web(i,j),Web(i+1,j),Empty,Web(i,j+1),Web(i+1,j+1));
        end
        if j == size(Pict,2)&& i ~=1 && i~= size(Pict,1)  
            [Web(i,size(Pict,2)).NX Web(i,size(Pict,2)).NY] = updateNXY(Web(i-1,j-1),Web(i,j-1),Web(i+1,j-1),Web(i-1,j),Web(i,j),Web(i+1,j),Empty,Empty,Empty);
        end
        if i == size(Pict,1)&& j~=1 && j~= size(Pict,2)
            [Web(size(Pict,1),i).NX Web(size(Pict,1),i).NY] = updateNXY(Web(i-1,j-1),Web(i,j-1),Empty,Web(i-1,j),Web(i,j),Empty,Web(i-1,j+1),Web(i,j+1),Empty);
        end        
        if i == 1 && j == 1
            [Web(1,1).NX Web(1,1).NY] = updateNXY(Empty,Empty,Empty,Empty,Web(i,j),Web(i+1,j),Empty,Web(i,j+1),Web(i+1,j+1));
        end
        if i == 1 && j == size(Pict,2)
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Empty,Web(i,j-1),Web(i+1,j-1),Empty,Web(i,j),Web(i+1,j),Empty,Empty,Empty);
        end
        if i == size(Pict,1) && j == 1
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Empty,Empty,Empty,Web(i-1,j),Web(i,j),Empty,Web(i-1,j+1),Web(i,j+1),Empty);
        end
        if i == size(Pict,1) && j == size(Pict,2)
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Web(i-1,j-1),Web(i,j-1),Empty,Web(i-1,j),Web(i,j),Empty,Empty,Empty,Empty);
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getting new state
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for k = 0:Web(i,j).TStep:Web(i,j).TStep*50
            Web(i,j).t = k;
            Web(i,j) = getState(Web(i,j));
        end
        if i~= 1 && j~=1 && i~=size(Pict,1) && j ~=size(Pict,2)
            [Web(i,j).NX Web(i,j).NY] = updateNXY(Web(i-1,j-1),Web(i,j-1),Web(i+1,j-1),Web(i-1,j),Web(i,j),Web(i+1,j),Web(i-1,j+1),Web(i,j+1),Web(i+1,j+1));
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inverting picture's color & converting gray to white | black
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:1:size(Pict,1)
    for j = 1:1:size(Pict,2)
        if Web(i,j).Y<=0
            Web(i,j).Y = -1;
        end
        if Web(i,j).Y>0
            Web(i,j).Y = 1;
        end
        EdgePict(i,j) = 255-(Web(i,j).Y*127.5+127.5);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Showing edge picture and current picture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imshow(EdgePict,[0 255]);