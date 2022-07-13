require 'httparty'
require 'json'

puts('Started')

BASE_URL = 'http://localhost:3000/api/v1'

users_response = HTTParty.get("#{BASE_URL}/users/index")

if users_response.code == 200
	users = JSON.parse(users_response.body)["data"]
	users.each() do |u|
		balance_respone = HTTParty.get("#{BASE_URL}/balances/#{u['id']}")
		if balance_respone.code == 200
			balance = JSON.parse(balance_respone.body)["data"]
			result = HTTParty.post("#{BASE_URL}/balances",
    								:body => {
               							:amount => balance,
               							:user_id => u['id']
             						}.to_json,
    								:headers => { 'Content-Type' => 'application/json' } )
			puts(result)
		end

	end
end

puts("Finish")
