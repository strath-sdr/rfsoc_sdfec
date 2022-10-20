ssr = 16;

top_block = 'soft_demodulation/SSR Soft Demodulation';

block_names = find_system(top_block, 'LookUnderMasks','on', 'SearchDepth','1');

in_valid = sprintf('%s/valid', top_block);
in_real = sprintf('%s/real', top_block);
in_imag = sprintf('%s/imag', top_block);
in_scale = sprintf('%s/scale', top_block);
out_llr = sprintf('%s/llr', top_block);
soft_demod_block = sprintf('%s/Soft Demodulation 0', top_block);

keep_blocks = {top_block,in_valid,in_real,in_imag,in_scale,soft_demod_block,out_llr};

for i = 1:length(block_names)
    if ~ismember(block_names{i}, keep_blocks)
        delete_block(block_names{i});
    end
end
delete_line(find_system(top_block,'LookUnderMasks', 'all','SearchDepth', '1', 'FindAll','on','type','line'));

% Add Soft Demodulation Blocks
pos = get_param(soft_demod_block, 'position');
for i = 1:ssr-1
    new_block = sprintf('%s%d', soft_demod_block(1:end-1), i);
    add_block(soft_demod_block, new_block);
    new_pos = pos + ([0 150 0 150] * i);
    set_param(new_block, 'position', new_pos);
    set_param(new_block, 'n', num2str(i+1));
end

% Add the Bit Concat
concat_block = sprintf('%s/concat', top_block);
add_block('hdlsllib/Logic and Bit Operations/Bit Concat', concat_block);
set_param(concat_block, 'numInputs', num2str(ssr));
concat_position = new_pos + [275 0 175 0];
concat_position(2) = pos(2);
set_param(concat_block, 'position', concat_position);

% Reposition Output
out_position = get_param(out_llr, 'position');
height = out_position(4) - out_position(2);
width = out_position(3) - out_position(1);
middle_h = (concat_position(4) - concat_position(2))/2 + concat_position(2);
out_position = [concat_position(1) + 175, middle_h - height/2, concat_position(1) + 175 + width, middle_h + height/2];
set_param(out_llr, 'position', out_position);

% Connect Ports
for i = 1:ssr
    add_line(top_block,'valid/1',sprintf('Soft Demodulation %d/1',i-1));
    add_line(top_block,'real/1',sprintf('Soft Demodulation %d/2',i-1));
    add_line(top_block,'imag/1',sprintf('Soft Demodulation %d/3',i-1));
    add_line(top_block,'scale/1',sprintf('Soft Demodulation %d/4',i-1));
    
    add_line(top_block,sprintf('Soft Demodulation %d/1',i-1),sprintf('concat/%d', i));
end
add_line(top_block,'concat/1','llr/1');
