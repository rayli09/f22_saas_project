# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    # when /^the (RottenPotatoes )?home\s?page$/ then '/movies'
    when /^the home page$/ then '/events'
    when /^the search page$/ then '/search'
    when /^the login page$/ then '/login'
    when /^the logout page$/ then '/logout'
    when /^the new user page$/ then '/users/new'
    when /^the search result page$/ then '/search_result'
    when /^the myEvents page$/ then '/myEvents'
    when /^the event detail page of '(.*)'$/ then event_path(Event.find_by(title: $1))
    when /^the welcome page$/ then '/welcome'
    when /^the post event page$/ then '/events/new'
    when /^the event details page for "(.*)"$/ then "/events/#{Event.find_by(title:$1).id}"
    when /^the edit event page for "(.*)"$/ then "/events/#{Event.find_by(title:$1).id}/edit"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
