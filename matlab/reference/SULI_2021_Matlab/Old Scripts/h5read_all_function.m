
%place marker at line 47

h5read_all('TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5')
% data=h5read('TD_TC090-078_GXD_CAMERA-01-DB_SHOT_RAW-DIAGNOSTIC-IMAGE_N210317-001-999.h5','/ATTRIBUTES/SHOT_IMAGE/DATA/DATA/');

function out = h5read_all_r(file, root)
    if (root(end) ~= '/')
        root = [root, '/'];
    end
    out = []; 
    info = h5info(file,root);  
    fields = {info.Datasets.Name};
    for k=1:length(fields)
        fd = fields{k};
        info = h5info(file,[root, fd]);
        dim = length(info.Dataspace.Size);
        t = h5read(file, [root, fd]);
        % if a data field
        if (dim == 3)
            %  need to permute based on how matlab read h5 files!
            t = permute(t, [dim:-1:1]);
            %for backwards compatibiltiy of array shape.  FIX?
            out.(fd) = reshape(t, [1 size(t)]);
        else
            out.(fd) = t;
        end
    end
    
    info = h5info(file,root);
    
    if length(info.Groups) > 0
         
        groups = {info.Groups.Name};
        for k=1:length(groups)
            
            name = groups{k};
            
            % chomp to last field
            for m = 1:length(name);
                if name(m) == '/'
                    last_slash = m;
                end
            end
            fieldname = name(last_slash+1:end);
            
            t = h5read_all_r(file, name);
            
            out.(fieldname) = t;
        end
    end
end

function out = h5read_all(file) %#ok<*FNDEF>
 out = h5read_all_r(file, '/');  
end