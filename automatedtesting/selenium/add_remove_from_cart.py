# #!/usr/bin/env python
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options as ChromeOptions

# Start the browser and login with standard_user
def add_remove_from_cart (user, password):
    # Configure the logger
    logging.basicConfig(filename='selenium.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

    print ('Starting the browser...')
    logging.info("Starting the browser...")
    # --uncomment when running in Azure DevOps.
    options = ChromeOptions()
    options.add_argument("--headless") 
    driver = webdriver.Chrome(options=options)
    # driver = webdriver.Chrome()

    print ('Browser started successfully. Navigating to the demo page to login.')
    logging.info("Browser started successfully. Navigating to the demo page to login.")
    driver.get('https://www.saucedemo.com/')

    print ('Login with ' + user + ' and '+ password + '.')
    logging.info ('Login with ' + user + ' and '+ password + '.')
    driver.find_element(by=By.ID, value='user-name').send_keys(user)
    driver.find_element(by=By.ID, value='password').send_keys(password)
    driver.find_element(by=By.ID, value='login-button').click()

    login_result = driver.find_element(by=By.CSS_SELECTOR, value='div[id="header_container"] > div.header_secondary_container > span')
    assert login_result.text == 'Products'
    print ('Login successfully.')
    logging.info ('Login successfully.')

    inventory_items = driver.find_elements(by=By.CSS_SELECTOR, value='div[id="inventory_container"] > div > div[class="inventory_item"]')
    for element in inventory_items:
        inventory_name = element.find_element(by=By.CLASS_NAME, value= 'inventory_item_name')
        print ('Add ' + inventory_name.text + ' to cart.')
        logging.info ('Add ' + inventory_name.text + ' to cart.')
        add_to_cart_btn = element.find_element(by=By.CLASS_NAME, value='btn_inventory')
        add_to_cart_btn.click()
    
    cart_items_count = driver.find_element(by=By.CSS_SELECTOR, value='div[id="shopping_cart_container"] > a > span')
    assert cart_items_count.text == str(len(inventory_items))
    print ('Add products to cart.')
    logging.info ('Add products to cart.')

    print ('Navigate to cart.')
    logging.info ('Navigate to cart.')
    cart_link = driver.find_element(by=By.CSS_SELECTOR, value='div[id="shopping_cart_container"] > a')
    cart_link.click()

    navigate_cart_result = driver.find_element(by=By.CSS_SELECTOR, value='div[id="header_container"] > div.header_secondary_container > span')
    assert navigate_cart_result.text == 'Your Cart'
    print ('Navigate to cart successfully.')
    logging.info ('Navigate to cart successfully.')

    print ('Remove products from cart.')
    logging.info ('Remove products from cart.')
    removed_items = 0
    cart_items = driver.find_elements(by=By.CSS_SELECTOR, value='div[id="cart_contents_container"] > div > div.cart_list > div[class="cart_item"]')
    for element in cart_items:
        inventory_name = element.find_element(by=By.CLASS_NAME, value= 'inventory_item_name')
        print ('Remove ' + inventory_name.text + ' from cart.')
        logging.info ('Remove ' + inventory_name.text + ' from cart.')

        remove_from_cart_btn = element.find_element(by=By.CLASS_NAME, value='cart_button')
        remove_from_cart_btn.click()
        removed_items += 1

    assert removed_items == len(cart_items)
    print ('Remove all products from cart.')
    logging.info ('Remove all products from cart.')

    print ('Selenium test PASSED.')
    logging.info ('Selenium test PASSED.')

add_remove_from_cart('standard_user', 'secret_sauce')