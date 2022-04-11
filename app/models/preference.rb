class PreferencesValidator < ActiveModel::Validator
  def validate(record)
    if record.women==false && record.men==false && record.children==false
      record.errors.add :base, "You should choose at least one preference"
    end
  end
end

class Preference < ApplicationRecord
  #Associations
  belongs_to :subscriber

  #Validations
  validates_with PreferencesValidator
end
