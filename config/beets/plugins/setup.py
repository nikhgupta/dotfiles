from setuptools import setup
from os import path

directory = path.abspath(path.dirname(__file__))
readme_path = path.join(directory, 'README.rst')

try:
    import pypandoc
    long_description = pypandoc.convert_file(readme_path, 'rst')
except (IOError, ImportError):
    long_description = open(readme_path, encoding='utf-8').read()

setup(
    name='beets-betterlisting',
    version='1.0.0',
    description="Beets plugin for better listing of music",
    long_description=long_description,
    url='https://github.com/nikhgupta/beets-betterlisting',
    download_url='https://github.com/nikhgupta/beets-betterlisting.git',
    author='nikhgupta',
    author_email='me@nikhgupta.com',
    license='MIT',
    platforms='ALL',
    classifiers=[
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.6',
        'Topic :: Multimedia :: Sound/Audio',
        'Environment :: Console',
    ],
    packages=['beetsplug'],
    namespace_packages=['beetsplug'],
    install_requires=['beets>=1.4.3'],
)
