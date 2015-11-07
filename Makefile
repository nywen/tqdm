# IMPORTANT: for compatibility with `python setup.py make [alias]`, ensure:
# 1. A line return after every alias
# 2. One command per line
# E.g.:
#    ```
#    all:
#    	@make test
#    	@make install
#    test:
#    	nosetest
#    install:
#    	python setup.py install
#    ```

.PHONY:
	alltests
	all
	flake8
	test
	testnose
	testsetup
	testcoverage
	installdev
	install
	build
	pypimeta
	pypi
	none

alltests:
	@make testcoverage
	@make flake8
	@make testsetup

all:
	@make alltests
	@make build

flake8:
	flake8 --max-line-length=80 --count --statistics --exit-zero tqdm/
	flake8 --max-line-length=80 --count --statistics --exit-zero examples/
	flake8 --max-line-length=80 --count --statistics --exit-zero .

test:
	tox --skip-missing-interpreters

testnose:
	nosetests tqdm -v

testsetup:
	python setup.py check --restructuredtext --strict
	python setup.py make none

testcoverage:
	rm -f .coverage  # coverage erase
	nosetests tqdm --with-coverage --cover-package=tqdm -v

installdev:
	python setup.py develop --uninstall
	python setup.py develop

install:
	python setup.py install

build:
	python setup.py sdist --formats=gztar,zip bdist_wininst
	python setup.py sdist bdist_wheel

pypimeta:
	python setup.py register

pypi:
	twine upload dist/*

none:
	# used for unit testing