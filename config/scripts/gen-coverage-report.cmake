# Copyright (c) 2017 Matthew J. Smith and Overkit contributors
# License: MIT (http://opensource.org/licenses/MIT)

execute_process(
  COMMAND perl "${SOURCE_DIR}/tests/coverage-report.pl" .
  WORKING_DIRECTORY "${BINARY_DIR}/tests/coverage"
)
