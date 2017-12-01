#Makefile to test STAN models

R_TESTS = $(wildcard tests/testthat/*.R)

readme: ./README.Rmd
	R -e "rmarkdown::render('$(<F)')"

test:
	R -e 'testthat::test_dir("tests/testthat")'
