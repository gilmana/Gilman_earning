
''' Unit tests for pronto_utils.py '''

import unittest

from PDAT import plot_x_vs_y


class TestPlotting(unittest.TestCase):
    #testing if plotting is properly executed
  def test_plotting(self):
    result = plot_x_vs_y()
    self.assertEqual(7,result)


if __name__ == '__main__':
    unittest.main()
