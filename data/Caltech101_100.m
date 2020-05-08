
clear all; close all;
rootFolder = fullfile('101_ObjectCategories');

% Get the list of categories
listing = dir('101_ObjectCategories/');
categories = extractfield(listing, 'name');
categories = categories(3:end);

imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);

% Determine the smallest amount of images in a category
minSetCount = min(tbl{:,2}); 

% Limit the number of images to reduce the time it takes
% run this example.
maxNumImages = 100;
minSetCount = min(maxNumImages,minSetCount);
imds = splitEachLabel(imds, minSetCount, 'randomize');