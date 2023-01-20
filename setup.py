import os
from distutils.dir_util import copy_tree
from setuptools import find_packages, setup

# global variables
board = os.environ['BOARD']
repo_board_folder = f'boards/{board}'
board_notebooks_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
package_name = 'strath_sdfec'

data_files = []

# copy overlays to python package
def copy_overlays():
    src_ol_dir = os.path.join(repo_board_folder, package_name, 'bitstream')
    dst_ol_dir = os.path.join(package_name, 'bitstream')
    copy_tree(src_ol_dir, dst_ol_dir)
    data_files.extend(
        [os.path.join("..", dst_ol_dir, f) for f in os.listdir(dst_ol_dir)])
    src_ol_dir = os.path.join(repo_board_folder, ''.join([package_name, '_hw']), 'bitstream')
    dst_ol_dir = os.path.join(package_name, 'bitstream')
    copy_tree(src_ol_dir, dst_ol_dir)
    data_files.extend(
        [os.path.join("..", dst_ol_dir, f) for f in os.listdir(dst_ol_dir)])

if board in ['RFSoC2x2', 'RFSoC4x2', 'ZCU111']:
    copy_overlays()

setup(
    name=package_name,
    version='1.0.1',
    author="Lewis McLaughlin",
    packages=find_packages(),
    package_data={
        '': data_files,
    },
    description="RFSoC SD-FEC Driver and Design @ StrathSDR.")
