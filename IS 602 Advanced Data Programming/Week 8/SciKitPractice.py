import scipy.ndimage as ndimage
import scipy.misc as misc

raw = misc.imread('./objects.png')

img = ndimage.gaussian_filter(raw, 1.5) # 1.5 is the filter, less means more detail
thres = img > img.mean()

misc.imsave ('./object2.png', thres)