class Song {
  final int idCancion;
  final String titulo;
  final String? urlImg;
  final int duracion;
  final int costePun;
  bool unloock;

  Song({
    required this.idCancion,
    required this.titulo,
    this.urlImg,
    required this.duracion,
    required this.costePun,
    this.unloock = false,
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

class EjercicioAsignadoUsuario {
  final bool? done;
  final int idEjercicio;
  final String idUsuario;
  final int? prioridad;

  EjercicioAsignadoUsuario({
    this.done,
    required this.idEjercicio,
    required this.idUsuario,
    this.prioridad,
  });

  factory EjercicioAsignadoUsuario.fromJson(Map<String, dynamic> json) {
    return EjercicioAsignadoUsuario(
      done: json['done'],
      idEjercicio: json['id_ejercicio'],
      idUsuario: json['id_usuario'],
      prioridad: json['prioridad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'done': done,
      'id_ejercicio': idEjercicio,
      'id_usuario': idUsuario,
      'prioridad': prioridad,
    };
  }
}

class GaneshaUser {
  final String idUsuario;
  final String nombre;
  final String apellido;
  final String username;
  final String puntaje;
  final int ejerciciosCompletados;

  GaneshaUser({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.puntaje,
    required this.ejerciciosCompletados,
  });

  factory GaneshaUser.fromJson(Map<String, dynamic> json) {
    return GaneshaUser(
      idUsuario: json['id_usuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      username: json['username'],
      puntaje: json['puntaje'],
      ejerciciosCompletados: json['ejercicios_completados'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'nombre': nombre,
      'apellido': apellido,
      'username': username,
      'puntaje': puntaje,
      'ejercicios_completados': ejerciciosCompletados,
    };
  }
}

class Configuracion {
  final String idConfiguracion;
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
  final String descripcion;
  final String nombre;
  final int prioridad;

  Ejercicio({
    required this.idEjercicio,
    required this.descripcion,
    required this.nombre,
    required this.prioridad,
  });

  factory Ejercicio.fromJson(Map<String, dynamic> json) {
    return Ejercicio(
      idEjercicio: json['idEjercicio'],
      descripcion: json['descripcion'],
      nombre: json['nombre'],
      prioridad: json['prioridad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_ejercicio': idEjercicio,
      'descripcion': descripcion,
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
  final String pregunta;
  final String tipo;

  Sintoma({
    required this.idSintoma,
    required this.descripcion,
    required this.nombre,
    required this.pregunta,
    required this.tipo,
  });

  factory Sintoma.fromJson(Map<String, dynamic> json) {
    return Sintoma(
      idSintoma: json['id_sintoma'],
      descripcion: json['descripcion'],
      nombre: json['nombre'],
      pregunta: json['pregunta'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sintoma': idSintoma,
      'descripcion': descripcion,
      'nombre': nombre,
      'pregunta': pregunta,
      'tipo': tipo,
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
