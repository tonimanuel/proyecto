-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: tiendaonline
-- ------------------------------------------------------
-- Server version	5.7.24

DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario (
  idUsuario int(11) NOT NULL AUTO_INCREMENT,
  Usuario varchar(20) COLLATE utf8_bin NOT NULL COMMENT 'El usuario debe ser único en la Base de Datos. Además debe tener una longitud mínima de 6 caracteres.',
  Password varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'La contraseña no puede ser nula.\nTiene que tener una longitud mínima de 8 caracteres, contener números y algún carácter especial de la siguiente lista (!,@,#,$,%,&,?,¿,*,€)',
  Nombre varchar(45) COLLATE utf8_bin NOT NULL,
  Apellido1 varchar(45) COLLATE utf8_bin NOT NULL,
  Apellido2 varchar(45) COLLATE utf8_bin DEFAULT NULL,
  Telefono varchar(10) COLLATE utf8_bin NOT NULL COMMENT 'Se comprobará que solo puedan ser teléfonos nacionales',
  Email varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'Se comprobará que es un email válido',
  CP varchar(5) COLLATE utf8_bin NOT NULL,
  Provincia varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'Se comprobará que la provincia introducida concuerda con el CP introducido',
  ComunidadAutonoma varchar(45) COLLATE utf8_bin NOT NULL COMMENT 'Se comprobará que la provincia seleccionada pertenece a la comunidad autónoma correspondiente',
  Rol varchar(45) COLLATE utf8_bin NOT NULL,
  Dni varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (idUsuario),
  UNIQUE KEY idUsuario_UNIQUE (idUsuario),
  UNIQUE KEY Usuario_UNIQUE (Usuario)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS videojuego;

CREATE TABLE videojuego (
  idVideojuego int(11) NOT NULL AUTO_INCREMENT,
  Titulo varchar(45)  NOT NULL,
  Compania varchar(45)  NOT NULL,
  Publicacion date NOT NULL,
  Descripcion longtext  NOT NULL,
  Imagen varchar(2050)  DEFAULT NULL COMMENT 'Url de la imagen de la carátula del juego',
  PRIMARY KEY (idVideojuego)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS plataforma;

CREATE TABLE plataforma (
  idPlataforma int(11) NOT NULL AUTO_INCREMENT,
  Nombre varchar(45) COLLATE utf8_bin NOT NULL,
  Lanzamiento date NOT NULL,
  Precio float NOT NULL,
  Stock int(11) NOT NULL,
  Descripcion longtext COLLATE utf8_bin NOT NULL,
  Imagen varchar(2050) COLLATE utf8_bin DEFAULT NULL COMMENT 'Imagen de la plataforma',
  Logo varchar(2050) COLLATE utf8_bin NOT NULL COMMENT 'Logo de la consola',
  PRIMARY KEY (idPlataforma),
  UNIQUE KEY Nombre_UNIQUE (Nombre)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS cesta;

CREATE TABLE cesta (
  idCesta int(11) NOT NULL,
  PrecioTotal decimal(10,0) NOT NULL,
  idCliente int(11) NOT NULL,
  PRIMARY KEY (idCesta),
  KEY Cesta (idCliente),
  CONSTRAINT Cesta FOREIGN KEY (idCliente) REFERENCES usuario (idUsuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE productos (
  idProductos int(11) NOT NULL AUTO_INCREMENT,
  IdVideojuego int(11) NOT NULL,
  IdPlataforma int(11) NOT NULL,
  Stock int(11) NOT NULL,
  Precio varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (idProductos,IdVideojuego,IdPlataforma),
  KEY Es_un_videojuego_idx (IdVideojuego),
  KEY De_la_plataforma_idx (IdPlataforma),
  CONSTRAINT FK_Es_un_Videojuego FOREIGN KEY (IdVideojuego) REFERENCES videojuego (idVideojuego),
  CONSTRAINT FK_Pertenece_a_la_Plataforma FOREIGN KEY (IdPlataforma) REFERENCES plataforma (idPlataforma)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS item;

CREATE TABLE item (
  idItem int(11) NOT NULL,
  Cantidad int(11) NOT NULL,
  PrecioItem decimal(10,0) NOT NULL,
  idCesta int(11) NOT NULL,
  PRIMARY KEY (idItem),
  KEY ItemPerteneceACesta (idCesta),
  CONSTRAINT ItemPerteneceACesta FOREIGN KEY (idCesta) REFERENCES cesta (idCesta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO usuario (Usuario,Password,Nombre,Apellido1,Apellido2,Telefono,Email,CP,Provincia,ComunidadAutonoma,Rol,Dni) values("Administrador","1@2Baaaa","Admin","Admin","Admin","666666666","admin@gmail.com","52005","Melilla","Melilla","admin", "45314595K");

INSERT INTO productos VALUES (1,1,1,24,'85.90'),(2,1,7,14,'45.90'),(3,2,1,12,'85.90'),(4,2,7,8,'45.90'),(5,3,6,15,'59.90'),(6,3,8,23,'59.90'),(7,4,2,55,'59.90'),(8,5,5,23,'45.90'),(9,6,4,12,'39.90'),(10,7,3,200,'79.90'),(11,8,9,1,'45.90'),(13,10,10,125,'69.90'),(14,11,11,0,'200'),(15,11,7,23,'45.90'),(16,11,8,12,'35.90'),(32,2,2,10,'13'),(33,2,3,20,'20'),(34,28,7,10,'60');

INSERT INTO videojuego VALUES (1,'The Legend of Zelda: Ocarina of Time','The Legend of Zelda: Ocarina of Time','1998-11-28',' El remake del clásico de Nintendo 64 lanzado en el año 2000, continuación del videojuego The Legend of Zelda: Ocarina of Time, que la comunidad de jugadores estaba esperando.','zelda ocarina of time.jpg'),(2,'The Legend of Zelda: Majoras Mask','Nintendo','2000-04-27','The Legend of Zelda: Ocarina of Time 3D lleva al clásico para Nintendo 64 (uno de los videojuegos más alabados por la crítica de todos los tiempos) a la consola Nintendo 3DS y le añade la profundidad y el realismo de unos impresionantes gráficos 3D sin gafas. Link se embarca en un periplo de leyenda a través del tiempo para detener a Ganondorf, el rey de los ladrones Gerudo, que busca la Triforce: una reliquia sagrada que otorga poder ilimitado a su poseedor.','zelda majoras mask.jpg'),(3,'The Legend of Zelda: The wind waker','Nintendo','2017-03-04','Abre los ojos. Despierta, Link Cinco años después de la última entrega original para sobremesa, el futuro de la serie The Legend of Zelda llega a Nintendo Switch y Wii U replanteando por completo las bases de la saga. Producido por Eiji Aonuma, The Legend of Zelda: Breath of the Wild te sumergirá en un mundo de descubrimiento con un impresionante estilo artístico similar a The Wind Waker o Skyward Sword, una cautivadora banda sonora y una intrigante y melancólica historia. Despierta tras un siglo de letargo, adéntrate en el Hyrule más amplio y abierto jamás creado por las tres grandes Diosas y forja tu propio camino con el orden y aventuras que quieras. La historia de la familia real de Hyrule es también la historia del cataclismo. Y la historia del cataclismo siempre ha sido la de Ganon. Descubre el enigmático pasado de esta asolada tierra, un mundo entero repleto de aventuras que espera ser explorado, y viaja como Link por bastos campos, espesos bosques y cumbres nevadas bajo el cielo abierto de Hyrule para revelar cómo la oscuridad se impuso sobre la luz. Características: Olvida todas las convenciones de The Legend of Zelda y adéntrate en un enorme y abierto Hyrule, lucha contra temibles enemigos, caza feroces bestias y recolecta ingredientes para preparar comidas y elixires con los que subsistir. Resuelve los puzles que albergan los más de cien santuarios diferentes, ábrete camino entre sus trampas y consigue objetos especiales e ítems que te serán de ayuda en tu recorrido. Prepárate a conciencia y aprovecha las cualidades de variados atuendos  equipamiento para adaptarte al clima o aprovechar efectos especiales como ser más rápido o más sigiloso. Pon a prueba tu capacidad estratégica utilizando a tu favor el entorno y elaborando las estrategias adecuadas con las que acabar con enemigos de todas las formas y tamaños. Como es peligroso ir solo… ¡Lleva un amiibo! The Legend of Zelda: Breath of the Wild es compatible con figuras amiibo de la serie que te otorgarán recompensas en forma de cofres o, con la figura Link Lobo de Twilight Princess, recibe la asistencia del temible animal para luchar contra enemigos o encontrar más fácilmente objetos. The Legend of Zelda es una serie de videojuegos de acción-aventura creada por los diseñadores japoneses Shigeru Miyamoto y Takashi Tezuka,? y desarrollada por Nintendo, empresa que también se encarga de su distribución internacional. Su trama por lo general describe las heroicas aventuras del joven guerrero Link, que debe enfrentarse a peligros y resolver acertijos para ayudar a la Princesa Zelda a derrotar a Ganondorf y salvar su hogar, el reino de Hyrule. Entra en un mundo de aventura Olvida todo lo que sabes sobre los juegos de The Legend of Zelda. Entra en un mundo de descubrimientos, exploración y aventura en The Legend of Zelda: Breath of the Wild, un nuevo juego de la aclamada serie que rompe con las convenciones. Viaja por praderas, bosques y cumbres montañosas para descubrir qué ha sido del asolado reino de Hyrule en esta maravillosa aventura a cielo abierto.','zelda the wind waker.jpg'),(4,'The Legend of Zelda: Breath of the Wild','Nintendo','2017-03-04','Abre los ojos. Despierta, Link Cinco años después de la última entrega original para sobremesa, el futuro de la serie The Legend of Zelda llega a Nintendo Switch y Wii U replanteando por completo las bases de la saga. Producido por Eiji Aonuma, The Legend of Zelda: Breath of the Wild te sumergirá en un mundo de descubrimiento con un impresionante estilo artístico similar a The Wind Waker o Skyward Sword, una cautivadora banda sonora y una intrigante y melancólica historia. Despierta tras un siglo de letargo, adéntrate en el Hyrule más amplio y abierto jamás creado por las tres grandes Diosas y forja tu propio camino con el orden y aventuras que quieras. La historia de la familia real de Hyrule es también la historia del cataclismo. Y la historia del cataclismo siempre ha sido la de Ganon. Descubre el enigmático pasado de esta asolada tierra, un mundo entero repleto de aventuras que espera ser explorado, y viaja como Link por bastos campos, espesos bosques y cumbres nevadas bajo el cielo abierto de Hyrule para revelar cómo la oscuridad se impuso sobre la luz. Características: Olvida todas las convenciones de The Legend of Zelda y adéntrate en un enorme y abierto Hyrule, lucha contra temibles enemigos, caza feroces bestias y recolecta ingredientes para preparar comidas y elixires con los que subsistir. Resuelve los puzles que albergan los más de cien santuarios diferentes, ábrete camino entre sus trampas y consigue objetos especiales e ítems que te serán de ayuda en tu recorrido. Prepárate a conciencia y aprovecha las cualidades de variados atuendos  equipamiento para adaptarte al clima o aprovechar efectos especiales como ser más rápido o más sigiloso. Pon a prueba tu capacidad estratégica utilizando a tu favor el entorno y elaborando las estrategias adecuadas con las que acabar con enemigos de todas las formas y tamaños. Como es peligroso ir solo… ¡Lleva un amiibo! The Legend of Zelda: Breath of the Wild es compatible con figuras amiibo de la serie que te otorgarán recompensas en forma de cofres o, con la figura Link Lobo de Twilight Princess, recibe la asistencia del temible animal para luchar contra enemigos o encontrar más fácilmente objetos. The Legend of Zelda es una serie de videojuegos de acción-aventura creada por los diseñadores japoneses Shigeru Miyamoto y Takashi Tezuka,? y desarrollada por Nintendo, empresa que también se encarga de su distribución internacional. Su trama por lo general describe las heroicas aventuras del joven guerrero Link, que debe enfrentarse a peligros y resolver acertijos para ayudar a la Princesa Zelda a derrotar a Ganondorf y salvar su hogar, el reino de Hyrule. Entra en un mundo de aventura Olvida todo lo que sabes sobre los juegos de The Legend of Zelda. Entra en un mundo de descubrimientos, exploración y aventura en The Legend of Zelda: Breath of the Wild, un nuevo juego de la aclamada serie que rompe con las convenciones. Viaja por praderas, bosques y cumbres montañosas para descubrir qué ha sido del asolado reino de Hyrule en esta maravillosa aventura a cielo abierto.','zelda breath of the wild.jpg'),(5,'Final Fantasy IX','Square','2000-07-07','Prepárate para la fantasía final más vendida de la historia. Final Fantasy VII para PlayStation 4. un remake con impresionantes gráficos que hará que tanto los fans de la saga como los nuevos seguidores revivan los momentos favoritos remasterizados en alta definición.','final fantasy ix.jpg'),(6,'Bloodborne','From Software','2015-03-26','Hazte con Bloodborne en para PlayStation 4 y encarna al cazador, uno de los mejores juegos para PlayStation 4. Un juego de acción tan exigente como desafiante. ¿Estarás a la altura de este reto o perecerás en el intento? Con una ambientación tétrica y oscura, este RPG de acción se ha convertido en uno de los clásicos más célebres de PlayStation 4.','bloodborne.jpg'),(7,'Demons Souls Remaque','BluePoint','2020-11-23','Un clásico del genéro que inventó su propio género, llega a la próxima generación de consolas de SONY, reservalo ya para PlayStation 5 en Game.      En su búsqueda de poder, el 12º Rey de Boleraria, el Rey Allant, canalizó el antiguo Soul Arts, despertando a un demonio que permanecía aletargado desde los albores del tiempo, The Old One. Con el resurgir de The Old One, una terrible niebla se expandió a lo largo de las tierras, invocando monstruos y criaturas hambrientas de almas humanas.      Aquellos cuyas almas fueron arrebatadas, perdieron la cabeza, manteniendo únicamente el deseo de atacar a los seres cuerdos que seguían vivos. Ahora, Boleraria está aislada del mundo exterior, y aquellos caballeros que se atreven a penetrar en la profunda niebla para liberarla del terror, no han vuelto a ser vistos.      Como un guerrero solitario que se ha adentrado en la peligrosa neblina, deberás hace frente al más difícil de los desafíos para ganar el título de “Asesino de demonios” y enviar al The Old One de vuelta a su letargo.','demons soul ps5.jpg'),(8,'Dragon Quest VIII: El periplo del rey maldito','Square Enix','2004-11-27','Una siniestra amenaza se cierne sobre el reino y amenaza con destruirlo en DRAGON QUEST VIII: El periplo del Rey Maldito para la familia de consolas Nintendo 3DS.   Una misión épica, un grupo de héroes por accidente y una terrible maldición...     Un retorcido bufón ha lanzado una maldición sobre el reino de Trodain, transformando al rey en un trol, a la princesa en un caballo y sellando el Castillo de Trodain con enredaderas encantadas. En el papel de Hero, te embarcarás en una misión para poner freno al demente bufón y devolver el reino a la normalidad con la ayuda de los aliados que reclutes en tu camino.     ¡Lucha!   Lidera a un equipo de héroes a través de un mundo enorme plagado de siniestras mazmorras en las que tendréis que plantar cara a cientos de monstruos en clásicas batallas por turnos. Usa la astucia para derrotar a tus enemigos a tu propio ritmo, o usa la función \"acelerar\" para acabar con tus rivales más rápidamente.   A medida que tus guerreros se vayan haciendo más fuertes, asígnales puntos de destreza para que aprendan nuevos hechizos, habilidades, etc. Equipa a tus héroes con los artefactos más novedosos para el combate y combina objetos viejos en el pote de alquimia para crear objetos nuevos instantáneamente.     No sigas el camino marcado...   Durante tu aventura, asegúrate de explorar todos los pueblos, visitar todas las tiendas y emprender todas las misiones secundarias posibles. Forma un equipo de monstruos y llega a lo más alto en la Arena de Monstruos o saca fotos de tu aventura que podrás compartir con otros usuarios vía StreetPass.   Descubre las otras novedades de la versión para Nintendo 3DS de DRAGON QUEST VIII: El periplo del Rey Maldito','dragon quest viii.jpg'),(9,'Dragon Ball Figtherz','Arc System Works','2018-02-01','Llega la Lucha Definitiva      Vuelve la acción Dragon Ball a PlayStation 4, Xbox One y Nintendo Switch con Dragon Ball FighterZ, el juego de lucha 2D para la actual generación. Tras el éxito de Xenoverse, llega un nuevo Dragon Ball que mejora al máximo los gráficos del anime, con una mecánica fácil de aprender pero... Difícil de dominar.        Características:        Soporte 3vs3 Tag.   Permite al jugador entrenar y manejar el estilo de más de un luchador con lo que se consigue una jugabilidad más profunda.        Excelentes gráficos anime   El poder del motor Unreal llevado a la máxima potencia para hacer de Dragon Ball FighterZ una hazaña de fuerza.        Luchas espectaculares   Disfruta de combos en el aíre, escenarios interactivos y famosas escenas del anime de Dragon Ball a una resolución de 60FPS y 1080p. Con mejores resoluciones incluso en PlayStyation 4 Pro y Xbox One X        Tras el éxito de la saga Xenoverse, llega un nuevo juego Dragon Ball de lucha en 2D para la generación actual de consolas.   DRAGON BALL FighterZ vuelve con todo el contenido que ha hecho que las series DRAGON BALL sean tan apreciadas: espectaculares enfrentamientos sin fin con los luchadores más poderosos.   Desarrollado por Arc System Works, DRAGON BALL FighterZ mejora al máximo los gráficos del anime y resulta fácil de aprender pero difícil de dominar.','dragon ball figther z.jpg'),(10,'World of Warcraft: Shadowlans','Blizzard','2020-11-23','10  Enfréntate al más allá   El velo entre la vida y la muerte ya no existe.      Con un único acto de destrucción, Sylvanas Brisaveloz ha abierto el camino al más allá. Los defensores más entregados de Azeroth han acabado en una oscuridad que lo devora todo. Una antigua fuerza mortal amenaza con romper sus ataduras y deshilachar la realidad.      Reinos ocultos de maravillas y terrores esperan a aquellos que se atrevan a pasar al otro lado. Las Tierras Sombrías albergan un reino de difuntos. Se trata de un mundo entre mundos cuyo delicado equilibro preserva la vida y la muerte.      Como adalid de Azeroth, se te ha otorgado el poder de cruzar en cuerpo y alma. Ahora debes investigar una conspiración para deshacer el cosmos y ayudar a las leyendas del pasado y del presente de Warcraft a regresar a su hogar... o a cruzar al otro lado.','wow shadowlands.jpg'),(11,'Chrono Trigger','Square','1995-03-11','¡El clásico juego de rol regresa cargado    de mejoras, viaja al pasado más remoto, al futuro lejano y al fin de los tiempos.    Comienza una gran aventura para salvar el planeta...    Chrono Trigger es el célebre juego de rol creado por un magnifico equipo compuesto por Yuji Horii (DRAGON QUEST) , Akira Toriyama (Dragon Ball) y los creadores de FINAL FANTASY. A medida que avanzas en la trama, viajarás a distintas épocas históricas: el presente, el Medioevo, el futuro, la Prehistoria y la Antigüedad. Esta apasionante aventura épica entretendrá horas y horas tanto a los entusiastas de la serie como a los jugadores noveles.    Esta es la versión definitiva de CHRONO TRIGGER, y en ella se han actualizado los controles y se han renovado los gráficos y el sonido para que tu aventura sea todavía más agradable y divertida de jugar. Para completar tu viaje, este título también incluye las misteriosas mazmorras \"Vórtice dimensional\" y \"Santuario olvidado\". Enfréntate a los desafíos que te esperan y quizás consigas revelar secretos antiguos...    Historia    Gracias a un encuentro fortuito en la plaza de Lynne durante la Feria del milenio de Gardia, nuestro joven héroe Chrono se encuentra con una chica llamada Marle Deciden explorar la feria juntos y allí acuden a la exhibición de una nueva tecnología de teletransporte inventada por Lucca, la amiga de Crono.    A Marle le pica la curiosidad y, como no le teme a nada, se ofrece voluntaria para participar en una demostración. Sin embargo, la máquina se estropea en el momento clave y envía a Marle a una dimensión alternativa. Crono encuentra el colgante de la chica y decide ir tras ella para salvarla, pero aparece en el pasado... Cuatrocientos años antes de su época. Viaja al pasado más remoto, al futuro lejano e incluso al fin de los tiempos. Esta épica aventura en la que debes salvar el planeta de un futuro desastroso va a volver a hacer historia.','chrono trigger.png'),(28,'Inazuma Eleven Go: ','Level5','2020-11-23','es un videojuego de rol y deportes para Nintendo 3DS desarrollado y publicado por Level-5. Salió a la venta el 15 de diciembre de 2011 en Japón y el 13 de junio de 2014 en Europa. Hay dos versiones del juego, Shine y Dark, que se lanzaron en Europa como Luz y Sombra. Una serie manga del mismo nombre basada en el juego comenzó a publicarse en la revista japonesa CoroCoro Comic, mientras que el anime basado en el juego realizado por OLM se comenzó a emitir el 14 de mayo de 2011.','inazuma eleven go.jpg'),(30,'Grand Theft Auto V','Rockstar Games','2013-09-17','Grand Theft Auto V (abreviado como GTA V o GTA 5) es un videojuego de acción-aventura de mundo abierto desarrollado por el estudio Rockstar North y distribuido por Rockstar Games. Fue lanzado el 17 de septiembre de 2013 para las consolas PlayStation 3 y Xbox 360.4​ Posteriormente, fue lanzado el 18 de noviembre de 2014 para las consolas de nueva generación PlayStation 4 y Xbox One con mejores gráficos y novedades interesantes como la vista en primera persona, luego para Microsoft Windows el 14 de abril de 2015 y finalmente se confirmó su lanzamiento para PlayStation 5, Xbox Series X y Xbox Series S en la segunda mitad del 2021.5​6​ Se trató del primer gran título en la serie Grand Theft Auto desde el lanzamiento de Grand Theft Auto IV en 2008, el cual estrenó la «era HD» de la mencionada serie de videojuegos.7​','gta.jpg');


INSERT INTO plataforma VALUES (1,'Nintendo 64','1996-06-23',210,5,'Nintendo 64 es la cuarta videoconsola de sobremesa producida por Nintendo, desarrollada para suceder a la Super Nintendo y para competir con el Saturn de Sega y la PlayStation de Sony.    Incorpora en su arquitectura un procesador principal de 64 bits. El soporte de almacenamiento de los juegos es en forma de cartuchos, la mayoría de ellos con memoria interna. El uso de este tipo de almacenamiento le supuso una seria desventaja comercial frente a sus competidores, ya que encarecía los costes de producción lo que aumentaba el precio final, y además, era de una capacidad de almacenamiento menor al de un CD-ROM.    Técnicamente, la utilización de cartuchos ofrece algunas ventajas frente al formato CD-ROM, siendo esta la idea que mantenía Nintendo frente a la competencia. El cartucho tiene tiempos de acceso al sistema mucho más cortos, hace posible la inclusión de coprocesadores y otros chips dentro del cartucho y técnicas como streaming en tiempo real para mejorar las capacidades de los juegos, logrando ampliar su vida útil; y en un principio parecía que podría ser más económico por no pagar derechos (\"regalías\" o \"royalties\") por uso del formato CD-ROM, ni una unidad lectora para el mismo que sería además mucho más delicada que una ranura o slot para cartuchos. Sin embargo, la escasa capacidad del cartucho en comparación con el CD-ROM supuso ausencia casi total de cinemáticas pregrabadas, una merma en la calidad del sonido y una falta de espacio para recursos como texturas y número de escenarios.    Nintendo 64 incluyó en sus mandos unos botones dispuestos en cruz diseñados especialmente para que el usuario tomara el control de aspectos propios de juegos basados en entornos tridimensionales (el control de la perspectiva de juego o cámaras, por ejemplo), los cuales fueron utilizados por primera vez por el juego Super Mario 64. También incluyó un stick analógico, el cual permite diferentes grados de movimiento. También tuvo función de vibración gracias al periférico Rumble Pak. ','nintendo 64.jpg','logo nintendo 64.jpg'),(2,'Nintendo Switch','2017-03-17',329,25,'Nintendo Switch  es la octava consola de videojuegos principal desarrollada por Nintendo. Conocida en el desarrollo por su nombre código «NX», se dio a conocer en octubre de 2016 y fue lanzada mundialmente el 3 de marzo de 2017.   Nintendo considera a Switch una consola híbrida. Se puede utilizar como consola de sobremesa con la unidad principal insertada en una estación de acoplamiento para conectarla con un televisor. Alternativamente, puede ser extraída de la base y utilizada de forma similar a una tableta a través de su pantalla táctil LCD, o colocada sobre una superficie gracias a su soporte plástico integrado siendo así visible por varios jugadores.   La Switch utiliza dos controladores inalámbricos llamados en conjunto Joy-Con, que incluyen cuatro botones de acción estándar y un joystick direccional, así como sensores para la detección de movimiento y retroalimentación táctil de alta definición, aunque se diferencian en algunos botones y características adicionales. Dos Joy-Con pueden conectarse uno a cada lado de la consola para usarse como consola portátil, conectarse al accesorio Grip proporcionado junto a la consola para usarlos como un mando más tradicional, o ser utilizados individualmente en la mano como el mando Wii, y de esta forma usarse con juegos multijugador locales. También puede utilizar ciertos controles inalámbricos y/o alámbricos que no incluye la consola, adoptado como Pro Controller, que incluyen las mismas características que los mandos tradicionales a excepción de que este incluye detección NFC para Amiibo y vibración HD.   Los juegos para esta consola y otras aplicaciones están disponibles como cartuchos físicos ROM de flash y como distribución digital, y no utilizan bloqueo de región, por lo que puedes comprar juegos de cualquier mercado.  ','nintnedo switch.jpg','switch logo.png'),(3,'Playstation 5','2020-11-23',499,0,'PlayStation 5 es una consola de videojuegos de sobremesa desarrollada por Sony Interactive Entertainment. Es la sucesora de la PlayStation 4, y se lanzó el 12 de noviembre de 2020 en Norteamérica, Japón, Australasia y Corea del Sur, mientras que fue lanzada el 19 de noviembre de 2020 en el resto del mundo.   Es la quinta consola de sobremesa de la marca PlayStation y la tercera en ser diseñada por Mark Cerny. Desde su lanzamiento la consola ha contado con dos modelos: una consola PlayStation 5 con lector de discos BD UHD-ROM y también para la función multimedia, y una versión digital llamada, PlayStation 5 Digital Edition sin el lector.   La consola PS5 compite contra las consolas Xbox Series X|S de Microsoft y Switch de Nintendo para abrir paso a la novena generación de videojuegos.   La PlayStation 5 utiliza el mismo tipo de CPU de la marca AMD que la PlayStation 4, pero introduce una unidad de estado sólido (SSD) personalizada diseñada para la transmisión de datos de alta velocidad que permiten mejoras significativas en el rendimiento gráfico. El hardware también incluye una GPU AMD personalizada que posibilita la renderización por trazado de rayos, soporte para pantallas de resolución 4K y una alta tasa de fotogramas por segundo, efectos de audio 3D en tiempo real y retrocompatibilidad con la mayoría de los videojuegos para PlayStation 4 y PlayStation VR.   ','play 5.jpg','ps5 logo.jpg'),(4,'Playstation 4','2013-11-29',399,15,'PlayStation 4 oficialmente abreviada como PS4) es la cuarta videoconsola del modelo PlayStation.8 Es la segunda consola de Sony en ser diseñada por Mark Cerny y forma parte de las videoconsolas de octava generación. Fue anunciada oficialmente el 20 de febrero de 2013 en el evento PlayStation Meeting 2013,9 aunque el diseño de la consola no fue presentado hasta el 10 de junio en el E3 2013.10 Es la sucesora de la PlayStation 3 y compite con Wii U y Switch de Nintendo y Xbox One de Microsoft. Su lanzamiento fue el 15 de noviembre de 2013 en Estados Unidos y en Europa y Sudamérica fue el 29 de noviembre de 2013,119 mientras que en Japón fue el 22 de febrero de 2014.2   Alejándose de la compleja arquitectura utilizada en el procesador Cell de la videoconsola PlayStation 3, la PlayStation 4 cuenta con un procesador AMD de 8 núcleos bajo la arquitectura x86-64. Estas instrucciones x86-64 están diseñados para hacer más fácil el desarrollo de videojuegos en la consola de nueva generación, que atrae a un mayor número de desarrolladores. Estos cambios ponen de manifiesto el esfuerzo de Sony para mejorar las lecciones aprendidas durante el desarrollo, la producción y el lanzamiento de la PS3. Otras características de hardware notables de la PS4 es que incluyen 8 GB de memoria unificada GDDR5, una unidad de disco Blu-ray más rápido, y los chips personalizados dedicados a tareas de procesamiento de audio, vídeo y de fondo.   Entre las nuevas aplicaciones y servicios, Sony lanzó la aplicación PlayStation App, permitiendo a los que tengan una PS4 convertir los teléfonos inteligentes y las tabletas en una segunda pantalla para mejorar la jugabilidad o en teclados externos para más comodidad en el momento de escribir. La compañía también planeaba debutar con Gaikai, un servicio de juego basado en la nube que aloja contenidos y juegos descargables. Mediante la incorporación del botón \"Share\" en el nuevo controlador hace que sea posible compartir en cualquier momento capturas de pantalla, trofeos, compras o videos en páginas como Facebook, Twitter y hacer stream de lo que se juegue y ver el de otros amigos en directo desde Ustream o Twitch, Sony planeó colocar más énfasis en el juego social. La consola PS4 el primer día de su lanzamiento vendió más de 1 millón de consolas solo en territorio de los Estados Unidos.12 Al inicio de su conferencia de prensa en la Gamescom 2014, Sony anunció que ya había vendido más de 10 000 000 unidades de la PlayStation 4 en el mundo a usuarios finales. Está diseñada para la amplia integración con PlayStation Vita.  ','play 4.jpg','logo play 4.jpg'),(5,'Playstation','1995-09-29',429,3,'PlayStation es la primera videoconsola de Sony, y la primera de dicha compañía en ser diseñada por Ken Kutaragi, y es una videoconsola de sobremesa de 32 bits lanzada por Sony Computer Entertainment el 3 de diciembre de 1994 en Japón. Se considera la videoconsola más exitosa de la quinta generación tanto en ventas como en popularidad. Además de la original, en el año 2000 se lanzó la PSone (también llamado modelo slim). Tuvo gran éxito al implantar el CD-ROM dentro de su hardware a pesar de que otras compañías como SEGA (Sega CD), Panasonic (3DO), Philips (CD-i), SNK (Neo Geo CD), NEC (Super CD-ROM) y Atari (Atari Jaguar) ya lo habían empleado. Dichas compañías tuvieron poco éxito al utilizar el CD-ROM como soporte para almacenar juegos. Se estima que Sony pudo vender 105 500 000 unidades de su videoconsola en diez años. La consola fue retirada oficialmente del mercado el 23 de marzo de 2006.','play 1.jpg','play 1 logo.png'),(6,'Game Cube','2002-05-03',199,9,'Nintendo GameCube también llamada simplemente GameCube y abreviada como GCN en América y NGC en Japón, es la quinta consola de sobremesa hecha por Nintendo. Es la sucesora del Nintendo 64 y la predecesora del Wii.   Sus principales características son su procesador central basado en un IBM PowerPC (tecnología previa utilizada en computadoras personales y portátiles), y su procesador gráfico desarrollado por ATI Technologies. Nintendo, por primera vez, prescinde del cartucho (ROM) como formato de almacenamiento, y adopta un formato óptico propio, el Nintendo Optical Disc. El nombre «GameCube» se debe a que el sistema tiene la forma parecida a la de un cubo. Es además la primera consola de Nintendo que no cuenta en su fecha de lanzamiento con un juego de Mario, mascota oficial de la compañía.   La consola fue lanzada el 14 de septiembre de 2001 en Japón, el 18 de noviembre de 2001 en Norteamérica, el 3 de mayo de 2002 en Europa y el 17 de mayo de 2002 en Australia. Fue descontinuada el 28 de octubre de 2007 en Japón, el 17 de mayo de 2008 en Europa y el 15 de junio de 2008 en Norteamérica y el último videojuego fue Madden NFL 08.56 Según las cifras oficiales, el GameCube logró vender 21 740 000 unidades mundialmente.   ','game cube.jpg','game cube logo.png'),(7,'Nintendo 3DS','2011-02-26',250,9,'Nintendo 3DS es una videoconsola portátil de la multinacional de origen japonés, Nintendo, para videojuegos y multimedia, cuya atracción principal es poder mostrar gráficos en 3D sin necesidad de gafas especiales, gracias a la autoestereoscopia.10 La consola es retrocompatible con la Nintendo DS y con el software de DSiWare.10 Tras haberse anunciado en 2010, Nintendo lo presentó oficialmente en el E3 2010,1011 llevando consolas de prueba para los asistentes al evento.12 La consola es la sucesora de la serie portátil Nintendo DS10 y compitió principalmente con su único rival en el mercado, la PlayStation Vita de Sony.13   Nintendo 3DS fue lanzada el 26 de febrero de 2011 en Japón; el 25 de marzo de 2011 en Europa; el 27 de marzo de 2011 en América del Norte;1415 y en Australia el 31 de marzo de 2011. El 28 de julio de 2011, Nintendo anunció una bajada drástica de precio que sería efectiva desde el 12 de agosto. Como compensación, los compradores que la hubieran adquirido antes de la bajada de precio recibirían gratuitamente diez juegos de Nintendo Entertainment System desde el 1 de septiembre de 2011 y otros 10 de Game Boy Advance desde el 16 de diciembre, descargables desde la Nintendo eShop.16   El 17 de septiembre de 2020, Nintendo anunció el cese de producción de la Nintendo 2DS XL, la única consola de la Familia Nintendo 3DS que quedaba en producción en ese entonces, dando fin a la Familia Nintendo 3DS y centrándose completamente en la familia Nintendo Switch  ','nintendo 3ds.png','logo 3ds.jpg'),(8,'Wii U','2012-11-30',299,15,'Wii U con nombre clave Project Café,9 es una consola perteneciente a la octava generación de videoconsolas,10111213 siendo la séptima consola de sobremesa creada por Nintendo y directa sucesora de Wii.9 La consola fue lanzada el 18 de noviembre de 2012 en terreno norteamericano siendo su fecha de apertura.1415 Se presentó en la conferencia de Nintendo durante el Electronic Entertainment Expo 2011 el 7 de junio de 2011.16Competía principalmente con la PlayStation 4 de Sony y la Xbox One de Microsoft.   Wii U es la primera consola de Nintendo en producir gráficos en alta definición hasta una resolución de 1080p. Incluye un nuevo mando que incorpora una pantalla táctil que recibe señal en calidad 480p de la consola, lo que permite seguir jugando incluso cuando el televisor está apagado. A este nuevo mando se le ha denominado: Wii U GamePad. El sistema es retrocompatible con los juegos de Wii, y soporta los periféricos de Wii, como el Wiimote o la Wii Balance Board e incluyendo la tecnología NFC,17 además de que es compatible con las figuras y cartas amiibo como accesorio propio (también compatibles en la Nintendo 3DS, que modifican la forma de jugar videojuegos). Sin embargo, no es retrocompatible con los periféricos de Nintendo GameCube (a excepción del mando que se conecta mediante un adaptador) pero tiene capacidad de descargar los videojuegos desde la consola virtual.18   A finales de mayo de 2017, Nintendo cesó la fabricación de la consola Wii U. El último videojuego publicado para la consola Wii U fue The Legend of Zelda: Breath of the Wild.  ','wii u.jpg','Wii-u.png'),(9,'Playstation 2','2000-11-24',450,5,'La PlayStation 2 (oficialmente abreviada como PS2) es la segunda videoconsola de sobremesa producida por Sony Computer Entertainment, y la tercera consola de Sony en ser diseñada por Ken Kutaragi. Además de ser la sucesora de la PlayStation.   Fue lanzada por primera vez el 4 de marzo del año 2000 en Japón, y unos meses después en el resto del mundo. Es la videoconsola más vendida de la historia, con más de 160 millones de unidades vendidas. Esta consola es también la que más títulos posee, aproximadamente 3870 títulos, seguida por su predecesora la PlayStation con unos 2500 títulos. Esta cantidad de títulos dada la extraordinaria acogida por parte del público en general hacia la misma, lo que incluso la consolidó como la consola con más tiempo en el mercado y a su vez la consola con más duración en el mismo, hasta que el 3 de enero del año 2013 se decide detener su fabricación tras 13 años de actividad    ','play 2.webp','logo play 2.png'),(10,'PC','1980-04-04',1500,6,'Una computadora personal, computador personal u ordenador, conocida como PC (siglas en inglés de Personal Computer), es un tipo de microcomputadora diseñada en principio para ser utilizada por una sola persona. Habitualmente, la sigla PC se refiere a las computadoras IBM PC compatibles. Una computadora personal es generalmente de tamaño medio y es usada por un solo usuario (aunque hay sistemas operativos que permiten varios usuarios simultáneamente, lo que es conocido como multiusuario). Suele denominarse ordenador de sobremesa, debido a su posición estática e imposibilidad de transporte a diferencia de un ordenador portátil.    Una computadora personal suele estar equipada para cumplir tareas comunes de la informática moderna, es decir, permite navegar por Internet, estudiar, escribir textos y realizar otros trabajos de oficina o educativos, como editar textos y bases de datos, a ocho demás de actividades de ocio, como escuchar música, ver videos, jugar, etc.    En cuanto a su movilidad podemos distinguir entre computadora de escritorio y computadora portátil. ','imagenespc.jpg','logo pc.png'),(11,'Super Nintendo','1992-06-12',180,12,'La Super Nintendo Entertainment System, conocida popularmente como la Super Nintendo, también llamada la Super Famicom (japonés: スーパーファミコン, Hepburn: Sūpā Famikon) en Japón7​ (abreviada SFC) y la Hyundai Super Comboy (hangul: 현대 슈퍼 컴보이, romanización revisada: Hyeondae Syupeo Keomboi) en Corea del Sur,8​ también nombrada oficialmente de forma abreviada como la Super NES o SNES en América9​ y como la Super Nintendo en Europa,10​ es la tercera videoconsola de sobremesa de Nintendo y la sucesora de Nintendo Entertainment System (NES) en América y Europa. Mantuvo una gran rivalidad en todo el mundo con la Sega Mega Drive (o Sega Genesis) durante la era de 16 bits. Fue descontinuada en el año 1999 (2003 en Japón)11​ y años más tarde, fue relanzada virtualmente a través de la Consola Virtual en la Wii en 2006, Wii U en 2013, Nintendo 3DS (solo la versión New) en 2016 y Nintendo Switch en 2019 (no a través de la Consola Virtual, si no a través del servicio en línea Nintendo Switch Online).    Fue la más exitosa y vendida de la era de los 16 bits. Gracias al chip Super FX, la SNES tuvo los primeros videojuegos totalmente tridimensionales en la consola, siendo Star Fox el primer videojuego para consola de videojuegos con gráficos completamente tridimensionales','super nintendo.jpg','super nintnedo logo.png'),(30,'Wii','2006-11-19',180,13,'Nintendo Wii (ニンテンドーウィー Nintendō Uī?) es la sexta videoconsola producida por Nintendo y estrenada el 19 de noviembre de 2006 en Norteamérica y el 8 de diciembre del mismo año en Europa. Perteneciente a la séptima generación de videoconsolas,10​ es la sucesora directa de GameCube y compitió con la Xbox 360 de Microsoft y la PlayStation 3 de Sony.','wii.jpg','wii logo.png'),(32,'Playstation 3','2007-03-17',250,5,'PlayStation 3 (プレイステーション3 Pureisutēshon Surī?, oficialmente abreviada como PS3)5​ es la tercera videoconsola del modelo PlayStation de Sony Computer Entertainment. Es la quinta y última consola de Sony en ser diseñada por Ken Kutaragi y forma parte de las videoconsolas de séptima generación y sus competidores son la Xbox 360 de Microsoft y la Wii de Nintendo.','play 3.jpg','play 3 logo.jpg');

