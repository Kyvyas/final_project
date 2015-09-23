require 'factory_girl_rails'

FactoryGirl.define do
  factory :activity do
    title "Football"
    description 'Football in the park, yea'
    location "Regent's Park"
    participants "6"
    date "06/10/2016"
    time "18:00"
    category "Sport"
    tag "Football"
  end
  factory :activity2, parent: :activity do
    title "Tennis"
    description 'Doubles Tennis!'
    location "The Country Club"
    participants "2"
    date "06/11/2016"
    time "18:00"
    category "Sport"
    tag "Tennis"
  end

end
