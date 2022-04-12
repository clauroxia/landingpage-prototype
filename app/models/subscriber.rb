# class PreferencesValidator < ActiveModel::Validator
#   def validate(record)
#     if record.women==false && record.men==false && record.children==false
#       record.errors.add :base, "You should choose at least one preference"
#     end
#   end
# end


class Subscriber < ApplicationRecord
def has_one_preference 
  if self.preferences.empty?
    self.errors.add(:base, "You should choose at least one preference")
  end
end

#Association
has_and_belongs_to_many :preferences, dependent: :destroy

#Validations
validates :email, presence: true, uniqueness: true
validates :email,
format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,3}\z/,
          message: "must have an email format" }
          # format: {with: URI::MailTo::EMAIL_REGEXP}
validate :has_one_preference, 

end
