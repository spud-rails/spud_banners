FactoryGirl.define do

  sequence :set_name do |n|
    "Banner Set #{n}"
  end

  factory :spud_banner_set do
    name { FactoryGirl.generate(:set_name) }
    width 600
    height 200
    cropped true
  end

end
