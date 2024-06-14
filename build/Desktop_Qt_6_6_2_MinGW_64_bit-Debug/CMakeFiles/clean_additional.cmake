# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\apppicnic-tower-defense_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\apppicnic-tower-defense_autogen.dir\\ParseCache.txt"
  "apppicnic-tower-defense_autogen"
  )
endif()
