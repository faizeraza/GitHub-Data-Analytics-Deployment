from bs4 import BeautifulSoup
import requests
from github import Github
from github import Auth
import datetime
import re
# auth = Auth.Token("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")
# g = Github(auth=auth)
# ls=[]
# repo = g.get_repo("Stability-AI/generative-models")
# ls.append(repo.description)
# print(ls[0])
# Get the list of contributors using the PaginatedList


# Iterate through the PaginatedList to access contributors
# interval = re.search(r'=\s*(.*)$',"https://github.com/trending?since=daily")
# print(interval.group(1))
response = requests.get("https://github.com/trending?since=daily")
if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')
    repos = soup.find_all('article', class_='Box-row')
    repo_list = [a['href'][1:] for a in soup.select('article.Box-row h2.h3 a[href]')]
    print(len(repo_list))
    print(repo_list)
else:
    print('Failed to fetch trending repositories.') 