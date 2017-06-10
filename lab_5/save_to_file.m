function [ output_args ] = save_to_file( data, nazwa_pliku )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileTitle = [nazwa_pliku];
filename = fopen(fileTitle,'w');
for i=1:length(data)
    fprintf(filename,'%5d ',i);
    fprintf(filename,'%5d\n',data(i));
end
fclose(filename);

end

