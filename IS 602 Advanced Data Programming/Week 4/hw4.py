
#import sys
#sys.path.append('C:/path...')

from __future__ import print_function
from alchemyapi import AlchemyAPI
import json

import bs4
import urllib2
import string

if __name__ == "__main__":

	url = 'http://www.citylab.com/weather/2014/09/a-strange-cloud-over-st-louis-turns-out-to-be-an-enormous-swarm-of-butterflies/380614/'

	page = urllib2.urlopen(url)

	soup = bs4.BeautifulSoup(page.read())

	links = soup.findAll('div',{'id':'article-body'})

	newString = ''

	triTest = True

	parTest = True

	validLetters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .,?\'\":;'


	for char in str(links):

		if char == '<':
			triTest = False
		if char == '>':
			triTest = True

		if char == '(':
			parTest = False
		if char == ')':
			parTest = True

		if triTest and parTest and char in validLetters:
			newString += char

		if triTest and parTest and char == '\n':
			newString += ' '

	alchemyapi = AlchemyAPI()

	# Look at example for more examples on this. The results are clearly in XML, and you'll have to parse that.

	print('Processing text: ', newString)
	print('')

	response = alchemyapi.keywords('text', newString, {'sentiment': 1})

	keywordlist = []
	if response['status'] == 'OK':
		for keyword in response['keywords']:
			keywordlist.append([keyword['text'].encode('utf-8'), float(keyword['relevance'].encode('utf-8'))])

	else:
	    print('Error in keyword extaction call: ', response['statusInfo'])

	keywordlist.sort(key=lambda x: x[1], reverse=True)

	print("Here are the top 10 keywords: \n")
	for i in range(0,10):
		print(keywordlist[i][0] + ", with a relevance score of: " + str(keywordlist[i][1]))

