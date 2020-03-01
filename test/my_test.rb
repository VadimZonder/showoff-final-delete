require 'minitest/autorun'
require "open-uri"
require 'rest-client'
require 'jbuilder'

#methods used in welcome_controller#index
def callingAllVisibleVigetsAPI(access_token, url)
     @client_id= "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe"
     @client_secret = "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352"
     @access_token =  access_token
     #will cause an error if access_token is nil
     if !@access_token.nil?
         @authorization = "Bearer "+@access_token
     end

     @urlAllWidgetsVisible = url + 'client_id='+@client_id+'&client_secret='+@client_secret

     @allWidgetsResponceSample = RestClient.get(@urlAllWidgetsVisible, {
         content_type: 'application/json',
         authorization: @authorization
     })
     #for testing purposes returning a value which would be common in all sucessfull calls
     return @allWidgetsResponceSample

end

def add_two_numbers(n1, n2)
  return n1+n2
end
class TestFoo < Minitest::Test
  @access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
  @url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
  # def test_minitest
  #  assert_equal 5, add_two_numbers(2,3)
  #end

  def test_all_visible_widgets_api
    #assert_equal 4, callingAllVisibleVigetsAPI()
    assert_match /code/, callingAllVisibleVigetsAPI(@access_token, @url)
  end
end
