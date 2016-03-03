module Repository

  def count(all_contents)
    all_contents.count
  end

  def find_by_name(all_contents, query_name)
    all_contents.find do |element|
      element.name.downcase == query_name.downcase
    end
  end

  def find_by_id(all_contents, id_query)
    all_contents.find do |element|
      id_query == element.id
    end
  end

  def find_all_by_string(all_contents, query_name, query_type)
    all_contents.select do |element|
       element.query_type.downcase.include?(query_name.downcase) ? element : nil
    end
  end

  def find_all_by_num(all_contents, query_num, query_type)
    all_contents.select do |element|
      element.query_type == query_num
    end
  end

end
