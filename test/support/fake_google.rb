require 'sinatra/base'

class FakeGoogle < Sinatra::Base

  # -- Org Units

  get "/admin/directory/v1/customer/my_customer/orgunits" do
    json_response(200, "orgunits_list.json")
  end

  post "/admin/directory/v1/customer/my_customer/orgunits" do
    request.body.rewind
    pbody = JSON.parse request.body.read

    if pbody["parentOrgUnitPath"] != "/"
      json_response(200, "orgunits_insert_child.json")
    else
      json_response(200, "orgunits_insert_top.json")
    end
  end

  get "/admin/directory/v1/customer/my_customer/orgunits/students" do
    json_response(200, "orgunits_find.json")
  end

  post "/oauth2/v3/token" do
    json_response(200, "oauth2.json")
  end

  patch "/admin/directory/v1/customer/my_customer/orgunits" do
    json_response 200, 'orgunits_patch.json'
  end

  # -- User

  get "/admin/directory/v1/users/jane@example.org" do
    json_response 200, 'users_get.json'
  end

  post "/admin/directory/v1/users" do
    binding.pry
  end

  # -- Catch-alls

  get "/*" do
    binding.pry
  end

  post "/*" do
    binding.pry
  end

  patch "/*" do
    binding.pry
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
