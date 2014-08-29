module UsersHelper
  def format_user_name(user)
    "#{user.first_name} #{initial(user.last_name)}."
  end

  private

  def initial(string)
    string[0,1]
  end
end
