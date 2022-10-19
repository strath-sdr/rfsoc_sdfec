function table_out = tableFromHTML(file, table_heading)

    html_ca = fileread(file);
    html = char(convertCharsToStrings(html_ca));

    % Use the name to find the start location of the table specified 
    table_name_loc = strfind(html, table_heading);
    table_name_loc = table_name_loc(1);
    table_start = strfind(html, '<table>');
    table_start = table_start(table_start>table_name_loc);
    table_start = table_start(1);
    % Find the ends of tables
    table_end = strfind(html, '</table>')+7;
    % Use the end location that falls first after the start location
    table_end = table_end(table_end>table_start);
    table_end = table_end(1);
    % Delete everything around the table start and end
    html = html(table_start:table_end);

    rows = strfind(html, '<tr');
    col_s = strfind(html, '<td');
    col_e = strfind(html, '</td>') + 4;

    n_row = length(rows);
    n_col = length(col_s);

    i = 1;
    for r = 1:n_row
        for c = 1:(n_col/n_row)
            table_out{r,c} = html(col_s(i):col_e(i));
            i = i +1;
        end
    end

    table_out = regexprep(table_out, '\n', '');
    table_out = regexprep(table_out, '<[^>]*>', '');

    table_out = array2table(table_out(2:end,:),...
    'VariableNames',table_out(1,:));
end