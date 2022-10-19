bits = 32;

top_block = gcb;
block_names = find_system(top_block, 'LookUnderMasks','on', 'SearchDepth','1');

in_block = sprintf('%s/bits', top_block);
out_block = sprintf('%s/symbol', top_block);
qam_16_block = sprintf('%s/QAM-16 Symbol Mapping 0', top_block);
% enable_block = sprintf('%s/enable', n_qam_16);

keep_blocks = {top_block, in_block, out_block, qam_16_block};

for i = 1:length(block_names)
    if ~ismember(block_names{i}, keep_blocks)
        delete_block(block_names{i});
    end
end
delete_line(find_system(top_block,'LookUnderMasks', 'all','SearchDepth', '1', 'FindAll','on','type','line'));

% Add QAM-16 Mapping Blocks
pos = get_param(qam_16_block, 'position');
set_param(qam_16_block, 'n', num2str(bits-4));
for bit = 4:4:bits-1
    new_block = sprintf('%s%d', qam_16_block(1:end-1), bit/4);
    add_block(qam_16_block, new_block);
    new_pos = pos + ([0 60 0 60] * (bit/4));
    set_param(new_block, 'position', new_pos);
    set_param(new_block, 'n', num2str(bits-4-bit));
end

% Add the Bit Concat
concat_block = sprintf('%s/concat', top_block);
add_block('hdlsllib/Logic and Bit Operations/Bit Concat', concat_block);
set_param(concat_block, 'numInputs', num2str(bits/2));
concat_position = new_pos + [175 0 175 0];
concat_position(2) = pos(2);
set_param(concat_block, 'position', concat_position);

% Reposition Input and Outputs
out_position = get_param(out_block, 'position');
height = out_position(4) - out_position(2);
width = out_position(3) - out_position(1);
middle_h = (concat_position(4) - concat_position(2))/2 + concat_position(2);
out_position = [concat_position(1) + 175, middle_h - height/2, concat_position(1) + 175 + width, middle_h + height/2];
set_param(out_block, 'position', out_position);

in_position = [concat_position(1) - 300, middle_h - height/2, concat_position(1) - 300 + width, middle_h + height/2];
set_param(in_block, 'position', in_position);

% enable_position = get_param(enable_block, 'position');
% set_param(enable_block, 'position', enable_position - [0 100 0 100]);

% Connect Ports
for bit = 1:4:bits
    add_line(top_block,'bits/1',sprintf('QAM-16 Symbol Mapping %d/1',(bit-1)/4));
    add_line(top_block,sprintf('QAM-16 Symbol Mapping %d/1',(bit-1)/4),sprintf('concat/%d', ceil(bit/2)));
    add_line(top_block,sprintf('QAM-16 Symbol Mapping %d/2',(bit-1)/4),sprintf('concat/%d', ceil(bit/2)+1));
end
add_line(top_block,'concat/1','symbol/1');