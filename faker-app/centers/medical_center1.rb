require 'faker'
require 'json'

class MedicalCenter1

  def self.patient
    data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:edad] = rand(0..110)
    data
  end

  def self.professional
  	data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:apellido] = Faker::Name.last_name 
    data[:edad] = rand(0..110)
    data[:nacionalidad] = Faker::Demographic.demonym
    data[:job_title] = Faker::Job.title
    data[:grant_date] = Faker::Date.backward
    data[:granting_entity] = Faker::University.name
   
    data[:numero_registro] = Faker::Number.number(9)
    data[:fecha_registro]= Faker::Date.backward
    data[:especialidad] = Faker::Company.name #<-- como es una referencia de la tabla especialidad... no se que colocar
    data[:freelance] = Faker::Boolean.boolean
    data[:telefono] = Faker::Number.number(9)
    data[:email]= Faker::Internet.email(data[:nombre])
    
    data 
  end

  def self.consult
  	data = {}
  	cont = 0
  	@line = nil
  	random = Random.rand(2)
  	professionalsdata = File.open('professionals.json','r')
  	professionalsdata.each_line do |infile|
  		while (cont == random)
  			@line = infile
  			break
  		end
  		cont = cont + 1
  	end
  	data_hash_professional = JSON.parse(@line)
  	data[:runProfesional] = data_hash_professional['run']
 	  cont = 0
  	patientsdata = File.open('patients.json','r')
  	patientsdata.each_line do |infile|
  		while (cont == random)
  			@line = infile
  			break
  		end
  		cont = cont + 1
  	end
  	data_hash_patient = JSON.parse(@line)
    data[:runPaciente] = data_hash_patient['run']
    data[:fecha] = Faker::Date.backward
    data[:razon] = Faker::Company.name
    data[:sintoma] = Faker::Company.name
    data[:observaciones] = Faker::Company.name
    data
  end	
  def self.movement
    data = {}
    data[:tipo] = rand(0..6)   
    #data[:ID_consulta] = rand(0..6)
    data
  end


end