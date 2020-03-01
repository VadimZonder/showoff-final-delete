require 'minitest/autorun'
require "open-uri"
require 'rest-client'
require 'json'

#IMPORTAT PREREQUISITE - LOGIN TO THE APPLICATION AND GET THE ACCESS TOKEN FROM CONSOLE AND SET ALL access_token var equal to it.
def callingAllVisibleWidgetsAPI(access_token, url)
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

  @objectCounter = 1
  #change to the actual json string
  @jsonParseAllWidgets = JSON.parse (@allWidgetsResponceSample)
  arrayCount = @jsonParseAllWidgets["data"]["widgets"].count-1

  @nameResultsArray = []

  while arrayCount != -1 do
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["user"]["id"])
    @nameResultsArray = @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["id"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["name"])
    @nameResultsArray = @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["description"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["kind"])

    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["user"]["name"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["user"]["images"]["small_url"])
    arrayCount = arrayCount - 1
  end

  #special return for test cases
  return @allWidgetsResponceSample + ' ' + @nameResultsArray.to_s
end

class WelcomeControllerTest <  Minitest::Test

  #testing if API responds for all visible widgets
  def test_all_visible_widgets_api
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /code/, callingAllVisibleWidgetsAPI(access_token, url)
  end

  def test_all_visible_widgets_success
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /Success/, callingAllVisibleWidgetsAPI(access_token, url)
  end
  #finding my on ids record in visible widgets
  def test_all_visible_widgets_id
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /313, 172/, callingAllVisibleWidgetsAPI(access_token, url)
  end
  #finding my on record in visible widgets
  def test_all_visible_widgets_name
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /Vadim Malakhovski/, callingAllVisibleWidgetsAPI(access_token, url)
  end
  #finding my on description record in visible widgets - not a great description but uniquness is the key
  def test_all_visible_widgets_description
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /sgdfg/, callingAllVisibleWidgetsAPI(access_token, url)
  end
  #finding my on visibility record in visible widgets - not a great description but uniquness is the key
  def test_all_visible_widgets_privacy
    access_token = '341b1cfe8f8abfe4a9f97341349d38da5c6de43bae7e7a7dd899f782c85153251'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/widgets/visible?'
    assert_match /Visible/, callingAllVisibleWidgetsAPI(access_token, url)
  end


end
