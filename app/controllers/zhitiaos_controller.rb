class ZhitiaosController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    
    
    def create
        @zhitiao = current_user.zhitiaos.build(zhitiao_params)
        if @zhitiao.save
            flash[:success] = "Zhitiao created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end
    
    def destroy
        @zhitiao.destroy
        flash[:success] = "zhitiao deleted"
        redirect_to request.referrer || root_url
    end
    
    private
        def zhitiao_params
            params.require(:zhitiao).permit(:content)
        end
        
        def correct_user
            @zhitiao = current_user.zhitiaos.find_by(id: params[:id])
            redirect_to root_url if @zhitiao.nil?
        end
    
    
end
