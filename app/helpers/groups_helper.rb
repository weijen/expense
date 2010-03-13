module GroupsHelper
  def group_state_message(group)

    return t("group.frozen_message") if group.state == 'frozen'

    return t("group.frozen_before_date", :frozen_date => group.froze_before_date) if group.froze_before_date

    return ""
  end
end
