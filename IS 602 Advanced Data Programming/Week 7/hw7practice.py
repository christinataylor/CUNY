import numpy
import scipy

def func(x, a, b):
	return a * x + b

x = numpy.linspace(0, 10, 100)
y = func(x, 1, 2)

yn = y + 0.9 + numpy.random.normal(size=len(x))

