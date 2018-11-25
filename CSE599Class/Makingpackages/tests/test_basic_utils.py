from makingpackages import multiply_by_10
from numpy import inf

def test_multiple_by_10():
    assert multiply_by_10(3) == 30
    assert multiply_by_10(-1) == -10
    assert multiple_by_10(inf) == inf
    assert multiple_by_10(-inf) == -inf

def test_failure():
    assert 1 == 0
    
