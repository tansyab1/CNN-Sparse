% fea = fea';
% gnd= gnd';
features=[];
for i = 1:7200  % loop for each file 
        I = reshape(fea(:,i),[32 32]) ;  % Read the file
        wavename = 'haar';
        [cA,cH,cV,cD] = dwt2(im2double(I),wavename);
%         [cA,cH,cV,cD] = dwt2(cA,wavename);
%         I=imresize(I,0.75);
%         [cA,cH,cV,cD] = dwt2(I,LoD,HiD,'mode','symh');
%         [cA,cH,cV,cD] = dwt2(cA,LoD,HiD,'mode','symh');
%         I= cA;
        features=[features reshape(cA,[256 1])];
%         Label=[Label index];
    end