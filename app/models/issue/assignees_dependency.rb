class Issue
  # has_and_belongs_to_many :assignees, join_table: :users, class_name: "User", foreign_key: :assignee_ids
  scope :with_assignees, -> (ids) { ids.any? ? where("ARRAY[?] <@ assignee_ids", ids) : all }

  # Users that for assignee
  def assignee_target_users
    user_ids = repository.members.pluck(:user_id)
    user_ids += repository.user.members.pluck(:user_id)
    users = User.where(id: user_ids.uniq).with_attached_avatar
    users.sort_by { |user| user_ids.index(user.id) }
  end

  # Replace issue assignees
  def update_assignees(assignee_ids)
    self.assignee_ids = assignee_ids.uniq
    self.save
  end

  def assignees
    return @assignees if defined? @assignees

    records = User.where(id: self.assignee_ids)
    records.sort { |u| self.assignee_ids.index(u.id) }
  end

  def assignees=(val)
    @assignees = val
  end

  class << self
    def preload_assignees
      assignee_ids = all.collect(&:assignee_ids).flatten.compact
      users = User.where(id: assignee_ids)
      records = all
      records.each do |item|
        item.assignees = users.select { |u| item.assignee_ids.include?(u.id) }
      end
      records
    end
  end
end