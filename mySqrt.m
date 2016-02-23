function xn = mySqrt(x,i,px)
if i == 1
    i = i+1;
    xn = 0.5*(1+x);
else
    i=i+1;
    xn = 0.5*(px+x/px);
end
    
if i<20
   xn =  mySqrt(x,i,xn);
end
    