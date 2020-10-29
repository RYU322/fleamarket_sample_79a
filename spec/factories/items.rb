FactoryBot.define do
  factory :item do
    name                {"ハンチョウ全巻"}
    introduction        {"漫画『ハンチョウ』全巻です"}
    category            { 5 }
    item_condition      { 2 }
    postage_payer       { 2 }
    prefecture          { 1 }
    preparation_period  { 1 }
    price               { 5000 }
    after(:build) do |item|
      item.images << build(:image, item: item)
    end
  end
end