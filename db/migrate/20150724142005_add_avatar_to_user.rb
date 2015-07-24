class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar 
    # khi ban khai bao :avatar kieu attachment thi se tu dong sinh ra trong schema 4 thuoc tinh cua avatar :
    # [avatar_file_name, avatar_content_type, avatar_file_size, avatar_updated_at]
  end
end
