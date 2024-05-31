require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DockerRailsTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.i18n.default_locale = :ja

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # ステータスの日本語表示のために必要
    config.i18n.default_locale = :ja

    # Rails自体のアプリケーションの時刻の設定
    config.time_zone = 'Tokyo'

    # DBを読み書きする際に、DBに記録されている時間をどのタイムゾーンで読み込むかの設定
    config.active_record.default_timezone = :local

    config.active_storage.urls_expire_in = 1.hour
  end
end
