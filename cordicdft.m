function[c, s] = cordicdft(re, img, angle)
i=1;
% Look-up table of angles and corresponding tan values.
a = [45 26.565 14.036 7.125 3.5763 1.78991 0.89517 0.44761 0.2238105 0.1119 0.05595 0.027976 0.01398 0.006994 0.003497 0.0017485];
p = [1 0.5 0.25 0.125 0.0625 0.03125 0.015625 0.0078125 0.00390625 0.001953125 0.0009765625 0.00048828125 0.000244140625 0.0001220703125 0.00006103515625 0.00003051757813];
x = zeros(1,16);
y = zeros(1,16);
z = zeros(1,16);
% Conversion of angle when angle > 90 degrees.
temp = angle;
if temp <= 360
    v1 = temp;
else
    v1 = mod(temp, 360);
end
if (v1 >=0 && v1<=90)
    ssign = 1;
    csign = 1;
elseif (v1 > 90 && v1<=180)
    ssign = 1;
    csign = -1;
elseif (v1 > 180 && v1<=270)
    ssign = -1;
    csign = -1;
elseif (v1 > 270 && v1<=360)
    ssign = -1;
    csign = 1;
end
v2 = mod(v1, 90);
if((v1>90)&&(v2~=0))
    v3 = v2;
elseif((v1>90)&&(v2==0))
    temp1 = v1/90;
    if (mod(temp1, 2)~=0)
        v3 = 90;
    else
        v3 = 0;
    end
else
    v3 = v1;
end
% (x, y, z) --> Inputs to the CORDIC Algorithm.
% (x, y) --> Co-ordinates of the vector to be rotated
% z--> angle of rotation
z(1,1) = v3;
x(1,1) = re;
y(1,1) = img;
% Number of iterations = 16
while(i<17)
    if(z(1,i)>=0)
        d=1; % Direction to be rotated
        z(1,i+1) = z(1,i)-a(1,i);
    else
        d=-1;
        z(1,i+1) = a(1,i)+z(1,i);
    end
    n = -i;
    x(1,i+1) = (x(1,i)-(y(1,i)*d*p(1,i)));
    y(1,i+1) = (y(1,i)+(x(1,i)*d*p(1,i)));
    i = i+1;
end
% c--> cosine, s--> sine value with scaling.
c = (x(1,16)*0.6072*csign);
s = (y(1,16)*0.6072*ssign);


    