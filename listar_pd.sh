#!/bin/bash


find -mindepth 1 -name "*_ampliref_*" ! -name "*_sol_*" -o -name "*_adapt_*" ! -name "*_sol_*" | sort

find -mindepth 1 -name "*_pd_u*" | sort

find -mindepth 1 ! -name "*_ampliref_*" ! -name "*_adapt_*" ! -name "*_pd_u*" ! -name "*_pd_prel*" ! -name "*prelim*" ! -name "*.sh" | sort

find -mindepth 1 -name "*_sol_*" -a -name "*_adapt_*" | sort 
find -mindepth 1 -name "*_ampliref_*" -a -name "*_sol_*" | sort