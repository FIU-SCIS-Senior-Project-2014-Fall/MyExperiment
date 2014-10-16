class ExperimentsController < ApplicationController
    before_action :signed_in_user
    
    def index

    end

    def create
        @experiment = current_user.experiments.build(experiment_params)
        if @experiment.save
            flash[:success] = "Experiment created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end

    def destroy

    end

    private
        def experiment_params
            params.require(:experiment).permit(:content)
        end
end
