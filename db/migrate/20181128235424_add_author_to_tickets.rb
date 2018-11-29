class AddAuthorToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :author, foreign_key: true
  end
end
