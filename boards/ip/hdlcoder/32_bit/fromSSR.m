top_block = gcb;
block_names = find_system(top_block, 'LookUnderMasks','on', 'SearchDepth','1');

in_block = sprintf('%s/data_ssr', top_block);
out_block = sprintf('%s/data_wide', top_block);

keep_blocks = {top_block, in_block, out_block};

for i = 1:length(block_names)
    if ~ismember(block_names{i}, keep_blocks)
        delete_block(block_names{i});
    end
end
delete_line(find_system(top_block,'LookUnderMasks', 'all','SearchDepth', '1', 'FindAll','on','type','line'));

% Add Bit Concat Block
concat_block = sprintf('%s/bit concat', top_block);
add_block('hdlsllib/Logic and Bit Operations/Bit Concat', concat_block);
set_param(concat_block, 'numInputs', num2str(ssr));

% Add the Demux
demux_block = sprintf('%s/demux', top_block);
add_block('simulink/Signal Routing/Demux', demux_block);
set_param(demux_block, 'Outputs', num2str(ssr));

% Reposition Demux and Bit Concat
out_position = get_param(out_block, 'position');
middle_h = (out_position(4) - out_position(2))/2 + out_position(2);

concat_pos = out_position - [220 0 200 0];
concat_pos(2) = middle_h - (24 * ssr);
concat_pos(4) = middle_h + (24 * ssr);
set_param(concat_block, 'position', concat_pos);

demux_pos = out_position - [400 0 420 0];
demux_pos(2) = middle_h - (24 * ssr);
demux_pos(4) = middle_h + (24 * ssr);
set_param(demux_block, 'position', demux_pos);

% Connect Ports
if strcmp(order, 'MSB-First')
    for s = 1:ssr
        add_line(top_block, sprintf('demux/%d',s),sprintf('bit concat/%d',s));
    end
elseif strcmp(order, 'LSB-First')
    for s = 1:ssr
        add_line(top_block, sprintf('demux/%d',s),sprintf('bit concat/%d',ssr-(s-1)));
    end
end
add_line(top_block,'data_ssr/1', 'demux/1');
add_line(top_block,'bit concat/1', 'data_wide/1');