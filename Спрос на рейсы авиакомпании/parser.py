import requests
import pandas as pd
from bs4 import BeautifulSoup 

URL = 'https://code.s3.yandex.net/learning-materials/data-analyst/festival_news/index.html'

req =requests.get(URL)

soup = BeautifulSoup(req.text, 'lxml')
columns = []
content=[] 

for row in soup.find_all('th'):
    columns.append(row.text)
   
for row in soup.find_all('tr'):
    if not row.find_all('th'):
        content.append([element.text for element in row.find_all('td')])

festivals = pd.DataFrame(content, columns=columns)
print(festivals)
