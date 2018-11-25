
''' Unit tests for pronto_utils.py '''

import unittest

from pronto_utils import download_if_needed_urllib3
from pronto_utils import remove_data
from pronto_utils import ploting_joined_totals


class TestDownloadIfNeeded(unittest.TestCase):
  # Testing download_if_needed_urllib3 if the file is there this should pass
  def test_download_withfile(self):
    result = download_if_needed_urllib3("https://s3.amazonaws.com/pronto-data/open_data_year_one.zip",
                                        "open_data_year_one.zip")
    self.assertEqual(7,result)

    # Testing download_if_needed_urllib3, if the file is not there this should pass
  def test_download_withoutfile(self):
    result = download_if_needed_urllib3("https://s3.amazonaws.com/pronto-data/open_data_year_one.zip",
                                        "open_data_year_one.zip")
    self.assertEqual(8,result)

class TestPlotting(unittest.TestCase):
    #testing if plotting is properly executed
  def test_plotting(self):
    result = ploting_joined_totals()
    self.assertEqual(9,result)

class TestRemoveData(unittest.TestCase):
  # remove_data
  def test_remove_data_withfile(self):
    # if the file exists, this should pass next test should fail
    result = remove_data()
    self.assertEqual(5,result)

  def test_remove_data_withoutfile(self):
    # if the file does not exist this should pass and the previous test fail
    result = remove_data()
    self.assertEqual(6,result)

if __name__ == '__main__':
    unittest.main()
