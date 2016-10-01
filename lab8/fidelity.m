function fide =  fidelity(f,b)

const = 0;
for k = -3:3
    for l = -3:3
        const = const + exp(-(k^2 + l^2)/4);
    end
end
C = 1/const;

[m,n] = size(f);
fl = 255*(f/255).^2.2;
bl = 255*(b/255).^2.2;

fb = zeros(m+6,n+6);
bb = zeros(m+6,n+6);

for i = 1:m
    for j = 1:n
        fb(i+3,j+3) = fl(i,j);
        bb(i+3,j+3) = bl(i,j);
    end
end

for i = 1:m
    for j = 1:n
        sum1 = 0;
        sum2 = 0;
      for k = -3:3
          for l = -3:3
              sum1 = sum1 + fb(i+3+k,j+3+l)*C*exp(-(k^2 + l^2)/4);
              sum2 = sum2 + bb(i+3+k,j+3+l)*C*exp(-(k^2 + l^2)/4);
          end
      end
      fl(i,j) = 255*(sum1/255)^(1/3);
      bl(i,j) = 255*(sum2/255)^(1/3);
    end
end
fide = 0;
for i = 1:m
    for j = 1:n
        fide = fide+ ((fl(i,j)-bl(i,j))^2);
    end
end
fide = sqrt(fide/(m*n));

