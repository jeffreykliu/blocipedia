class Collaborator < ActiveRecord::Base 
  belongs_to :user
  belongs_to :wiki

  def collaborated(wiki)
    collaborators.where(wiki_id: wiki.id).first
  end
  
end
