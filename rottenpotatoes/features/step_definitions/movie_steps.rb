# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #page.body.should =~/(.*)e1(.*)e2(.*)/
  #use character classes to id strings that may exist in the page, whitespace and non-white space
  expect(/[\s\S]*#{e1}[\s\S]*#{e2}/).to match(page.body)
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  ratings = rating_list.split(", ")
  #   iterate over the ratings and reuse the "When I check..." or
  ratings.each do |rating|
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   # When /^(?:|I )check "([^"]*)"$/ do |field|
    #  check(field)
    #end
    
    #When /^(?:|I )uncheck "([^"]*)"$/ do |field|
     # uncheck(field)
    #end
    uncheck ? uncheck("ratings[#{rating}]") : (check("ratings[#{rating}]"))
  #fail "Unimplemented"
  end
end

When /I press "(.*)" button/ do |button|
  click_button button
end

Then /I should (not )?see the movies: (.*)/ do |present, movies_list|
  #use sting slpit again to break up the anticipated movie list
  movies = movies_list.split(', ')
  # iterate over the movies and connect to web step page should have/should not have
  movies.each do |movie|
    #use capy to check developed output
    if present.nil?
      expect(page).to have_content(movie)
    else
      expect(page).not_to have_content(movie)
    end
  end
end
  

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #use capy expect to have command again, count the number of rows in the table displayed
  #rows = count("//tr")
  #expect(rows).to eq(11)
  expect(page).to have_xpath("//tr", count:11)
  #fail "Unimplemented"
end
