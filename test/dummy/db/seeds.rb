include Buttafly

tribes = [

  "Romanian",
  "German",
  "Indian"
]

children = [
  "Ella Mac Pacurar",
  "Rohan Schoeneman"
]

parents = [
  "Guy Pacurarar",
  "Sarah Schoeneman",
  "Doug Schoeneman",
  "Archana Shekhar"
]

grandparents = [
  "Heather Schoeneman",
  "Kurt Schoeneman",
  "Vicki Pacurar",
  "KC Shekhar",
  "Usha Shekhar"
]

tribes.each do |tribe_name|
  DummyTribe.create(name: tribe_name)
end

grandparents.each do |grandparent_name|
  grandparent = DummyGrandparent.create(
    dummy_tribe_id: DummyTribe.pluck(:id).sample,
    name: grandparent_name
  )
end

parents.each do |parent_name|

  parent = DummyParent.create(
    dummy_tribe_id: DummyTribe.pluck(:id).sample,
    dummy_grandparent_id: DummyGrandparent.pluck(:id).sample,
    name: parent_name
  )
end

children.each do |child_name|
  child = DummyChild.create(
    dummy_tribe_id: DummyTribe.pluck(:id).sample,
    dummy_parent_id: DummyParent.pluck(:id).sample,
    name: child_name
  )
end

User.create(
  name: "Fred"
)

sample_sheets = Dir[File.expand_path('test/samples/*')]

sample_sheets.each_with_index do |sheet, n|
  flat_file = File.open(sheet)
  Buttafly::Spreadsheet.create!(
    # user_id: User.pluck(:id).sample,
    name: "cool_file_name-#{n}",
    flat_file: flat_file
  )

end


# spreadsheets.each do |spreadsheet_name|
#   flat_file = File.open(File.join(Rails.root, 'test', 'samples', 'family.odt.csv'))
#   Buttafly::Spreadsheet.create(
#     user_id: User.pluck(:id).sample,
#     name: spreadsheet_name,
#     flat_file: flat_file
#   )
# end