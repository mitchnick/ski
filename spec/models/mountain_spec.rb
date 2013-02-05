# == Schema Information
#
# Table name: mountains
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  gps_lat      :string(255)
#  gps_lon      :string(255)
#  description  :text
#  phone        :string(255)
#  web_link     :string(255)
#  tickets_link :string(255)
#  trail_map    :string(255)
#  region       :string(255)
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Mountain do
  pending "add some examples to (or delete) #{__FILE__}"
end
