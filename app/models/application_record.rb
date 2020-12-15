class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(attribute, value)
    if value.blank?
      all
    elsif attribute == 'created_at' || attribute == 'updated_at'
      where("#{attribute} = '%#{value.to_date}%'")
    else
      where("lower(#{attribute}) LIKE ?", "%#{value}%")
    end
  end
end
