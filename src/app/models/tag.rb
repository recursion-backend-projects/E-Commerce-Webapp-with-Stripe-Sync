class Tag < ActsAsTaggableOn::Tag
  validate :validate_name

  TAG_NAME_MAX_LENGTH = 30
  def validate_name
    errors.add(:name, "は#{TAG_NAME_MAX_LENGTH}文字以内で入力してください") if name.length > TAG_NAME_MAX_LENGTH
  end
end
