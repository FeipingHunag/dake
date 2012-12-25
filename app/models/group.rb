class Group < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  has_many :messages, as: :received_messageable
  
  define_index do
    indexes name, :sortable => true
    indexes description

    set_property :delta => true
    set_property :field_weights => {
      :name => 10,
      :description => 5
    }
  end
end
