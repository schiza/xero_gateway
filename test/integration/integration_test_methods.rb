module IntegrationTestMethods
  # If false, the tests will be run against the Xero test environment
  STUB_XERO_CALLS = true             unless defined? STUB_XERO_CALLS
  
  # If the requests are not stubbed, enter your API key and you test company customer key here
  API_KEY = "YOUR_API_KEY"           unless defined? API_KEY
  CUSTOMER_KEY = "YOUR_CUSTOMER_KEY" unless defined? CUSTOMER_KEY

  
  def dummy_invoice
     invoice = XeroGateway::Invoice.new({
       :invoice_type => "ACCREC",
       :due_date => Date.today + 20,
       :invoice_number => STUB_XERO_CALLS ? "INV-0001" : "#{Time.now.to_i}",
       :reference => "YOUR REFERENCE (NOT NECESSARILY UNIQUE!)",
       :sub_total => 1000,
       :total_tax => 125,
       :total => 1125
     })
     invoice.contact = dummy_contact
     invoice.line_items << XeroGateway::LineItem.new(
       :description => "THE DESCRIPTION OF THE LINE ITEM",
       :unit_amount => 1000,
       :tax_amount => 125,
       :line_amount => 1000,
       :tracking_category => "THE TRACKING CATEGORY FOR THE LINE ITEM",
       :tracking_option => "THE TRACKING OPTION FOR THE LINE ITEM"
     )
     invoice
  end
  
  def dummy_contact
    contact = XeroGateway::Contact.new(:name => STUB_XERO_CALLS ? "CONTACT NAME" : "THE NAME OF THE CONTACT #{Time.now.to_i}")
    contact.contact_number = STUB_XERO_CALLS ? "12345" : "#{Time.now.to_i}"
    contact.email = "bob@example.com"
    contact.phone.number = "12345"
    contact.address.line_1 = "LINE 1 OF THE ADDRESS"
    contact.address.line_2 = "LINE 2 OF THE ADDRESS"
    contact.address.line_3 = "LINE 3 OF THE ADDRESS"
    contact.address.line_4 = "LINE 4 OF THE ADDRESS"
    contact.address.city = "WELLINGTON"
    contact.address.region = "WELLINGTON"
    contact.address.country = "NEW ZEALAND"
    contact.address.post_code = "6021"

    contact
  end
  
  def get_file_as_string(filename)
    data = ''
    f = File.open(File.dirname(__FILE__) + "/stub_responses/" + filename, "r") 
    f.each_line do |line|
      data += line
    end
    f.close
    return data
  end
end