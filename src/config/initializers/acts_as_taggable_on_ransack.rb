# ActsAsTaggableOnライブラリのTagクラスの拡張(Ransack用の設定追加)
ActsAsTaggableOn::Tag.class_eval do
  def self.ransackable_associations(_auth_object = nil)
    %w[taggings]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
