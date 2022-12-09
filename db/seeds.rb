require "ebay/finding"
require "ebay/browse"
require "ebay/oauth/client_credentials_grant"
require "json"
require "net/http"

# Active Admin
# ------------

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# eBay
# ----

class EbayService

  def initialize(query)
    Ebay.configure do |config|
      config.app_id = ENV["EBAY_APP_ID"]
      config.dev_id = ENV["EBAY_DEV_ID"]
      config.cert_id = ENV["EBAY_CERT_ID"]
    end

    request = Ebay.finding(response_data_format: "JSON").sandbox
    response = request.find_items_by_keywords(query)
    response_json = JSON.parse(response)
    response_filtered = response_json["findItemsByKeywordsResponse"][0]["searchResult"][0]
    @search_results = response_filtered["item"]

    log_file = "log/debug.log"
    @log = Logger.new(STDOUT, log_file)
    @log.level = Logger::DEBUG
  end

  def clear_database
    Product.destroy_all
    Category.destroy_all
    @log.info "Database has been cleared."
  end

  def log_database_count
    @log.info "Database contains #{Product.count} Products."
    @log.info "Database contains #{Category.count} Categories."
  end

  def lorem_ipsum_generator(paragraphs)
    source = "https://baconipsum.com/api/?type=all-meat&paras=#{paragraphs}&start-with-lorem=1&format=html"
    resp = Net::HTTP.get_response(URI.parse(source))
    resp.body
  end

  def add_category(category_title)
    if Category.exists?(title: category_title)
      @log.info "[Duplicate Category] #{category_title}"
      Category.where(title: category_title).first_or_create
    else
      @log.info "[Adding Category] #{category_title}"
      category = Category.where(title: category_title).first_or_create
      category.title = category_title
      category.description = lorem_ipsum_generator(1)

      category.save
      category
    end
  end

  def add_products
    if @search_results.present?
      @search_results.each_with_index do |s, i|
        product_title = s["title"][0]
        if Product.exists?(title: product_title)
          @log.info "[Duplicate Item] #{product_title}. Item #{i + 1} of #{@search_results.count}"
        else
          @log.info "[Adding Item] #{product_title}. Item #{i + 1} of #{@search_results.count}"

          # product details
          product = Product.where(title: product_title).first_or_create
          product.title = product_title
          product.description = lorem_ipsum_generator(3)
          product.sku = s["itemId"][0]
          product.quantity = rand(0..100)
          product.price = s["sellingStatus"][0]["currentPrice"][0]["__value__"]

          # randomly create a list price
          rand_list_price = rand(0..10)
          product.list_price = product.price + rand_list_price if rand_list_price > 7

          # category
          category_title = s["primaryCategory"][0]["categoryName"][0]
          category = add_category(category_title)
          product.categories << category unless product.categories.include?(category)

          # secondary category
          if s["secondaryCategory"].present?
            category_title = s["secondaryCategory"][0]["categoryName"][0]
            category = add_category(category_title)
            product.categories << category unless product.categories.include?(category)
          end

          # image
          image_uri = s["galleryURL"][0]
          @log.info image_uri

          if image_uri.present?
            # downloaded_image = URI.parse(image_uri).open
            downloaded_image = open(image_uri)

            product.main_image.attach(io: downloaded_image, filename: image_uri.split("/")[-1])
          end

          product.save
        end
      end
    else
      @log.info "[No Items Found]"
    end
  end
end

search_terms = ["nikon", "canon camera", "dash cam", "security camera",
                "webcam", "lens", "pentax", "kodak", "minolta", "camera",
                "iphone", "tripod", "viewfinder"]

search_terms = ["sony"]

search_terms.each_with_index do |s, i|
  ebay_service = EbayService.new(s)
  # ebay_service.clear_database if i.zero?
  ebay_service.add_products
  ebay_service.log_database_count
end


# Provincial tax rates
# Province.create!(name: 'Alberta', gst: 0.05, pst: 0, hst: 0)
# Province.create!(name: 'British Columbia', gst: 0.05, pst: 0.07, hst: 0)
# Province.create!(name: 'Manitoba', gst: 0.05, pst: 0.07, hst: 0)
# Province.create!(name: 'New Brunswick', gst: 0, pst: 0, hst: 0.15)
# Province.create!(name: 'Newfoundland and Labrador', gst: 0, pst: 0, hst: 0.15)
# Province.create!(name: 'Northwest Territories', gst: 0.05, pst: 0, hst: 0)
# Province.create!(name: 'Nova Scotia', gst: 0, pst: 0, hst: 0.15)
# Province.create!(name: 'Nunavut', gst: 0.05, pst: 0, hst: 0)
# Province.create!(name: 'Ontario', gst: 0, pst: 0, hst: 0.13)
# Province.create!(name: 'Prince Edward Island', gst: 0, pst: 0, hst: 0.15)
# Province.create!(name: 'Quebec', gst: 0.05, pst: 0.09975, hst: 0)
# Province.create!(name: 'Saskatchewan', gst: 0.05, pst: 0.06, hst: 0)
# Province.create!(name: 'Yukon', gst: 0.05, pst: 0, hst: 0)

