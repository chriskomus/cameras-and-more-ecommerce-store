class StaticPagesController < InheritedResources::Base
  private

  add_breadcrumb "Home", :root_path

    def static_page_params
      params.require(:static_page).permit(:title, :body)
    end
end
