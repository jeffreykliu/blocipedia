class RemoveUsercollaboratorIdFromCollaborators < ActiveRecord::Migration
  def change
    remove_column :collaborators, :usercollaborator_id
  end
end
