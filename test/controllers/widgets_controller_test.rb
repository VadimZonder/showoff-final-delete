require 'minitest/autorun'
require "open-uri"
require 'rest-client'
require 'json'

#IMPORTAT PREREQUISITE - LOGIN TO THE APPLICATION AND GET THE ACCESS TOKEN FROM CONSOLE AND SET ALL access_token var equal to it.
# Also the assert ust contain a string from your own widgets to which a bearer belongs to.
def callingAllMyVisibleWidgetsAPI(access_token, url)
  ###chnange whne recieve working credentials
  @client_id= "277ef29692f9a70d511415dc60592daf4cf2c6f6552d3e1b769924b2f2e2e6fe"
  @client_secret = "d6106f26e8ff5b749a606a1fba557f44eb3dca8f48596847770beb9b643ea352"
  @access_token =  access_token
  #will cause an error if access_token is nil
  if !@access_token.nil?
    @authorization = "Bearer "+@access_token
  end

  #ALl My Widgets
  @myWidgetsUrl = url + 'client_id='+@client_id+'&client_secret='+@client_secret

  @myWidgetsResponceSample = RestClient.get(@myWidgetsUrl, {
      content_type: 'application/json',
      authorization: @authorization
  })

  #display auth message
  ### @res = result
  ### @jsonParse = JSON.parse @res
  @objectCounter =1
  @jsonParseAllWidgets = JSON.parse (@myWidgetsResponceSample) ##change to the actual json string
  # @nameResultsArray = @jsonParseAllWidgets["data"]["widgets"][0]["name"]
  arrayCount = @jsonParseAllWidgets["data"]["widgets"].count-1
  #@nameResultsArray = @jsonParseAllWidgets["data"]["widgets"][1]["name"]
  @nameResultsArray = []
  @descriptionResultsArray = []
  @fNameResultsArray = []
  @lNameResultsArray = []
  while arrayCount != -1 do
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["id"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["name"])
    @nameResultsArray = @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["description"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["kind"])
    @nameResultsArray =  @nameResultsArray.push(@jsonParseAllWidgets["data"]["widgets"][arrayCount-1]["user"]["images"]["small_url"])

    arrayCount = arrayCount - 1
  end

  #special return for test cases
  return @myWidgetsResponceSample + ' ' + @nameResultsArray.to_s
end

class WidgetsControllerTest <  Minitest::Test

  #testing if API responds for all visible widgets
  def test_all_my_visible_widgets_api
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /code/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end

  def test_all_my_visible_widgets_success
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /Success/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end
  #finding my on ids record in visible widgets
  def test_all_my_visible_widgets_id
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /:1222,/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end
  #finding my on record in visible widgets
  def test_all_my_visible_widgets_name
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /Vadim23/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end
  #finding my on description record in visible widgets - not a great description but uniquness is the key
  def test_all_my_visible_widgets_description
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /Widget Vadim 23/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end
  #finding my on visibility record in visible widgets - not a great description but uniquness is the key
  def test_all_my_visible_widgets_privacy
    access_token = '29da6be5ff0ec42df0a41c5deecc849f67fd0b40b2be9619b56b1e5451f84f9c'
    url = 'https://showoff-rails-react-production.herokuapp.com/api/v1/users/me/widgets?'
    assert_match /visible/, callingAllMyVisibleWidgetsAPI(access_token, url)
  end
end
