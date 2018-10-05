Fabricator(:search_result) do
  keyword       FFaker::Book.genre
  total_results 1
  total_links   1
  html_code     "<body></body>"
  user          nil
  server_ip     FFaker::Internet.ip_v4_address
  user_agent    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"
end
