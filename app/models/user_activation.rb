# frozen_string_literal: true

# == Schema Information
#
# Table name: user_activations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  invited_user_id :bigint           not null
#  line_user_id    :bigint           not null
#
# Indexes
#
#  index_user_activations_on_invited_user_id  (invited_user_id) UNIQUE
#  index_user_activations_on_line_user_id     (line_user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (invited_user_id => invited_users.id)
#  fk_rails_...  (line_user_id => line_users.id)
#
class UserActivation < ApplicationRecord
  belongs_to :line_user
  belongs_to :invited_user
end
