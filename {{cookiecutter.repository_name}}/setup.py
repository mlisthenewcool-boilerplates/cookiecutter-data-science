from setuptools import find_packages, setup
from datetime import date

setup(
    name='src',
    packages=find_packages(),
    version=date.today().strftime("%Y-%m-%d"),
    description='{{ cookiecutter.description }}',
    author='{{ cookiecutter.author_name }}',
    license='{% if cookiecutter.license == 'MIT' %}MIT{% endif %}',
)
