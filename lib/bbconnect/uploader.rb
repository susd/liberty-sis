# Inspired by https://github.com/biola/bbconnect-sync --thanks!

require 'curb'

module Bbconnect
  class UploadError < ::StandardError; end

  class Uploader
    URL = 'https://www.blackboardconnected.com/contacts/importer_portal.asp?qDest=imp'

    # User-Agent has to be this or it won't work because Blackboard.
    USER_AGENT = 'Autoscript (curl)'

    attr_reader :path, :settings, :curl

    def initialize(path, settings)
      @path = path
      @settings = settings
      @curl = Curl::Easy.new(URL)
    end

    def perform
      setup_curl
      post_curl

      raise UploadError, curl.body unless successful?
    end

    private

    def setup_curl
      curl.enable_cookies = true
      curl.follow_location = true
      curl.headers['User-Agent'] = USER_AGENT
      curl.multipart_form_post = true
    end

    def post_curl
      curl.http_post(
        Curl::PostField.content('fNTIUser', settings[:user]),
        Curl::PostField.content('fNTIPassEnc', settings[:password]),
        Curl::PostField.content('fContactType', settings[:type]),
        Curl::PostField.content('fRefreshType', settings[:type]),
        Curl::PostField.content('fPreserveData', '1'),
        Curl::PostField.content('fRefreshGroups', '1'),
        Curl::PostField.content('fSubmit', '1'),
        Curl::PostField.file('fFile', path.to_s)
      )
    end

    def successful?
      !!(curl.response_code == 200 && curl.body =~ /Your data has been received/)
    end
  end
end
