Ransack.configure do |config|
  config.add_predicate 'jsoncont', arel_predicate: 'contains', formatter: proc { |v| JSON.parse(v) }
end