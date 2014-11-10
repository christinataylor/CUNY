import scipy.ndimage as ndimage
import scipy.misc as misc
#import scimage
import numpy
import copy
import skimage.filter as skif
import skimage.morphology as morph
import matplotlib.pyplot as mpl
import skimage.feature as feature
import pylab
import mahotas
import pymorph
from skimage.filter import canny

### Circles ###

raw_circle = misc.imread('circles.png')
img_circle = ndimage.gaussian_filter(raw_circle, 15)
rmax_circle = pymorph.regmax(img_circle)
pylab.imshow(pymorph.overlay(img_circle, rmax_circle))
pylab.show()
seeds_circle, nr_circles = ndimage.label(rmax_circle)
print "Number of objects: " + str(nr_circles)
centers_circles = ndimage.center_of_mass(rmax_circle, seeds_circle, range(1, nr_circles + 1, 1))
print "Centers of gravity: " + str(centers_circles)

### Objects ###

raw_objects = misc.imread('objects.png')
img_objects = ndimage.gaussian_filter(raw_objects, 3)
thres_objects = img_objects > img_objects.mean()
pylab.imshow(thres_objects)
pylab.show()
# regmax is resulting in an error. Looks like this is working
# withoutt this function though.
#rmax_objects = pymorph.regmax(thres_objects)
#pylab.imshow(pymorph.overlay(thres_objects, rmax_objects))
#pylab.show()
#seeds_objects, nr_objects = ndimage.label(thres_objects)
#print "Number of objects: " + str(nr_objects)
#centers_objects = ndimage.center_of_mass(thres_objects, seeds_objects, range(1, nr_objects +1, 1))
#print "Centers of gravity: " + str(centers_objects)

### Delicious Bell Peppers ###

raw_peppers = misc.imread('peppers.png')
img_peppers = ndimage.gaussian_filter(raw_peppers, 5)
img_black = numpy.zeros_like(img_peppers)

#thres_peppers = img_peppers<150
edges = canny(img_peppers[:,:,0], sigma=1.5)
filled = ndimage.binary_fill_holes(edges)


#markers = img_peppers[img_peppers > 222]
markers = numpy.zeros_like(img_peppers[:,:,0])
markers[img_peppers[:,:,0] < 100] = 1
markers[img_peppers[:,:,0] > 150] = 2
elevation_map = skif.sobel(img_peppers[:,:,0])
segmentation = morph.watershed(elevation_map, markers)
rmax_peppers = pymorph.regmax(segmentation)
seeds_peppers, nr_peppers = ndimage.label(rmax_peppers)
print "Number of objects: " + str(nr_peppers)
centers_peppers = ndimage.center_of_mass(segmentation, seeds_peppers, range(1, nr_peppers +1, 1))
print "Centers of gravity: " + str(centers_peppers)

#sx = ndimage.sobel(img_peppers, axis=0, mode='constant')
#sy = ndimage.sobel(img_peppers, axis=1, mode='constant')
#sob = numpy.hypot(sx, sy)
#thres_peppers = sob[:,:,0]
#thres_peppers2 = thres_peppers>150
#thres_peppers3 = ndimage.gaussian_filter(thres_peppers2, 3)

#rmax_peppers = pymorph.regmax(thres_peppers)
#pylab.imshow(pymorph.overlay(thres_peppers, rmax_peppers))
#pylab.show()


#filtered_edges_peppers = ndimage.gaussian_filter(thres_peppers, 0.5)
# Not sure why the Gaussian filter didn't work here...


#seeds_peppers, nr_peppers = ndimage.label(thres_peppers)
#print "Number of objects: " + str(nr_peppers)
#centers_peppers = ndimage.center_of_mass(thres_peppers, seeds_peppers, range(1, nr_peppers +1, 1))
#print "Centers of gravity: " + str(centers_peppers)

pylab.imshow(rmax_peppers)
pylab.show()

#pylab.imshow(raw_peppers[:,:,0])
#pylab.show()
#pylab.imshow(raw_peppers[:,:,1])
#pylab.show()
#pylab.imshow(raw_peppers[:,:,2])
#pylab.show()
#pylab.imshow(raw_peppers[:,:,3])
#pylab.show()


#seeds_peppers, nr_peppers = ndimage.label(thres_peppers)
#print "Number of objects: " + str(nr_peppers)
#centers_peppers = ndimage.center_of_mass(thres_peppers, seeds_peppers, range(1, nr_peppers +1, 1))
#print "Centers of gravity: " + str(centers_peppers)

