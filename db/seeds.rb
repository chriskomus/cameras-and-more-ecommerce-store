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
    @search_results.each_with_index do |s, i|
      product_title = s["title"][0]
      if Product.exists?(title: product_title)
        @log.info "[Duplicate Item] #{product_title}. Item #{i + 1} of #{@search_results.count}"
      else
        @log.info "[Adding Item] #{product_title}. Item #{i + 1} of #{@search_results.count}"

        # image
        @log.info s["galleryURL"][0]

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

        product.save
      end
    end
  end
end

ebay_service = EbayService.new('nikon')
ebay_service.clear_database
ebay_service.add_products

ebay_service = EbayService.new('canon camera')
ebay_service.add_products

ebay_service = EbayService.new('dash cam')
ebay_service.add_products

ebay_service = EbayService.new('security camera')
ebay_service.add_products

ebay_service = EbayService.new('webcam')
ebay_service.add_products

ebay_service = EbayService.new('lens')
ebay_service.add_products

ebay_service = EbayService.new('camera')
ebay_service.add_products

ebay_service.log_database_count
