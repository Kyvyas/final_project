require 'factory_girl_rails'

FactoryGirl.define do
  factory :activity do
    title "Football"
    description 'Football in the park, yea'
    location "Regent's Park"
    participants "6"
    datetime "06/10/2016 18:00"
    category "Sports"
    tag "Football"
  end

  factory :activity_late, parent: :activity do
    title "running"
    description 'running in the park, yea'
    location "Regent's Park"
    participants "6"
    datetime "06/10/2016 23:00"
    category "Sports"
    tag "running"
  end

  factory :activity1, parent: :activity do
    title "Tennis"
    description "Let's play some tennis"
    location "Tennis Court"
    participants "1"
    datetime "06/10/2016 18:00"
    category "Sports"
    tag "Tennis"
  end

  factory :activity2, parent: :activity do
    title "Tennis"
    description 'Doubles Tennis!'
    location "The Country Club"
    participants "2"
    datetime "06/11/2016 18:00"
    category "Sports"
    tag "Tennis"
  end

  factory :activity3, parent: :activity do
    title "Tom Jones Concert"
    description 'Need someone to go with!'
    location "Paris"
    participants "5"
    datetime "18/11/2016 19:00"
    category "Music"
    tag "Concert"
  end

  factory :past_activity, parent: :activity do
    title "Black Eyed Peas"
    description 'Need someone to go with!'
    location "New York"
    participants "3"
    datetime "18/11/2010 19:00"
    category "Music"
    tag "Concert"
  end

end
