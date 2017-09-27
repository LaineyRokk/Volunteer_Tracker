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
      volunteers.push(volunteers.new(:title => volunteers['title'], :id => volunteers ['id'].to_i))
    end
    volunteers.sort_by {|volunteers| volunteers.title}
  end

  def save()
      result = DB.exec("INSERT INTO volunteers (title) VALUES ('#{@title}') RETURNING id;")
      @id = result.first["id"].to_i()

  def ==(another_volunteers)
    self.id.==(another_volunteers.id) and self.title.==(another_volunteers.title)
  end
