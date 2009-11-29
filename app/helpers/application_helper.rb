# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_amount(expense)
    "#{(expense.is_income ? "" : "-")}#{expense.amount}" 
  end

  def user_position_in_group(user, group)
    case
    when user.manager?(group)
      return UserGroupRelation.human_attribute_name("manager")
    when user.approved_but_not_manager?(group)
      return UserGroupRelation.human_attribute_name("approved_user")
    when user.unapprove?(group)
      return UserGroupRelation.human_attribute_name("unapprove_user")
    else
      return UserGroupRelation.human_attribute_name("other")
    end
  end

  def show_tag_type(tag)
    tag.is_income? ? t("tags.income") : t("tags.outgoing")
  end

end
