widget :users do
  key "8c2f3348656213da127da80376540291c627151d"
  type "number_and_secondary"
  data do
    {
      :value => User.count,
      :previous => User.count(:conditions => "created_at < '#{1.month.ago.to_s(:db)}'")
    }
  end
end
