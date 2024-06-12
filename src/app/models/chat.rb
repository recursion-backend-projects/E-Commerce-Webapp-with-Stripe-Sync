class Chat < ApplicationRecord
  belongs_to :customer
  enum :status, { waiting_for_admin: 0, chatting: 1, offline: 2 }
end
