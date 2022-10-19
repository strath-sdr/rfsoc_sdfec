k = 80;
frame = zeros(1,k)';
prev_frame = zeros(1,k)';
fixed = fi(0,128,0,0);
frame_i = 0;
fixed_i = 0;
fixed_rem = 0;

frame = prev_frame;

if valid
    fixed = decimalToBinaryVector(d_in,128);
    fixed_i = 128;
%     fixed_rem = rem(fixed_i,80);
end

for i = 1:floor(fixed_i,k)
    frame = fixed(1:80);
end