class CollaboratorsController < ApplicationController
  respond_to :html, :js

  def create
    @wiki = current_user.wikis.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: params[:wiki_id], user_id: params[:collaborator_id])

    if @collaborator.save
      flash[:notice] = "Added collaborator."
    else
      flash[:error] = "Unable to add collaborator. Please try again."
    end

    respond_with(@collaborator) do |format|
      format.html { redirect_to @wiki }
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:wiki_id])
    @collaborator = Collaborator.find_by(wiki_id: params[:wiki_id], user_id: params[:id])  
    
    if @collaborator.destroy
      flash[:success] = "Removed collaborator."
    else
      flash[:error] = "Unable to remove collaborator. Please try again."
    end

    respond_with(@collaborator) do |format|
      format.html { redirect_to @wiki }
    end
  end

end
