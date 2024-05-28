require 'active_storage/service/s3_service'

module ActiveStorage
  class Service::TenantS3Service < Service::S3Service
    private

    def object_for(key)
        if ENV["S3_ENV"] == "stg"
            bucket.object File.join('stg', key)
        else
            bucket.object File.join('prod', key)
        end
    end
  end
end