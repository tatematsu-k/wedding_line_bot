# == Schema Information
#
# Table name: invited_users
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invited_users_on_name  (name) UNIQUE
#
class InvitedUser < ApplicationRecord
  
end
