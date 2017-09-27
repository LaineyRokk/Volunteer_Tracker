class Project
  attr_reader(:title, :id)

  def initialize(attr)
    @title = attr[:title]
    @id =  attr[:id]
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects")
    projects = []
    returned_projects.each() do |project|
      projects.push(Project.new(:title => project['title'], :id => project ['id'].to_i))
    end
    projects.sort_by {|porject| project.title}
  end

  def save()
      result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
      @id = result.first["id"].to_i()

  def ==(another_project)
    self.id.==(another_project.id) and self.title.==(another_project.title)
  end

  def self.find(id)
    found_project = DB.exec("SELECT * FROM projects WHERE id = #{id}").first
    Project.new({title: found_project['title'], id: found_project['id'].to_i})
  end

  def volunteers
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id =#{self.id};")
    volunteers.each() do |volunteers|
      name = volunteer["name"]
      project_id = volunteer["project_id"].to_i()
      id = volunteer["id"].to_i()
      project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE projects SET title = '#(@title)' WHERE id = #{self.id()};")
  end
