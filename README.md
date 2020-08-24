read\_HZGdat
================
David Kaiser
08 Aug 2020

Description
-----------

This function reads data downloaded from HZG database as .dat into a data frame. It removes the header, can change the column name of the target data column, and can add the header meta data as new columns. The function was tested to work for downloaded files of this data: FerryBox, Time-Series - LandStation (TSplot), Survey - Ship (TSplot). Files with empty data rows result in a df with the column names and a row indicating missing data in the file.

Arguments
---------

*dat* -- a .dat file

*add.meta* = TRUE -- logical: adds meta data from the header as columns

*plug.parameter.name* = TRUE -- logical: should the col.name of the value column be changed to the actual parameter name with unit? Especially in combination with add.meta=TRUE this may not be necessary.

Result
------

A dataframe containing the data (and header meta data if *add.meta* = TRUE) contained in the .dat file

Examples
--------

*will follow*
