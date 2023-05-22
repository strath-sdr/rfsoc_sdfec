import os
from distutils.dir_util import copy_tree
from setuptools import find_packages, setup

class package_installer():
    def __init__(self,
                 name,
                 version,
                 description,
                 author,
                 email,
                 license,
                 url,
                 pynq_version,
                 board):
        
        args = locals()
        for key in args:
            if key != 'self':
                setattr(self, key, args[key])
        if os.path.isdir(f'boards/{self.board}/{self.name}'):
            self.copy_projects()
        self.run_setup()
        
    def copy_projects(self):
        cwd = os.getcwd()
        for prj in next(os.walk(os.path.join(cwd, 'boards', self.board)))[1]:
            temp_prj = os.path.join(cwd, 'boards', self.board, prj)
            for directory in next(os.walk(temp_prj))[1]:
                src = os.path.join(temp_prj, directory)
                dst = os.path.join(cwd, self.name, prj, directory)
                copy_tree(src, dst)

    def generate_pkg_dirs(self):
        data_files = []
        for directory in os.walk(os.path.join(os.getcwd(), self.name)):
            for file in directory[2]:
                data_files.append("".join([directory[0],"/",file]))
        return data_files

    def run_setup(self):
        setup(name=self.name,
              version=self.version,
              install_requires=[self.pynq_version],
              url=self.url,
              license=self.license,
              author=self.author,
              author_email=self.email,
              packages=find_packages(),
              package_data={'': self.generate_pkg_dirs()},
              description=self.description)

if "BOARD" in os.environ:
    board = os.environ['BOARD']
    pynq_version = "pynq>=2.7"
else:
    board = ""
    pynq_version = ""

package_installer(name = "strath_sdfec",
                  version = "1.1.0",
                  description  = "RFSoC SD-FEC Driver and Design @ StrathSDR.",
                  author = "Lewis Davin McLaughlin",
                  email = "lewis.mclaughlin@strath.ac.uk",
                  license = "",
                  url = "https://github.com/strath-sdr/rfsoc_sdfec.git",
                  pynq_version = pynq_version,
                  board = board)
