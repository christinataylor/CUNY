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

def objectcount(imagarray):
	lm1 = feature.peak_local_max(imagarray, indices=False)
	x1, y1 = numpy.where(lm1.T == True)
	return len(x1)


raw = misc.imread('./objects.png')

img = ndimage.gaussian_filter(raw, 1.5) # 1.5 is the filter, less means more detail
img[img>img.mean()], img[img<=img.mean()] = 252, 0

lm1 = feature.peak_local_max(img, indices=False)

# This works better when producing a numpy array for the result image

x1, y1 = numpy.where(lm1.T == True)

#misc.imsave ('./object2.png', lm1)

# Count the objects in the photo



"""# Edge Detection

sx = ndimage.sobel(raw, axis=0, mode='constant')
sy = ndimage.sobel(raw, axis=1, mode='constant')
sob = numpy.hypot(sx, sy)"""

"""###################################################

# Generating data points with a non-uniform background

x = numpy.random.uniform(low=0, high=100, size=20).astype(int)
y = numpy.random.uniform(low=0, high=100, size=20).astype(int)

# Creating image with non-uniform background

func = lambda x, y: x**2 + y**2
grid_x, grid_y = numpy.mgrid[-1:1:100j, -2:2:100j]
bkg = func(grid_x, grid_y)
bkg = bkg / numpy.max(bkg)

# Creating points

clean = numpy.zeros((100,100))
clean[(x,y)] += 5
clean = ndimage.gaussian_filter(clean, 3)
clean = clean / numpy.max(clean)

# combining both the non-uniform background
# and points

fimg = bkg + clean
fimg = fimg / numpy.max(fimg) # this is the original

# Defining the minimum neighboring size of objects

block_size = 3

# Adaptive threshold functino which returns image
# map of structures that are different relative to 
# background

adaptive_cut = skif.threshold_adaptive(fimg, block_size, offset=0) 
# this is the processed"""

#imag = morph.is_local_maximum(thres)

################################

"""
# Generating data points with a non-uniform background

x = numpy.random.uniform(low=0, high=200, size=20).astype(int)
y = numpy.random.uniform(low=0, high=400, size=20).astype(int)

# Creating image with non-unform background

func = lambda x, y: numpy.cos(x) + numpy.sin(y)
grid_x, grid_y = numpy.mgrid[0:12:200j, 0:24:400j]
bkg = func(grid_x, grid_y)
bkg = bkg / numpy.max(bkg)

# creating points

clean = numpy.zeros((200,400))
clean[(x,y)] += 5
clean = ndimage.gaussian_filter(clean, 3)
clean = clean / numpy.max(clean)

# Combining both the non-uniform background
# and points

fimg = bkg + clean
fimg = fimg / numpy.max(fimg)

misc.imsave ('./object2.png', fimg)



# Calculating the local maxima

lm1 = feature.peak_local_max(fimg, indices=False)
x1, y1 = numpy.where(lm1.T == True)

# creating figure to show local maximum detection
"""