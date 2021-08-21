#
# require_relative '../ps_wtb_influxdb_helpers'
#
# ## Print db respones
#   print $response_1
#   # print $response_2

require_relative '../ps_wtb_email_helpers'

RSpec.configure do |c|
 c.include Email
end


RSpec.describe "Verification of lightbox widget product search", ps_027_lightbox_dual: true, ps_lightbox_dual: true do

  it "Sends an email" do
    email_sending
  end
end
