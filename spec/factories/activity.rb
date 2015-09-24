require 'factory_girl_rails'

FactoryGirl.define do
  factory :activity do
    title "Football"
    description 'Football in the park, yea'
    location "Regent's Park"
    participants "6"
    date "06/10/2016"
    time "18:00"
    category "Sports"
    tag "Football"
  end


  factory :activity1, parent: :activity do
    title "Tennis"
    description "Let's play some tennis"
    location "Tennis Court"
    participants "1"
    date "06/10/2016"
    time "18:00"
    category "Sports"
    tag "Tennis"
  end

  factory :activity2, parent: :activity do
    title "Tennis"
    description 'Doubles Tennis!'
    location "The Country Club"
    participants "2"
    date "06/11/2016"
    time "18:00"
    category "Sports"
    tag "Tennis"
  end

  factory :activity3, parent: :activity do
    title "Tom Jones Concert"
    description 'Need someone to go with!'
    location "Paris"
    participants "5"
    date "18/11/2016"
    time "19:00"
    category "Music"
    tag "Concert"
  end
end
