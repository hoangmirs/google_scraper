Fabricator(:link) do
  link_type     Link.link_types.values.sample
  title         FFaker::Book.title
  url           FFaker::Internet.http_url
  search_result nil
end
