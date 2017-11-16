module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver
    def professionals_data_parser(request)
      { 'speciality' => request['especialidad'],
        'registration_number' => request['numero_registro'],
        'registration_date' => request['fecha_registro'],
        'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => request['nombre'],
        'last_name' => request['apellido'],
        'age' => request['edad'],
        'nationality' => request['nacionalidad'],
        'phone' => request['telefono'] }
    end

    def professionals_key_converter(request)
      params = %w[especialidad numero_registro fecha_registro run nombre
                  apellido edad nacionalidad telefono]
      return {}.to_json unless check_request(request, params)
      professionals_data_parser(request).to_json()
    end

    def parse_patients(request)
      return {}.to_json unless check_request(request, %w[nombre run edad])
      nombre = request['nombre'].split(' ', 2)
      { 'rut' => request['run'][0..-2] + '-' + request['run'][-1],
        'name' => nombre[0],
        'last_name' => nombre[1],
        'age' => request['edad'] }.to_json
    end

    def parse_professionals(request)
      request.merge(key_converter(request)).slice!(
        :especialidad, :numero_registro,
        :fecha_registro, :run, :nombre,
        :apellido, :edad, :nacionalidad,
        :telefono).to_json
    end

    def parse_consults(request)
      keys = %w[runPaciente runProfesional fecha razon sintoma observaciones]
      return {}.to_json unless check_request(request  , keys)
      { 'patient_rut' => request['runPaciente'][0..-2] + '-' +
        request['runPaciente'][-1],
        'professional_rut' => request['runProfesional'][0..-2] + '-' +
          request['runProfesional'][-1],
        'date' => request['fecha'],
        'reason' => request['razon'],
        'symptoms' => request['sintoma'],
        'observations' => request['observaciones']}.to_json
    end

    def parse_movements(request)
      keys = %w[tipo runPaciente runProfesional detalles]
      return {}.to_json unless check_request(request, keys)
      { 'type' => request['tipo'],
        'patient_rut' => request['runPaciente'][0..-2] + '-' +
          request['runPaciente'][-1],
        'professional_rut' => request['runProfesional'][0..-2] + '-' +
          request['runProfesional'][-1],
        'detail' => request['detalles']}.to_json
    end
    
    def parse_exam(request)
      return {}.to_json unless check_request()
    end
  end
end
