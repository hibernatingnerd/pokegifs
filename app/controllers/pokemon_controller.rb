class PokemonController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.json do
        res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/pikachu/")
        body = JSON.parse(res.body)
        id = body['id']
        type = body['types'].first['type']['name']
        name = body["name"] # should be "pikachu"

        gif_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIFFY_API_KEY"]}&q=#{name}rating=g")
        gif_body = JSON.parse(gif_res.body)
        gif_url = gif_body["data"][0]["url"]

        render json: {
          "id": "#{id}",
          "type": "#{type}",
          "name": "#{name}",
          "picture": "#{gif_url}"       }


      end
    end
  end
end
