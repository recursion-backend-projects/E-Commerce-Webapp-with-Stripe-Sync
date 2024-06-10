class Contact < ApplicationRecord
    belongs_to :customer, optional: true
    
    before_save { self.email = email.downcase }
  
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'の形式が不正です' }
    validates :message, presence: true, length: { maximum: 1000 }
end
