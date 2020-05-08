clear all; close all;
% Get the list of categories
listing = dir('ARgender/');
categories = extractfield(listing, 'name');
categories = categories(3:end);

% Read the image dataset
XCell = []; % All the images
y = [];   % Labeled images
for i = 1:length(categories)
    tmp = strcat('ARgender/', categories(i), '/*.bmp');
    imgsCurrDir = extractfield(dir(tmp{1}), 'name');
    for j= 1:length(imgsCurrDir)
        tmp = strcat('ARgender/', categories(i), '/', imgsCurrDir(j));
        img = imread(tmp{1});
        if ndims(img)==2
            img = cat(3, img, img, img);
        end
        XCell{end+1} = imresize(img,[96 96]);
        if i <= 50
            y(end+1) = 0;
        else 
            y(end+1) = 1;
        end
        
        
    end
end
features=[];
for i =1 : 2600
%     temp=imgs(i);
    temp=rgb2gray(cell2mat(XCell(i)));
%     wavename = 'haar';
%     [cA,cH,cV,cD] = dwt2(im2double(temp),wavename);
%     [cA,cH,cV,cD] = dwt2(cA,wavename);
    temp=reshape(double(temp),[9216 1]);
    features=[features temp];
end
save('./june10');
