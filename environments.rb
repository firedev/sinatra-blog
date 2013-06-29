configure :development do
	set :database, 'sqlite:///dev.db'
end

configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

	ActiveRecord::Base.establish_connection(
    :adapter 	=> db.scheme == 'postgres' ? 'postgres' : db.scheme,
    :host			=> db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
	)
end