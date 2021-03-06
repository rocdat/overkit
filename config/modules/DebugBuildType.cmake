# Copyright (c) 2017 Matthew J. Smith and Overkit contributors
# License: MIT (http://opensource.org/licenses/MIT)

if(NOT DEFINED C_ENABLED)
  message(FATAL_ERROR "Must set C_ENABLED for DebugBuildType")
endif()
if(NOT DEFINED CXX_ENABLED)
  message(FATAL_ERROR "Must set CXX_ENABLED for DebugBuildType")
endif()
if(NOT DEFINED Fortran_ENABLED)
  message(FATAL_ERROR "Must set Fortran_ENABLED for DebugBuildType")
endif()
if(FORTRAN_ENABLED AND NOT DEFINED CMAKE_Fortran_CHECK_FLAG)
  message(FATAL_ERROR "Must set CMAKE_Fortran_CHECK_FLAG for DebugBuildType")
endif()

if(${CMAKE_Fortran_COMPILER_ID} MATCHES "GNU")

  if(C_ENABLED)
    set(CMAKE_C_DIALECT "-std=c99")
    set(CMAKE_C_WARNINGS "-Wall")
    set(CMAKE_C_RUNTIME_CHECKS "")
  endif()

  if(CXX_ENABLED)
    set(CMAKE_CXX_DIALECT "-std=c++03")
    set(CMAKE_CXX_WARNINGS "-Wall")
    set(CMAKE_CXX_RUNTIME_CHECKS "")
  endif()

  if(Fortran_ENABLED)
    set(CMAKE_Fortran_DIALECT "-std=gnu -ffree-line-length-0")
    set(CMAKE_Fortran_WARNINGS "-Wall -Wno-unused-dummy-argument")
    # Check for -fcheck support
    if(CMAKE_Fortran_CHECK_FLAG)
      unset(SUPPORTS_FCHECK CACHE)
      CHECK_Fortran_COMPILER_FLAG(-fcheck=all SUPPORTS_FCHECK)
    else()
      set(SUPPORTS_FCHECK FALSE CACHE INTERNAL "")
    endif()
    if(SUPPORTS_FCHECK)
      set(CMAKE_Fortran_RUNTIME_CHECKS "-fcheck=all")
    else()
      set(CMAKE_Fortran_RUNTIME_CHECKS "-fbounds-check -fcheck-array-temporaries")
    endif()
    set(CMAKE_Fortran_RUNTIME_CHECKS "${CMAKE_Fortran_RUNTIME_CHECKS} -fbacktrace -finit-integer=-123456789 -finit-real=nan -ffpe-trap=invalid,zero,overflow,underflow")
  endif()

elseif(${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel")

  if(C_ENABLED)
    set(CMAKE_C_DIALECT "")
    set(CMAKE_C_WARNINGS "")
    set(CMAKE_C_RUNTIME_CHECKS "")
  endif()
  if(CXX_ENABLED)
    set(CMAKE_CXX_DIALECT "")
    set(CMAKE_CXX_WARNINGS "")
    set(CMAKE_CXX_RUNTIME_CHECKS "")
  endif()
  if(Fortran_ENABLED)
    set(CMAKE_Fortran_DIALECT "")
    set(CMAKE_Fortran_WARNINGS "-warn all -debug extended")
    set(CMAKE_Fortran_RUNTIME_CHECKS "-check all -ftrapuv -fp-stack-check -fpe0 -traceback")
  endif()

else()

  if(C_ENABLED)
    set(CMAKE_C_DIALECT "")
    set(CMAKE_C_WARNINGS "")
    set(CMAKE_C_RUNTIME_CHECKS "")
  endif()

  if(CXX_ENABLED)
    set(CMAKE_CXX_DIALECT "")
    set(CMAKE_CXX_WARNINGS "")
    set(CMAKE_CXX_RUNTIME_CHECKS "")
  endif()

  if(Fortran_ENABLED)
    set(CMAKE_Fortran_DIALECT "")
    set(CMAKE_Fortran_WARNINGS "")
    set(CMAKE_Fortran_RUNTIME_CHECKS "")
  endif()

endif()

if(C_ENABLED)
  set(CMAKE_C_FLAGS_DEBUG_EXTRA "-O0 ${CMAKE_C_DIALECT} ${CMAKE_C_WARNINGS} ${CMAKE_C_RUNTIME_CHECKS}")
endif()
if(CXX_ENABLED)
  set(CMAKE_CXX_FLAGS_DEBUG_EXTRA "-O0 ${CMAKE_CXX_DIALECT} ${CMAKE_CXX_WARNINGS} ${CMAKE_CXX_RUNTIME_CHECKS}")
endif()
if(Fortran_ENABLED)
  set(CMAKE_Fortran_FLAGS_DEBUG_EXTRA "-O0 ${CMAKE_Fortran_DIALECT} ${CMAKE_Fortran_WARNINGS} ${CMAKE_Fortran_RUNTIME_CHECKS}")
endif()

if(NOT DEFINED DEBUGBUILDTYPE)
  if(C_ENABLED)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${CMAKE_C_FLAGS_DEBUG_EXTRA}"
      CACHE STRING "Flags used by the C compiler during debug builds." FORCE)
  endif()
  if(CXX_ENABLED)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${CMAKE_CXX_FLAGS_DEBUG_EXTRA}"
      CACHE STRING "Flags used by the C++ compiler during debug builds." FORCE)
  endif()
  if(Fortran_ENABLED)
    set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${CMAKE_Fortran_FLAGS_DEBUG_EXTRA}"
      CACHE STRING "Flags used by the Fortran compiler during debug builds." FORCE)
  endif()
  set(DEBUGBUILDTYPE TRUE CACHE INTERNAL "")
endif()
