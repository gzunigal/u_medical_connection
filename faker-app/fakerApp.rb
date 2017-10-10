
require 'faker'
require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
n = 0
File.open("example.json","w") do |f|
while n < 100
  


  number = rand(3)
  name = Faker::Name.name
  addres = Faker::Address.city
  number_cellphone = Faker::PhoneNumber.cell_phone
  job = Faker::Job.title
  sick = Faker::Boolean.boolean
  isapre = Faker::Company.name
  exam_date = Faker::Date.forward(23)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  if number == 1
    my_hash = { name: name, Address: addres, cellphone: number_cellphone, job: job, exam_date: exam_date }
    my_hash = JSON.generate(my_hash)
    f.puts(my_hash)
    f.puts
    puts my_hash
  
  elsif number == 2
    my_hash = { name: name, Address: addres, cellphone: number_cellphone, job: job, isapre: isapre, sick: sick }
    my_hash = JSON.generate(my_hash)
    puts my_hash
    f.puts(my_hash)
    f.puts
    
  else
    my_hash = { first_name: first_name, last_name: last_name, Address: addres, cellphone: number_cellphone, job: job, isapre: isapre, sick: sick }
    my_hash = JSON.generate(my_hash)
    puts my_hash
    f.puts(my_hash)
    f.puts
  end

  n += 1

   File.open("temp.json","a") do |f|
     f.puts(my_hash)
     f.puts
   end
   header = {'Content-Type': 'text/json'}
   uri = URI.parse("http://localhost:3000/api/v1/")
   http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri)
  request.body = my_hash
  response = http.request(request)
end
end
