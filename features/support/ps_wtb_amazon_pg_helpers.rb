
$amazon_pg_url_expected = "https://www.amazon.com/stores/"
$amazon_pg_url_expected_2 = "https://www.amazon.com/"
$amazon_pg_404_url = "https://www.amazon.com/stores/no35as4df654asd3f5435as4df354asd354f35asd4f354asd35f"
$error_time = Time.now

module Amazon
    include RSpec::Matchers

    def amazon_pg_404_image
     @browser.img(src: 'https://images-na.ssl-images-amazon.com/images/G/01/error/title._TTD_.png')
   end
end
