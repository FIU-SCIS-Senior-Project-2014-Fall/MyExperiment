class Experiment < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC') }
    validates :topoType, presence: true
    validates :nodes, presence: true
    validates :user_id, presence: true

    def Experiment.display
        if :topoType == 1
            b = Bus.new(:nodes)
            b.d3ify
        end
    end
end
