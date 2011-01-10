namespace :fluttr do

  desc "Convert all old style tasks to new style"
  task :convert => :environment do

    # Create a new list for each item
    Task.select("DISTINCT name").each do |t|
      List.create({:name => t.name})
    end

    # Update all the task id's
    List.all.each do |list|
      Task.where("name = ?", list.name).each do |task|
        task.update_attribute :list_id, list.id
      end
    end

  end
end
