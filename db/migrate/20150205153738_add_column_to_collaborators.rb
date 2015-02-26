class AddColumnToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :usercollaborator_id, :integer
  end

end
