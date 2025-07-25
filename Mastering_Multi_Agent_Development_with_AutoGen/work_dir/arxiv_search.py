# filename: arxiv_search.py
import requests

# Define the base URL and search parameters
base_url = "http://export.arxiv.org/api/query"
search_query = "machine learning healthcare"
max_results = 5

# Make the API request to retrieve arXiv papers
response = requests.get(base_url, params={"search_query": search_query, "max_results": max_results})

if response.status_code == 200:
    data = response.text
    # Parse the response and display relevant information
    # You can decide how you want to parse the response and display the information
    print(data)
else:
    print("Failed to retrieve data from the arXiv API. Status code:", response.status_code)