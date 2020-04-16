%Yijiang Chen. 2.25
[x,y]=meshgrid(-16:0.5:16);
r=sqrt(x.^2+y.^2)+eps;
z2=cos(r)./r;
surf(z2)
%view([0,0,1])
%[a,b]=view;
%view(a-a,b)