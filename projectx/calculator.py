#!/usr/bin/python3

def add(x, y):
    """Return the sum of x and y."""
    return x + y

def subtract(x, y):
    """Return the difference between x and y."""
    return x - y

def multiply(x, y):
    """Return the product of x and y."""
    return x * y

def divide(x, y):
    """Return the division of x by y. Raises an exception if y is zero."""
    if y == 0:
        raise ValueError("Cannot divide by zero")
    return x / y

def power(x, y):
    """x power y"""
    return x ** y

if __name__ == "__main__":

    dummy = 1
