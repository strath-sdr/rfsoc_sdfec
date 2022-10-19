function repackage(ip_folder, library)
%{ 
    This function takes the path to the folder containing a HDL coder 
    generated IP (e.g. 'hdl_prj\ipcore\ber_v1_1') and the library it will
    belong to (e.g. 'rfsoc_sdfec') and will repackage it in Vivado IPI.
    This is intended to make it easier to add the correct company url and
    vendor name to IP cores, in addition to including multiple master or 
    slave AXI-Stream interfaces.

    Note: AXI-Stream interfaces should be 'external_port' in the workflow
    and follow the naming convention: 
    s_axis_<name>_tdata, s_axis_<name>_tvalid, s_axis_<name>_tlast
    
    Tested with MATLAB 2020b and Vivado 2020.2. Make sure add Vivado to the
    MATLAB path: hdlsetuptoolpath('ToolName','Xilinx Vivado','ToolPath','')
%}
    %% Generate parameters
    ip_folder = replace(ip_folder,'\','/');
    prj_folder = [ip_folder, '/prj_ip'];

    ip_core = strsplit(ip_folder, '/');
    ip_core = ip_core{end};

    ip_doc = dir(fullfile(ip_folder, 'doc', '**\*.html'));
    table_intf_config = tableFromHTML(fullfile(ip_doc.folder, ip_doc.name), 'Target Interface Configuration');
    table_size = size(table_intf_config);

    axis_interfaces = {};
    for row = 1:table_size(1)
        if contains(table_intf_config(row,:).("Port Name"), 'axis') && contains(table_intf_config(row,:).("Port Name"), 'tdata')
            axis_interfaces{end+1} = extractBefore(table_intf_config(row,:).("Port Name"){1}, '_tdata');
        end
    end

    vendor = 'strathsdr.org';
    name = extractBefore(ip_core, '_v');

    version = extractAfter(ip_core, '_v');
    version_split = strsplit(version,'_');
    version = [version_split{1} '.' version_split{2}];

    name_split = strsplit(name, '_');
    for i=1:size(name_split,2)
        name_split{i}(1)=upper(name_split{i}(1));
    end
    display_name = join(name_split, ' ');
    display_name = display_name{1};

    description = 'HDL Coder generated IP';
    company_url = 'http://strathsdr.org/';

    %% Re-package IP
    pkg_ip_script = fullfile(prj_folder ,'packageip.tcl');
    fileID = fopen(pkg_ip_script,'w');

    % Open vivado project
    fprintf(fileID, ['cd %s\n'...
                    'open_project ./prj_ip.xpr\n'], ...
                    prj_folder);

    % Edit IP in project
    fprintf(fileID, ['ipx::package_project -root_dir %s -vendor %s -library %s -taxonomy /UserIP -force\n'],...
                    prj_folder, vendor, library);

    % Set properties
    fprintf(fileID, ['set_property name {%s} [ipx::current_core]\n'...
                     'set_property version {%s} [ipx::current_core]\n'...
                     'set_property display_name {%s} [ipx::current_core]\n'...
                     'set_property description {%s} [ipx::current_core]\n'...
                     'set_property company_url {%s} [ipx::current_core]\n'],...
                     name, version, display_name, description, company_url);

    % Associate Clocks
    for interface = 1:length(axis_interfaces)
        fprintf(fileID, 'ipx::associate_bus_interfaces -busif %s -clock IPCORE_CLK [ipx::current_core]\n', axis_interfaces{interface});
    end

    % Finish up
    fprintf(fileID, ['set_property core_revision 2 [ipx::current_core]\n'...
                     'ipx::create_xgui_files [ipx::current_core]\n'...
                     'ipx::update_checksums [ipx::current_core]\n'...
                     'ipx::check_integrity [ipx::current_core]\n'...
                     'ipx::save_core [ipx::current_core]\n'...
                     'update_ip_catalog -rebuild -scan_changes\n'...
                     'close_project\n']);
    fclose(fileID);

    cmd = sprintf('vivado -source %s -mode batch -nojournal -nolog', pkg_ip_script);
    system(cmd);