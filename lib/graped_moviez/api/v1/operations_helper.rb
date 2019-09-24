require "graped_moviez/models/movie"
require "graped_moviez/models/day"
require "graped_moviez/models/function"
require "graped_moviez/models/reservation"

module GrapedMoviez
  module Api
    module V1
      module OperationsHelper
        def save(object)
          if object.save
            key = object.class.name.split(':').last.downcase
            serialized = if block_given? 
              yield 
            else
              object.values
            end
            { "#{key}": serialized }
          else
            status 520
            { errors: "Could not create a #{key} #{object.errors}"}
          end
        end

        def render_simple(type)
          key = type.to_s
          raise TypeError.new("Is not a valid type") unless type.is_a? Symbol
          klass = Kernel.const_get "GrapedMoviez::Models::#{type.capitalize}"
          objects = klass.all.map(&:values)
          { "#{key}": objects }          
        end
        
        
      end
    end
  end
end
