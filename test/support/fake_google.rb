require 'sinatra/base'

class FakeGoogle < Sinatra::Base

  get "/admin/directory/v1/customer/my_customer/orgunits" do
    json_response(200, "orgunits_list.json")
  end

  post "/admin/directory/v1/customer/my_customer/orgunits" do
    json_response(200, "orgunits_insert.json")
  end

  get "/admin/directory/v1/customer/my_customer/orgunits/students" do
    json_response(200, "orgunits_find.json")
  end

  post '/oauth2/v3/token' do
    json_response(200, "oauth2.json")
  end

  get '/*' do
    # json_response 200, 'contributors.json'
    binding.pry
  end

  post "/*" do
    binding.pry
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
