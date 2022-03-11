
function setupJAVAPath()
%% Java path needed by OSIM
JAVA_OSIM_PATH = getenv('JAVA_OSIM_PATH');
JAVA_OSIM_LIB_FOLDER = getenv('JAVA_OSIM_LIB_FOLDER');
% get current class path
javacpath = javaclasspath('-dynamic');
found = false;
for i = 1:size(javacpath)
    if (strcmp(javacpath{i}, JAVA_OSIM_PATH))
        found = true;
        break;
    end
end
if ~found
    javaaddpath(JAVA_OSIM_PATH);
end
javapathFile = fullfile(prefdir, 'javalibrarypath.txt');
found = false;
if exist(javapathFile, 'file')
    %open and check file
    fid = fopen(javapathFile,'r');
    %for each line, trim and compare with JAVA_OSIM_LIB_FOLDER
    tline = fgetl(fid);
    while ischar(tline)
        if strcmp(strtrim(tline), JAVA_OSIM_LIB_FOLDER)
            found = true;
            break;
        end
        tline = fgetl(fid);
    end
    fclose(fid);
end
if ~found
    fid = fopen(javapathFile,'a');
    fprintf(fid, strcat(strrep(JAVA_OSIM_LIB_FOLDER, '\', '\\'), '\n'));
    fclose(fid);
end
end
