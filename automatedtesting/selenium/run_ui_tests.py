# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.common.by import By
import logging

# Start the browser and login with standard_user
def run_ui_tests(user, password):
    logging.basicConfig(
        format='%(asctime)s %(levelname)-8s %(message)s',
        level=logging.INFO,
        datefmt='%Y-%m-%d %H:%M:%S')
    logging.info( 'Starting the browser...' )
    options = ChromeOptions()
    options.add_argument("--headless")
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options)
    driver.get('https://www.google.nl/')

    # driver = webdriver.Chrome()
    logging.info('Browser started successfully.')
    logging.info('Navigating to the login page.')
    driver.get('https://www.saucedemo.com/')
    logging.info( 'Loging in to https://www.saucedemo.com/')
    
    elem_username = driver.find_element(By.CSS_SELECTOR, 'input[data-test="username"]')
    elem_username.send_keys(user)

    elem_password = driver.find_element(By.CSS_SELECTOR, 'input[data-test="password"]')
    elem_password.send_keys(password)

    elem_login = driver.find_element(By.CSS_SELECTOR, 'input[value=Login]')
    elem_login.click()
    logging.info('Searching for Products.')

    headerLabel = driver.find_element(By.CLASS_NAME, 'header_secondary_container')
    headerLabel.text
    logging.info('Successfully logged in ' + str(elem_username) + '.')
    logging.info('Selecting products.')

    products = driver.find_elements(By.CSS_SELECTOR, '.inventory_item')
    logging.info('Adding products to cart.')
    for product in products:
        product_name = product.find_element(By.CSS_SELECTOR, '.inventory_item_name')
        product_name.text
        product_button = product.find_element(By.CSS_SELECTOR, 'button.btn_inventory')
        product_button.click()
        logging.info(product_name.text + ' successfully added to cart.')

    logging.info('Verifying if cart has been populated with 6 products.')
    cart_label = driver.find_element(By.CSS_SELECTOR, '.shopping_cart_badge')
    cart_label.text
    assert cart_label.text == "6"

    logging.info('Navigating to shopping cart.')

    cart_link = driver.find_element(By.CSS_SELECTOR, 'a.shopping_cart_link')
    cart_link.click()
    assert '/cart.html' in driver.current_url, 'Navigation to shopping cart unsuccessful.'

    logging.info('Removing products from cart.')
    cart_products = driver.find_elements(By.CSS_SELECTOR, '.cart_item')

    for product in cart_products:
        product_name = product.find_element(By.CSS_SELECTOR, '.inventory_item_name')
        logging.info(product_name.text)
        product_button = product.find_element(By.CSS_SELECTOR, 'button.cart_button')
        product_button.click()
        logging.info(str(product_name) + ' successfully removed from cart.')
        
    logging.info('Confirming that shopping cart is empty.')

    cart_empty = driver.find_elements(By.CSS_SELECTOR, '.shopping_cart_badge')
    if cart_empty:
        cart_emptiness_flag = False
    else:
        cart_emptiness_flag = True
    assert cart_emptiness_flag == True
    logging.info('Shopping cart successfully emptied: ' + str(cart_emptiness_flag))

run_ui_tests('standard_user', 'secret_sauce')