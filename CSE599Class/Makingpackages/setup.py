import os
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

# Get version and release info, which is all stored in shablona/version.py
ver_file = os.path.join('shablona', 'version.py')
with open(ver_file) as f:
    exec(f.read())

opts = dict(name=NAME,
            description="Example of making packages and how to install them"
            packages=["makingpackages", "makingpackages/tests"]



if __name__ == '__main__':
    setup(**opts)
