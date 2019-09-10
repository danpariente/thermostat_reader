if Rails.env.development?
  ActiveRecord::Tasks::DatabaseTasks.structure_load_flags = ["-v", "ON_ERROR_STOP=0"]
end
