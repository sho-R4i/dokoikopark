json.data do
  json.parks do
    json.array!(@parks) do |park|
      json.id park.id
      json.park_name park.park_name
      json.address park.address
      json.latitude park.latitude
      json.longitude park.longitude
    end  
  end
end