ncol = 80
x = randperm(size(features,2),ncol);
feature_10 = features(:,x);
Label_10 = Label(:,x);