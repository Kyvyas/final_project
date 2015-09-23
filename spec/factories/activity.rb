require 'factory_girl_rails'

FactoryGirl.define do
  factory :activity do
    title "Football!"
    description 'Football in the park, yea'
    location "Regent's Park"
    participants "6"
    date "06/10/2016"
    time "18:00"
    category "Sport"
    tag "Football"
  end

  factory :activity1, parent: :activity do
    title "Tennis"
    description "Let's play some tennis"
    location "Tennis Court"
    participants "1"
    date "06/10/2016"
    time "18:00"
    category "Sport"
    tag "Tennis"
  end

end