require 'googleauth'
require 'google/apis/admin_directory_v1'

ENV['GOOGLE_APPLICATION_CREDENTIALS'] = Rails.root.join('config', 'application_default_credentials.json').to_s

scopes = [
  Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_USER,
  Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_GROUP,
  Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_USERSCHEMA,
  Google::Apis::AdminDirectoryV1::AUTH_ADMIN_DIRECTORY_ORGUNIT
]

auth = Google::Auth.get_application_default(scopes)
auth.sub = Rails.application.secrets.google_dir[:auth_sub]

Google::Apis::RequestOptions.default.authorization = auth

GAdmin = Google::Apis::AdminDirectoryV1
