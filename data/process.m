% 
% features=[];
% Label=[];
% [LoD,HiD] = wfilters('haar','d');
for index=31:39
    link='';
    link =(['C:\Users\tansy\Desktop\Dataset\CroppedYale\CroppedYale\','yaleB',num2str(index),'\']);
    cd (link)
    Files=dir('*.pgm');  % Get jpg, png and bmp files in the present folder 
    N = length(Files) ;  % Total number of image files 
    for i = 1:N  % loop for each file 
        I = imread(Files(i).name) ;  % Read the file
        wavename = 'haar';
        [cA,cH,cV,cD] = dwt2(im2double(I),wavename);
        [cA,cH,cV,cD] = dwt2(cA,wavename);
%         I=imresize(I,0.75);
%         [cA,cH,cV,cD] = dwt2(I,LoD,HiD,'mode','symh');
%         [cA,cH,cV,cD] = dwt2(cA,LoD,HiD,'mode','symh');
%         I= cA;
        features=[features reshape(cA,[2016 1])];
        Label=[Label index];
    end
end
