function dx = dif(x,t)
dx = -x.state + x.b;
for i = 1:1:3
    for j = 1:1:3
        dx = dx+x.A(i,j)*x.NY(i,j)+x.B(i,j)*x.NX(i,j);
    end
end