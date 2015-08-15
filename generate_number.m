function num=generate_number(nu,num_digit)

num=int2str(nu);
for i=1:num_digit-length(num)
    num=['0' num];
end