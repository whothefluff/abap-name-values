"! <p class="shorttext synchronized" lang="EN">Name-value pairs</p>
interface zif_name_value_pairs public.

  types: begin of t_entry,
           name type string,
           value type string,
         end of t_entry,
         t_data type sorted table of zif_name_value_pairs=>t_entry with unique key name
                                                                   with non-unique sorted key by_val components value.

  "! <p class="shorttext synchronized" lang="EN">Returns the data as is</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Raw data</p>
  methods data
            returning
              value(r_val) type zif_name_value_pairs=>t_data.

  "! <p class="shorttext synchronized" lang="EN">Returns a select-options based on equalities</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Select-options</p>
  methods as_select_options
            returning
              value(r_val) type rsds_frange_t.

  "! <p class="shorttext synchronized" lang="EN">Returns an SQL where clause based on equalities</p>
  "!
  "! @parameter r_val | <p class="shorttext synchronized" lang="EN">SQL where</p>
  methods as_sql_where
            returning
              value(r_val) type string.


endinterface.
