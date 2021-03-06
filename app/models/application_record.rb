class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(attribute, value)
    if attribute == 'unit_price'
      where("#{attribute} = #{value.to_f}")
    elsif attribute == 'created_at' || attribute == 'updated_at'
      where("#{attribute} = '%#{value.to_date}%'")
    else
      where("lower(#{attribute}) LIKE lower('%#{value}%')")
    end
  end
end
