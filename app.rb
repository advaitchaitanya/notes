require "sinatra"
require "sinatra/activerecord"
require "./models/note"

set :database_file, "config/database.yml"

get "/" do
  @notes = Note.all
  erb :index
end

# Form to create a new note
get "/notes/new" do
  erb :new
end

# Create a note
post "/notes" do
  note = Note.new(title: params[:title], content: params[:content])
  if note.save
    redirect "/"
  else
    "Error saving note"
  end
end

# Edit form
get "/notes/:id/edit" do
  @note = Note.find(params[:id])
  erb :edit
end

# Update note
put "/notes/:id" do
  note = Note.find(params[:id])
  if note.update(title: params[:title], content: params[:content])
    redirect "/"
  else
    "Error updating note"
  end
end

# Delete note
delete "/notes/:id" do
  Note.find(params[:id]).destroy
  redirect "/"
end
