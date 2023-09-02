from bs4 import BeautifulSoup
import requests

try:
    headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    response = requests.get("https://olympics.com/en/olympic-games/tokyo-2020/results/boxing", headers=headers)

    response.raise_for_status()  # Check for any HTTP errors
    soup = BeautifulSoup(response.text, 'html.parser')
    print(soup)
except requests.exceptions.RequestException as e:
    print('Failed to fetch website:', e)