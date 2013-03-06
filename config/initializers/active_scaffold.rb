DEFAULT_NUMBER_OF_LIST_ITEMS = 25

module ActiveScaffold::DataStructures
  class Sorting

  	def add(column_name, direction = nil)
      direction ||= 'ASC'
      direction = direction.to_s.upcase
      column = get_column(column_name)
      raise ArgumentError, "Sorting direction unknown" unless [:ASC, :DESC, :"DESC NULLS LAST", :"ASC NULLS LAST"].include? direction.to_sym
      @clauses << [column, direction.untaint] if column and column.sortable?
      raise ArgumentError, "Can't mix :method- and :sql-based sorting" if mixed_sorting?
    end

    private
    def extract_direction(direction_part)
      val = direction_part.to_s.upcase
      if val == 'DESC'
        'DESC'
      elsif val == 'ASC'
        'ASC'
      else
      	val
      end
    end
  end
end
