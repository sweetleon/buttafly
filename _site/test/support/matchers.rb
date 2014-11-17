module TestMatchers

  def must_have_column(column, type=nil)
    subject.column_names.must_include column.to_s
    if type.nil?
      subject.columns_hash[column.to_s].type.must_equal :string
    else 
      subject.columns_hash[column.to_s].type.must_equal type
    end
  end

  def wont_have_column(column, type)
    subject.columns_hash[column.to_s].type.wont_equal type
  end

  def must_have_index(index)
    connection = ActiveRecord::Base.connection
    indexes = connection.indexes(subject.table_name).collect(&:columns)
    if index.class == Symbol
      indexes.must_include [index.to_s]
    else
      indexes.must_include(index.map &:to_s)
    end
  end

  def must_have_multiple_index(index)
    connection = ActiveRecord::Base.connection
    connection.indexes(subject.table_name)
      .collect(&:columns.to_sym)
      .must_include(index.map &:to_s)
  end

  def wont_have_index(index)
    connection = ActiveRecord::Base.connection
    connection.indexes(subject).collect(&:columns).wont_include([index])
  end

  def must_belong_to(parent_model)
    subject.reflections[parent_model.to_sym].macro.must_equal :belongs_to
  end

  def must_have_one(model)
    subject.reflections[model.to_sym].macro.must_equal :has_one
  end

  def wont_belong_to(parent_model)
    subject.reflections[parent_model.to_sym].macro.wont_equal :belongs_to
  end

  def must_have_many(child_model)
    subject.reflections[child_model].macro.must_equal :has_many
  end

  def wont_have_many(model)
    subject.reflections[child_model].macro.wont_equal :has_many
  end
end