import sys
from distutils.core import setup, Extension


def main():
    if not sys.version.startswith('2.'):
        sys.stderr.write('This backport is for Python 2.x only.\n')
        sys.exit(1)

    ext = Extension('_posixsubprocess', ['_posixsubprocess.c'],
                    depends=['_posixsubprocess_helpers.c'])

    setup(
      name='subprocess32',
      version='3.2.3b1',
      description='Backport of the subprocess module from Python 3.2.3 for use on 2.x.',
      long_description="""
This is a backport of the subprocess standard library module from
Python 3.2.3 for use on Python 2.4, 2.5, 2.6 & 2.7.
It includes bugfixes and new features.  On POSIX systems it should
be MUCH more reliable when used in threaded applications.""",
      license='PSF license',

      maintainer='Gregory P. Smith',
      maintainer_email='greg@krypto.org',
      url='http://code.google.com/p/python-subprocess32/',

      ext_modules=[ext],
      py_modules=['subprocess32'],
    )


if __name__ == '__main__':
    main()
