function [  ] = zapiszDoPliku( fileTitle, vector )

    fileVar = fopen(fileTitle, 'w');
    
    for i = 1 : length(vector)
        fprintf(fileVar,'%5d ',i);
        fprintf(fileVar,'%5d\n',vector(i));
    end
    
    fclose(fileVar);

end

