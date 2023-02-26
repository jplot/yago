# == Schema Information
#
# Table name: activities
#
#  id          :bigint           not null, primary key
#  code        :string
#  record_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :bigint           not null
#
# Indexes
#
#  index_activities_on_record  (record_type,record_id)
#
class ActivitySerializer < ApplicationSerializer
  attributes :code
end
