class Experiment < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    validates :type, presence: true
    validates :nodes, presence: true, length: { minimum: 3 } 
    validates  :user_id, presence: true
end
