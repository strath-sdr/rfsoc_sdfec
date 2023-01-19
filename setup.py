import os

from setuptools import find_packages, setup

# global variables
board = os.environ['BOARD']
repo_board_folder = f'boards/{board}'
board_notebooks_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
package_name = 'strath_sdfec'

# check whether board is supported
def check_env():
    if not os.path.isdir(repo_board_folder):
        raise ValueError("Board {} is not supported.".format(board))
    if not os.path.isdir(board_notebooks_dir):
        raise ValueError(
            "Directory {} does not exist.".format(board_notebooks_dir))

check_env()

setup(
    name=package_name,
    version='1.0.0',
    install_requires=[
        'pynq==2.7',
    ],
    author="Lewis McLaughlin",
    packages=find_packages(),
    description="RFSoC SD-FEC Driver and Design @ StrathSDR.")
