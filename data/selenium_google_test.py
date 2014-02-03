#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time

class NoBrowserException(Exception):
    """ No browser exception """
    def __init__(self, value):
        super(NoBrowserException, self).__init__()
        self.value = value
    def __str__(self):
        return repr(self.value)


class GoogleTest(unittest.TestCase):
    """ Test that Google is up ;) """

    browser = None

    def setUp(self):
        if self.browser is None:
            # Go with Google Chrome as default
            self.browser = webdriver.Remote(
                command_executor='http://yalla.dev:4444/wd/hub',
                desired_capabilities=DesiredCapabilities.CHROME
            )

    def test_search(self):
        """
        A simple test to verify that Google.se is working
        ... and that selenium is up and running.
        """
        self.browser.get("http://google.se")
        self.assertIn("Google", self.browser.title)
        elem = self.browser.find_element_by_name("q")
        elem.send_keys("Yalla")
        elem.send_keys(Keys.RETURN)

        time.sleep(1)
        if not self.browser.get_screenshot_as_file('google.png'):
            print 'Unable to save screenshot'

    def tearDown(self):
        self.browser.close()
        self.browser = None

class FirefoxTest(GoogleTest):
    """ Test in Firefox """
    def setUp(self):
        self.browser = webdriver.Remote(
            command_executor='http://yalla.dev:4444/wd/hub',
            desired_capabilities=DesiredCapabilities.FIREFOX
        )

if __name__ == "__main__":
    unittest.main()
