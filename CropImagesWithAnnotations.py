import cv2
import scipy.io as sio
from os import listdir
from os.path import isfile,join,isdir
import numpy as np
from matplotlib.path import Path
import os
# from retangle import my_retangle

def load_data_shared():

# Navigate to  main directory in which there are 101 subdirectories containing images.
    mypath = '../dataset/101_ObjectCategories'
# Process all the folders in the main directory
    folders = [folder for folder in listdir(mypath) if isdir(join(mypath,folder))]
    all_images = np.array([])
    all_labels = np.array([],dtype=np.uint8)
# Process all the images in each and every folder in the main directory.
    for j in range(0,len(folders)):
        files = [file for file in listdir(join(mypath,folders[j])) if (isfile(join(mypath,folders[j],file)) & bool(file!='.DS_Store')) ]
        images = np.empty(len(files),dtype=object)
        labels = np.empty(len(files),dtype=np.uint8)
#Convert each and every image to array and append array values of all the images
        for n in range(0,len(files)):
 	  	    images[n] = cv2.imread(join(mypath,folders[j],files[n]))
 	  	    labels.fill(j)
        all_images = np.append(all_images,images)
        all_labels = np.append(all_labels,labels)

# Navigate to  main directory in which there are 101 subdirectories containing annotation of each image.
    mypath = '../dataset/Annotations/'
    folders = [folder for folder in listdir(mypath) if isdir(join(mypath,folder))]
    all_annotations = np.array([])
    for j in range(0,len(folders)):
        files = [file for file in listdir(join(mypath,folders[j])) if (isfile(join(mypath,folders[j],file)) & bool(file!='.DS_Store'))]
        annotations = np.empty(len(files),dtype=object)
# Get array of annotations for each image from .mat file and append annotations of all the images
        for n in range(0,len(files)):
            annotations[n] = sio.loadmat(join(mypath,folders[j],files[n]))
        all_annotations = np.append(all_annotations,annotations)

# Navigate to  directory where you want to write cropped images.
    os.chdir('../dataset/caltech/')
    image_with_annotation = np.empty((all_images.shape[0],48*48),dtype=object)
    for i in range(0,all_images.shape[0]):
    # for i in range(350,360):
        # pass
        image = all_images[i]
        image = cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
# Contour is a rough coordinates, which help us find the area of interest in the image
        contour = all_annotations[i]['obj_contour']


#Box coordinates provides us with rough rectangular outline of our area of interest in the image
        box = all_annotations[i]['box_coord']
        contour = np.transpose(contour)
        contour[:,0]=contour[:,0]+box[:,2]
        contour[:,1]=contour[:,1]+box[:,0]


# Outline/sketch the ares of interest in the image and find all the points inside that region
        p= Path(contour[:-2])
        mask = np.zeros(image.shape,dtype=np.uint8)
        # print(image.shape, box[0,0],box[0,1],box[0,2],box[0,3])
        for x in range(image.shape[0]-box[0,1],image.shape[0]-box[0,0]+1):
            for y in range(image.shape[1]-box[0,3],image.shape[1]-box[0,2]+1):
                # bool_value = p.contains_point([x,y])
                # if bool_value:
                mask[x-1,y-1]=1
        image = image*mask


#append value of each image to an array
        image = cv2.resize(image, (48,48))
        # cv2.imwrite('image'+str(i+1)+'.jpg',image)
        image_with_annotation[i]=np.ravel(image)
    sio.savemat('../dataset/caltech/data.mat',
        {'features':image_with_annotation,
         'Label' : all_labels})        

if __name__ == '__main__':
    load_data_shared()
