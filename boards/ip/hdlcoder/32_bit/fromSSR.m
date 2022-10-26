ssr = 16;
w = 3;

top_block = gcb;
block_names = find_system(top_block, 'LookUnderMasks','on', 'SearchDepth','1');

in_block = sprintf('%s/data_srr', top_block);
out_block = sprintf('%s/data_wide', top_block);

keep_blocks = {top_block, in_block, out_block};

for i = 1:length(block_names)
    if ~ismember(block_names{i}, keep_blocks)
        delete_block(block_names{i});
    end
end
delete_line(find_system(top_block,'LookUnderMasks', 'all','SearchDepth', '1', 'FindAll','on','type','line'));

% % Add Bit Slice Blocks
% pos = get_param(bit_slice, 'position');
% set_param(bit_slice, 'lidx', num2str(w-1));
% set_param(bit_slice, 'ridx', num2str(0));
% for slice = 2:ssr
%     new_block = sprintf('%s%d', bit_slice(1:end-1), (slice-1));
%     add_block(bit_slice, new_block);
%     new_pos = pos + ([0 60 0 60] * (slice-1));
%     set_param(new_block, 'position', new_pos);
%     set_param(new_block, 'lidx', num2str(slice*w-1));
%     set_param(new_block, 'ridx', num2str((slice-1)*w));
% end

% Add the De-Mux
mux_block = sprintf('%s/demux', top_block);
add_block('simulink/Signal Routing/Demux', mux_block);
set_param(mux_block, 'Outputs', num2str(ssr));
mux_position = new_pos + [175 0 120 0];
mux_position(2) = pos(2);
set_param(mux_block, 'position', mux_position);

% Reposition Input and Outputs
out_position = get_param(out_block, 'position');
height = out_position(4) - out_position(2);
width = out_position(3) - out_position(1);
middle_h = (mux_position(4) - mux_position(2))/2 + mux_position(2);
out_position = [mux_position(1) + 175, middle_h - height/2, mux_position(1) + 175 + width, middle_h + height/2];
set_param(out_block, 'position', out_position);

in_position = [mux_position(1) - 300, middle_h - height/2, mux_position(1) - 300 + width, middle_h + height/2];
set_param(in_block, 'position', in_position);

% Connect Ports
for slice = 1:ssr
    add_line(top_block,'data_wide/1',sprintf('Bit Slice %d/1',slice-1));
    add_line(top_block,sprintf('Bit Slice %d/1',(slice-1)),sprintf('mux/%d', slice));
end
add_line(top_block,'mux/1','data_ssr/1');