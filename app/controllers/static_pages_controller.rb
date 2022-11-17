class StaticPagesController < InheritedResources::Base
  private

    def static_page_params
      params.require(:static_page).permit(:title, :body)
    end

end
