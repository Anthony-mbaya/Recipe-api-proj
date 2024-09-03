"""
sample test
"""


from django.test import SimpleTestCase
from app import calc


class CalcTest(SimpleTestCase):
    def test_add(self):
        res = calc.add(4, 7)
        self.assertEqual(res, 11)

    def test_subtract(self):
        res = calc.subtract(10, 15)
        self.assertEqual(res, 5)
