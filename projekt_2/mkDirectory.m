function [ ] = mkDirectory( path )

    [~, ~, msgID] = mkdir(path);
    
    if strcmp(msgID, 'MATLAB:MKDIR:DirectoryExists')
        rmdir(path, 's');
        mkdir(path);
    end
    
end

