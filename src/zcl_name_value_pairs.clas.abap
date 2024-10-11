"! <p class="shorttext synchronized" lang="EN">Name-value pairs</p>
class zcl_name_value_pairs definition
                           public
                           create public.

  public section.

    interfaces: zif_name_value_pairs.

    aliases: data for zif_name_value_pairs~data,
             as_select_options for zif_name_value_pairs~as_select_options,
             as_sql_where for zif_name_value_pairs~as_sql_where.

    "! <p class="shorttext synchronized" lang="EN">Creates a new pair list</p>
    "!
    "! @parameter i_data | <p class="shorttext synchronized" lang="EN">Data</p>
    methods constructor
              importing
                i_data type zif_name_value_pairs=>t_data.

  protected section.

    data a_data_tab type zif_name_value_pairs=>t_data.

endclass.
class zcl_name_value_pairs implementation.

  method constructor.

    me->a_data_tab = i_data.

  endmethod.
  method zif_name_value_pairs~data.

    r_val = me->a_data_tab.

  endmethod.
  method zif_name_value_pairs~as_select_options.

    r_val = value #( let aux = me->data( ) in
                     for groups of <by_name> in aux group by <by_name>-name
                     ( fieldname = <by_name>-name
                       selopt_t = value #( for <segment> in group <by_name>
                                           sign = 'I'
                                           option = 'EQ'
                                           ( low = <segment>-value ) ) ) ).

  endmethod.
  method zif_name_value_pairs~as_sql_where.

    data(ranges) = value rsds_trange( ( tablename = value #( )
                                        frange_t = me->as_select_options( ) ) ).

    data(where) = value rsds_twhere( ).

    call function 'FREE_SELECTIONS_RANGE_2_WHERE'
      exporting
        field_ranges  = ranges
      importing
        where_clauses = where.

    r_val = condense( concat_lines_of( table = value #( where[ 1 ]-where_tab optional )
                                       sep = ` ` ) ).

  endmethod.

endclass.
