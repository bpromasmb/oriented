module Oriented
  module Relationship
    class RelType

      attr_reader :direction, :cardinality, :label, :target_class
   
      def initialize(rel_label, source_class, options={})
        @label = rel_label
        @source_class = source_class.odb_class_name
        @direction = options.fetch(:dir, Oriented::Relationships::Direction::OUT) 
        @cardinality = options.fetch(:cardinality, :many)
      end


      def to(*args)
        @direction = Oriented::Relationships::Direction::OUT
        if Class === args[0] 
          @target_class = args[0].odb_class_name
          @label = "#{@source_class}-#{@label}"
        elsif Symbol === args[0]
          @label = args[0].to_s
        end

        self
        
      end

      def from(*args)
        @direction = Oriented::Relationships::Direction::IN 

        if args.size > 1
          @target_class = args[0].odb_class_name
          @label = "#{@source_class}-#{args[1].to_s}"
        elsif Symbol === args[0]
          @label = args[0].to_s
        end
        self
      end

    end
  end
end
