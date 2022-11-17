# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu false
  # menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Orders" do
    #       ul do
    #         SalesOrder.recent(10).map do |order|
    #           li link_to(order.order_number, admin_sales_order_path(order))
    #         end
    #       end
    #     end
    #   end
    # end
  end # content
end
