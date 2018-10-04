class PaginatingDecorator < Draper::CollectionDecorator
  delegate :limit_value, :total_pages, :current_page, :next_page, :prev_page
end
