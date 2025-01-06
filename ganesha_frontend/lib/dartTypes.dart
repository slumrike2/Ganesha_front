class Song {
  final int idCancion;
  final String titulo;
  final String urlImg;
  final int duracion;
  final int costePun;

  Song({
    required this.idCancion,
    required this.titulo,
    required this.urlImg,
    required this.duracion,
    required this.costePun,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      idCancion: json['id_cancion'],
      titulo: json['titulo'],
      urlImg: json['url_img'],
      duracion: json['duracion'],
      costePun: json['coste_pun'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cancion': idCancion,
      'titulo': titulo,
      'url_img': urlImg,
      'duracion': duracion,
      'coste_pun': costePun,
    };
  }
}

class Ganesha_User {
  final String idUsuario;
  final String nombre;
  final String apellido;
  final String? contrasena;
  final String? email;
  final int estatura;
  final int peso;
  final int puntaje;
  final String tipoEntrada;
  final String username;

  Ganesha_User({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    this.contrasena,
    this.email,
    required this.estatura,
    required this.peso,
    required this.puntaje,
    required this.tipoEntrada,
    required this.username,
  });

  factory Ganesha_User.fromJson(Map<String, dynamic> json) {
    return Ganesha_User(
      idUsuario: json['id_usuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      contrasena: json['contrasena'],
      email: json['email'],
      estatura: json['estatura'],
      peso: json['peso'],
      puntaje: json['puntaje'],
      tipoEntrada: json['tipo_entrada'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'apellido': apellido,
      'contrasena': contrasena,
      'email': email,
      'estatura': estatura,
      'peso': peso,
      'puntaje': puntaje,
      'tipo_entrada': tipoEntrada,
      'username': username,
    };
  }
}

class Configuracion {
  final int idConfiguracion;
  final String idUsuario;
  final String idioma;
  final String notificaciones;
  final String paleta;
  final String tema;

  Configuracion({
    required this.idConfiguracion,
    required this.idUsuario,
    required this.idioma,
    required this.notificaciones,
    required this.paleta,
    required this.tema,
  });

  factory Configuracion.fromJson(Map<String, dynamic> json) {
    return Configuracion(
      idConfiguracion: json['id_configuracion'],
      idUsuario: json['id_usuario'],
      idioma: json['idioma'],
      notificaciones: json['notificaciones'],
      paleta: json['paleta'],
      tema: json['tema'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_configuracion': idConfiguracion,
      'id_usuario': idUsuario,
      'idioma': idioma,
      'notificaciones': notificaciones,
      'paleta': paleta,
      'tema': tema,
    };
  }
}

class Diagnostico {
  final int idDiagnostico;
  final String descripcion;
  final String nombre;

  Diagnostico({
    required this.idDiagnostico,
    required this.descripcion,
    required this.nombre,
  });

  factory Diagnostico.fromJson(Map<String, dynamic> json) {
    return Diagnostico(
      idDiagnostico: json['id_diagnostico'],
      descripcion: json['descripcion'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_diagnostico': idDiagnostico,
      'descripcion': descripcion,
      'nombre': nombre,
    };
  }
}

class Ejercicio {
  final int idEjercicio;
  final String mecanica;
  final String nivel;
  final String nombre;

  Ejercicio({
    required this.idEjercicio,
    required this.mecanica,
    required this.nivel,
    required this.nombre,
  });

  factory Ejercicio.fromJson(Map<String, dynamic> json) {
    return Ejercicio(
      idEjercicio: json['id_ejercicio'],
      mecanica: json['mecanica'],
      nivel: json['nivel'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_ejercicio': idEjercicio,
      'mecanica': mecanica,
      'nivel': nivel,
      'nombre': nombre,
    };
  }
}

class Logro {
  final int idLogro;
  final String descripcion;
  final String nombre;

  Logro({
    required this.idLogro,
    required this.descripcion,
    required this.nombre,
  });

  factory Logro.fromJson(Map<String, dynamic> json) {
    return Logro(
      idLogro: json['id_logro'],
      descripcion: json['descripcion'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_logro': idLogro,
      'descripcion': descripcion,
      'nombre': nombre,
    };
  }
}

class Musculo {
  final int idMusculo;
  final String nombre;

  Musculo({
    required this.idMusculo,
    required this.nombre,
  });

  factory Musculo.fromJson(Map<String, dynamic> json) {
    return Musculo(
      idMusculo: json['id_musculo'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_musculo': idMusculo,
      'nombre': nombre,
    };
  }
}

class Rutina {
  final int idRutina;
  final String frecuencia;

  Rutina({
    required this.idRutina,
    required this.frecuencia,
  });

  factory Rutina.fromJson(Map<String, dynamic> json) {
    return Rutina(
      idRutina: json['id_rutina'],
      frecuencia: json['frecuencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rutina': idRutina,
      'frecuencia': frecuencia,
    };
  }
}

class Sintoma {
  final int idSintoma;
  final String descripcion;
  final String nombre;

  Sintoma({
    required this.idSintoma,
    required this.descripcion,
    required this.nombre,
  });

  factory Sintoma.fromJson(Map<String, dynamic> json) {
    return Sintoma(
      idSintoma: json['id_sintoma'],
      descripcion: json['descripcion'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sintoma': idSintoma,
      'descripcion': descripcion,
      'nombre': nombre,
    };
  }
}

class Equipamiento {
  final int idEquipamiento;
  final String nombre;

  Equipamiento({
    required this.idEquipamiento,
    required this.nombre,
  });

  factory Equipamiento.fromJson(Map<String, dynamic> json) {
    return Equipamiento(
      idEquipamiento: json['id_equipamiento'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_equipamiento': idEquipamiento,
      'nombre': nombre,
    };
  }
}
