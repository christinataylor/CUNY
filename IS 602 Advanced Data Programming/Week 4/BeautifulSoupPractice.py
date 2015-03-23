import bs4
import urllib2

url = "http://sps.cuny.edu"

page = urllib2.urlopen(url)

soup = bs4.BeautifulSoup(page.read())

#links = soup.findAll('a')
#links = soup.findAll('li')
links = soup.findAll('li',{'class' : 'unit'})

for link in links:
	print link

filename = "riverkeeper_data_2013.csv"	

reader = open(filename)
cleanlist = []
for row in reader:
    cleanlist.append(row)