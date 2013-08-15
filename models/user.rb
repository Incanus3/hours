class User < Sequel::Model
  many_to_many :supervizors, {:left_key => :supervizor_id,
    :right_key => :subordinate_id, :join_table => :supervizors, :class => self}
end
