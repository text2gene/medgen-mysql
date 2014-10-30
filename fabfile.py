import os, sys
from configparser import ConfigParser
from fabric.contrib.files import append

from fabric.decorators import task

from fabric.api import shell_env, cd, run, env, sudo, local
from fabric.operations import put
from fabric.contrib.console import confirm
from fabric.colors import red
from fabric.context_managers import lcd
########################################
import sql_templates

env.hosts = ['localhost']
env.user = 'umls'
env.abort_on_prompts = False

def get_config(target='local'):
    config = ConfigParser()
    config.read_file(open(os.path.join('etc', target+'.conf')))
    return config

@task
def hostinfo():
    run('uname -s --kernel-version')

def exists(f):
    return os.path.exists(f)

def mkdir(folder):
    if not exists(folder): os.mkdir(folder)

def pwd():
    os.system('pwd')

def ll():
    os.system('pwd')


def tofile(filepath, text):
    f = open(filepath,'w')
    f.write(text)
    f.close()

def interpolate(dataset, text):
    return  text.replace('?DATASET', dataset)

def interpolate_user(dataset, dbuser, dbpass, text):
    return  text.replace('?DATASET', dataset).replace('?DB_USER', dbuser).replace('?DB_PASS',dbpass)


@task
def create_db(dataset, target='local'):

    mkdir(dataset)
    os.chdir(dataset)

    f = 'create_db.sql'

    from sql_templates import mysql_create_database as sql
    tofile(f, interpolate(dataset, sql))


@task
def create_user(dataset, dbuser=None, dbpass=None, target='local'):

    if dbuser is None: dbuser = dataset
    if dbuser is None: dbpass = dataset

    mkdir(dataset)
    os.chdir(dataset)

    f = 'create_user.sql'

    from sql_templates import mysql_create_user as sql
    tofile(f, interpolate_user(dataset, dbuser, dbpass, sql))

