require 'activerecord-import'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(query)
    if query.values.first.blank?
      all
    else
      where("lower(#{query.keys.first}) LIKE ?", "%#{query.values.first.downcase}%")
    end
  end
end
