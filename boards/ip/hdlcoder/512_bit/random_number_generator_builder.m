gen_poly = generator_polynomial;

random_gen = gcb;
block_handles = Simulink.findBlocks(gcb);
block_names = getfullname(block_handles);

out_block = sprintf('%s/data', random_gen);
in_block = sprintf('%s/reset', random_gen);
enable_block = sprintf('%s/enable', random_gen);

keep_blocks = {out_block, in_block, enable_block};

for i = 1:length(block_names)
    if ~ismember(block_names{i}, keep_blocks)
        delete_block(block_names{i});
    end
end
delete_line(find_system(gcs,'LookUnderMasks', 'all','FindAll','on','type','line'));

% Add all PN Sequence Generators 
for bit = 1:bits
    current_block = sprintf('%s/bit%d', random_gen, bit-1);
    add_block('commseqgen3/PN Sequence Generator', current_block);
    position = get_param(current_block, 'position');
    if bit == 1
        start_position = position;
    end
    new_position = position + ([0 60 0 60] * (bit-1));
    set_param(current_block, 'position', new_position);
    set_param(current_block, 'poly', gen_poly);
    set_param(current_block, 'outDataType', 'boolean');
    set_param(current_block, 'reset', 'on');
    set_param(current_block, 'Ts', '-1');
    
    val = dec2bin(bit*3, 13);
    str = '[';
    for i = 1:13
        str(end+1:end+2) = [' ' (val(i))];
    end
    str(end+1) = ']';
    set_param(current_block, 'ini_sta', str);
end

% Add the Bit Concat
concat_block = sprintf('%s/concat', random_gen);
add_block('hdlsllib/Logic and Bit Operations/Bit Concat', concat_block);
set_param(concat_block, 'numInputs', num2str(bits));
position = new_position + [150 0 150 0];
position(2) = start_position(2);
set_param(concat_block, 'position', position);

% Add Input and Outputs
out_position = get_param(out_block, 'position');
height = out_position(4) - out_position(2);
width = out_position(3) - out_position(1);
middle_h = (position(4) - position(2))/2 + position(2);
out_position = [position(1) + 150, middle_h - height/2, position(1) + 150 + width, middle_h + height/2];
set_param(out_block, 'position', out_position);

in_position = [position(1) - 300, middle_h - height/2, position(1) - 300 + width, middle_h + height/2];
set_param(in_block, 'position', in_position);

enable_position = get_param(enable_block, 'position');
set_param(enable_block, 'position', enable_position - [0 100 0 100]);

% Connect Ports
for bit = 1:bits
    add_line(random_gen,'reset/1', sprintf('bit%d/1', bit-1));
    add_line(random_gen,sprintf('bit%d/1', bit-1), sprintf('concat/%d', bit));
end
add_line(random_gen,'concat/1','data/1');