get '/' do
  @short_url = params[:shortened]
  @errors = params[:error]
  erb :index
end

post '/urls' do
  url = Url.create({ url: params[:long_url] })
  short_url = "http://localhost:9393/#{url.id}"
  if url.id
    redirect to("/?shortened=#{short_url}")
  else
    redirect to("/?error=#{url.errors.first[1]}")
  end
end

# e.g., /q6bda
get '/:short_url' do
  id = params[:short_url].to_i
  redirect to(Url.find(id).url)
end
