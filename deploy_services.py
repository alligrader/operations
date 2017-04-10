#!/usr/local/bin/python

import os
import subprocess

# path is the path to the directory that contains all of the YAML or JSON files 
# specifying the deployments and services to apply
path = 'deployments'

def main():

    files = os.listdir(path)
    for f in files:
        full_name = os.path.join(path, f)
        cmd = 'kubectl apply -f {fileName}'.format(fileName=full_name)
        subprocess.check_call(cmd, shell=True)

if __name__ == '__main__':
    main()
