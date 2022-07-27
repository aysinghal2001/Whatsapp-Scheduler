require 'selenium-webdriver'
require 'date'
require 'time'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--user-data-dir=C:\Users\ayush\AppData\Local\Google\Chrome\User Data\Default')
options.add_argument('--profile-directory=Default')
driver= Selenium::WebDriver.for :chrome, options: options
driver.get 'https://web.whatsapp.com/'
driver.manage.window.maximize
sleep(15)

user_name_list = ['Home']
msg = 'Message sent by Automation testing: Kindly ignore!'
today = Date.today.strftime("%d-%m-%Y")
current_time = Time.now.strftime("%H:%M:%S")
msgDate = '28-07-2022'
msgTime = '01:18:00'


while true
  if msgDate == today
    current_time = Time.now.strftime("%H:%M:%S")
    while current_time < msgTime
      puts "Current time is #{current_time} and message time is #{msgTime}"
      puts "Waiting for message time to occur"
      sleep(1)
      current_time = Time.now.strftime("%H:%M:%S")
    end
    if current_time >= msgTime
      for username in user_name_list do 

        driver.find_element(:xpath, '//div[@class="_13NKt copyable-text selectable-text"]').send_keys(username)
        sleep(3)
        user = driver.find_element(:xpath, '//span[@title="'+username+'"]')
        user.click
        sleep(3)
        message_box = driver.find_element(:xpath, '/html/body/div[1]/div/div/div[4]/div/footer/div[1]/div/span[2]/div/div[2]/div[1]/div/div[1]/p')
        message_box.send_keys(msg)
        sleep(2)
        message_box.send_keys(:enter)
        sleep(2)
        driver.save_screenshot("sample.png")
      end
      driver.quit
    end
  end
end

