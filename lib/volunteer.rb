class Volunteer
  attr_reader(:name, :id, :project_id)

  def  initialize(attr)
    @name = attr[:name]
    @id = attr[:id]
    @project_id = attr[:project_id]
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each() do |volunteers|
      volunteers.push(Volunteer.new(:name => volunteer['name'], :id => volunteer['id'].to_i, :project_id => volunteer['project_id'].to_i))
    end
    volunteers.sort_by {|volunteer| volunteer.name}
  end

  def save()
      result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first["id"].to_i()

  def ==(another_volunteer)
    self.id.==(another_volunteer.id) and self.name.==(another_volunteer.name) and self.project_id.==(another_volunteer.project_id)
  end

  def self.find(id)
    found_volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id}").first
    Volunteer.new({:name => found_volunteer['name'], :id => found_volunteer['id'].to_i, :project_id => found_volunteer['project_id'].to_i})
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE volunteers SET name = '#(@name)' WHERE id = #{self.id()};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
