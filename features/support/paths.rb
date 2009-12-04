module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /groups\/new/
      new_group_path
    when /show group/
      group_path(@group)
    when /groups\/edit/
      edit_group_path(@group)
    when /group users page/
      group_users_path(@group)
    when /new_income_path/
      new_expense_path(:kind => :income)
    when /new_outgoing_path/
      new_expense_path(:kind => :outgoing)
    when /new_tag_path/
      new_tag_path
    when /tags_path/
      tags_path
      # Add more mappings here.
      # Here is a more fancy example:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
