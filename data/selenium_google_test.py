#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time

class GoogleTest(unittest.TestCase):

    browser = None

    def setUp(self):
        self.browser = webdriver.Remote(
            command_executor='http://yalla.dev:4444/wd/hub',
            desired_capabilities=DesiredCapabilities.FIREFOX
        )

    def test_add_new_item(self):
        self.browser.get("http://www.python.org")
        self.assertIn("Python", self.browser.title)
        elem = self.browser.find_element_by_name("q")
        elem.send_keys("selenium")
        elem.send_keys(Keys.RETURN)
        self.assertIn("Google", self.browser.title)

    def tearDown(self):
        self.browser.close()

if __name__ == "__main__":
    unittest.main()
