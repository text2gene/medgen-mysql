import glob, os

from setuptools import setup, find_packages

setup(
    name = 'ncbi-data-mirrors',
    version = '0.0.1',
    description = 'NCBI data mirrors',
    long_description = "organizing the world's clinically relevant data sources (Links to/from NCBI MedGen)",
    url = 'https://bitbucket.org/locusdevelopment/ncbi-data-mirrors',
    author = 'Invitae, Inc.',
    maintainer = 'Andrew Mcmurry',
    author_email = 'info@locusdev.net',
    maintainer_email = 'info@locusdev.net',

    license = 'TBD',
    packages = find_packages(),
    install_requires = [
        'setuptools',
        'lxml',
        'sqlalchemy'
        ],
    )