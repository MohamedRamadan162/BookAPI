class AddForgotPasswordAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :forgot_password_digest, :string
    add_column :users, :forgot_password_digest_created_at, :datetime
    add_column :users, :is_forgot_password_code_used, :boolean, default: false
  end
end
