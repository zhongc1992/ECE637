function output = stretch(input,T1,T2)

map = zeros(1,256);
map(T2:end) = 255;
[m n] = size(input);
output = zeros(m,n,'uint8');
for i = T1:1:T2
    map(i) = 255*(i-T1)/(T2-T1);
end

for k = 1:1:m
    for j = 1:1:n
        output(k,j) = round(map(input(k,j)));
    end
end
road = 'E:\2016spring\ECE637\lab4\stretched_kids.jpg';
imwrite(output,road)