create or replace database bdfinalpc3;
use bdfinalpc3;

CREATE TABLE Administrador
(
	CodAministrador      VARCHAR(20) NOT NULL primary key,
	nombreA              VARCHAR(40) ,
	dniA                 VARCHAR(8) ,
	telefonoA            VARCHAR(10) ,
	direccionA           VARCHAR(50) 
	
);

CREATE TABLE CursoProfesor
(
	CodCurso             INT (6) not null primary key,
     CodProfesor          VARCHAR(20),
	nombreC              VARCHAR(60) ,
	creditosC            VARCHAR(3) ,
	costoC               NUMERIC(8,2) 
	 
);


CREATE or replace TABLE Detaplan
(
     ciclo                VARCHAR(3) ,
	codPlan              VARCHAR(20),
	codigo			int (6),
	asignatura             varchar(60),
	tipocurso            VARCHAR(20) ,
	ht                   VARCHAR(20) ,
	hp                   VARCHAR(20) ,
	prerrequisitos       VARCHAR(40) 
 
);

CREATE TABLE Especialidad
(
	CodEspecialidad      VARCHAR(20) NOT NULL primary key,
	nombreEsp            VARCHAR(40) 
	
);

CREATE TABLE Estudiante
(
	CodEstudiante        INT (10),
     CodCurso             INT(6) ,
	CodProfesion         VARCHAR(20), 
	nombreE              VARCHAR(40) ,
	beneficioE           VARCHAR(20) ,
	categoriaE           VARCHAR(3) 

);

CREATE TABLE Notas
(
    CodEstudiante        INT (10),
	CodCurso             INT (6),
	p1                   FLOAT ,
	p2                   FLOAT ,
	p3                   FLOAT ,
	ef                   FLOAT ,
	ec1                  FLOAT ,
	ec2                  FLOAT ,
	ec3                  FLOAT ,
	ec4                  FLOAT ,
	ec5                  FLOAT ,
	ev6                  FLOAT 

);

CREATE TABLE Pago
(
     CodPago              VARCHAR(20),
	CodEstudiante        INT(10) ,
	fechaV               datetime ,
	numerocuota          VARCHAR(20) ,
	monto                DECIMAL(20,8) ,
	descuento            VARCHAR(20) 
);


CREATE TABLE Planestudios
(
	codPlan              VARCHAR(20) not null primary key,
    CodProfesion         VARCHAR(20) ,
	anioValidacion       VARCHAR(20) 
	
);

CREATE TABLE Profesion
(
	CodProfesion         VARCHAR(20) not null primary key,
	nomP                 VARCHAR(40) 
	);


CREATE TABLE Profesor
(
	CodProfesor          VARCHAR(20) not null primary key,
    CodAministrador      VARCHAR(20) ,
	CodEspecialidad      VARCHAR(20) ,
	nombreP              VARCHAR(60) ,
	telefonoP            VARCHAR(10) ,
	direccionP           VARCHAR(50) ,
	gradoP               VARCHAR(20) ,
	aniosC               VARCHAR(20) 
);



-- Inserts para la tabla Administrador
INSERT INTO Administrador (CodAministrador, nombreA, dniA, telefonoA, direccionA)
VALUES
('ADM001', 'Juan Pérez', '12345678', '999888777', 'Av. Principal 123'),
('ADM002', 'María González', '87654321', '666555444', 'Calle Secundaria 456'),
('ADM003', 'Julio Piedra', '87654321', '666555444', 'Calle Secundaria 456'),
('ADM004', 'José Silva', '87654321', '666555444', 'Calle Secundaria 456')
;


-- Inserts para la tabla Especialidad
INSERT INTO Especialidad (CodEspecialidad, nombreEsp)
VALUES
('ESP001', 'Ingeniería de Software'),
('ESP002', 'Bases de Datos y Programación'),
('ESP003', 'Programación'),
('ESP004', 'Algorítmica'),
('ESP005', 'Ingenieria Sistemas'),
('ESP006', 'Estadística')
;



-- Inserts para la tabla Profesion
INSERT INTO Profesion (CodProfesion, nomP)
VALUES
('PROF001', 'Ingeniería de Sistemas'),
('PROF002', 'Ingeniería Industrial'),
('PROF003', 'Ingeniería Ambiental')
;



-- Inserts para la tabla Profesor
INSERT INTO Profesor (CodProfesor, CodAministrador, CodEspecialidad, nombreP, telefonoP, direccionP, gradoP, aniosC)
VALUES
('PROF001', 'ADM001', 'ESP001', 'Luis Ramírez', '977666555', 'Av. Principal 456', 'Maestría', '10'),
('PROF002', 'ADM002', 'ESP002', 'Ana López', '955444333', 'Calle Secundaria 789, Los Olivos', 'Doctorado', '6'),
('PROF003', 'ADM001', 'ESP003', 'Ramón Quispe', '977666555', 'Av. Principal 476, SMP', 'Maestría', '4'),
('PROF004', 'ADM002', 'ESP004', 'Adrian Piedra', '955444333', 'Calle Secundaria 79, Lima', 'Doctorado', '5'),
('PROF005', 'ADM001', 'ESP005', 'Carlos Cardenas', '977666555', 'Av. Principal 87, Los Olivos', 'Maestría', '8'),
('PROF006', 'ADM002', 'ESP006', 'José Huaman', '955444333', 'Calle Secundaria 78, SMP', 'Doctorado', '9')
;



-- Inserts para la tabla Curso
INSERT INTO CursoProfesor (CodCurso, CodProfesor, nombreC, creditosC, costoC)
VALUES
(2000, 'PROF002', 'Programación Computadoras 3', '3', 517.00),
(2001, 'PROF002', 'Bases de Datos 2', '3', 517.00),
(2002, 'PROF004', 'Microprocesadores', '3', 517.00),
(2003, 'PROF001', 'Ingeniería de Sofware 1', '3', 517.00),
(2004, 'PROF005', 'Sistemas Digitales', '3', 517.00),
(2005, 'PROF006', 'Investigación operativa', '4', 670.00)
;



-- Inserts para la tabla Detaplan
INSERT INTO Detaplan (ciclo, codPlan, codigo, asignatura, tipocurso, ht, hp, prerrequisitos)
VALUES 
('1', 'PLAN003', 150286, 'ACTIVIDADES I', 'O', '0', '2', '1'),
('1', 'PLAN003', 170001, 'ANTROPOLOGIA RELIGIOSA', 'O', '4', '0', '4'),
('1', 'PLAN003', 200258, 'ESTRUCTURAS DISCRETAS I', 'O', '2', '2', '3'),
('1', 'PLAN003', 200257, 'FUNDAMENTOS DE SISTEMAS DE INFORMACION Y CIENCIAS DE LA COMPUTACION', 'O', '2', '4', '4'),
('1', 'PLAN003', 150285, 'INGLES I', 'O', '0', '2', '1'),
('1', 'PLAN003', 150283, 'LENGUA: COMUNICACION ESCRITA ACADEMICA', 'O', '4', '2', '5'),
('1', 'PLAN003', 131042, 'MATEMATICA BASICA PARA INGENIERIA', 'O', '2', '4', '4'),
('1', 'PLAN003', 132095, 'HERRAMIENTAS DE OFIMATICA', 'E', '2', '2', '3'),
('2', 'PLAN003', 200260, 'ALGORITMOS Y ESTRUCTURAS DE DATOS', 'O', '2', '4', '(I) 200257 - (I) 200258'),
('2', 'PLAN003', 131043, 'CALCULO DIFERENCIAL', 'O', '2', '4', '(I) 131042'),
('2', 'PLAN003', 132104, 'FISICA 1', 'O', '2', '2', '(I) 131042'),
('2', 'PLAN003', 150288, 'INGLES II', 'O', '0', '2', '(I) 150285'),
('2', 'PLAN003', 150284, 'REDACCION ACADEMICA', 'O', '4', '2', '(I) 150283'),
('2', 'PLAN003', 170009, 'TEOLOGIA I', 'O', '4', '0', '(I) 170001'),
('2', 'PLAN003', 200291, 'TEORIA Y DINAMICA DE SISTEMAS', 'O', '2', '2', '(I) 200257'),
('3', 'PLAN003', 132105, 'FISICA 2', 'O', '2', '2', '(II) 132104'),
('3', 'PLAN003', 200292, 'GESTION DE PROCESOS DE NEGOCIOS', 'O', '2', '2', '(II) 200291'),
('3', 'PLAN003', 200310, 'INGENIERIA ECONOMICA FINANCIERA', 'O', '2', '2', '(II) 131043'),
('3', 'PLAN003', 150289, 'INGLES III', 'O', '0', '2', '(II) 150288'),
('3', 'PLAN003', 200263, 'INNOVACION Y DESARROLLO TECNOLOGICO', 'O', '2', '2', '(II) 200260'),
('3', 'PLAN003', 200293, 'PROGRAMACION DE COMPUTADORAS I', 'O', '2', '4', '(II) 200260'),
('3', 'PLAN003', 200261, 'PROGRAMACION ORIENTADA A OBJETOS', 'O', '2', '2', '(II) 200260'),
('3', 'PLAN003', 170010, 'TEOLOGIA II', 'O', '4', '0', '(II) 170009'),
('3', 'PLAN003', 200307, 'TALLER DE CREATIVIDAD TECNOLOGICA', 'E', '2', '2', '(I) 200257'),
('4', 'PLAN003', 131016, 'ASERTIVIDAD Y COMUNICACION EFECTIVA', 'O', '0', '2', '(II) 150284 - (III) 170010'),
('4', 'PLAN003', 200223, 'BASE DE DATOS 1', 'O', '2', '2', '(III) 200261'),
('4', 'PLAN003', 200196, 'DISEÑO Y EVALUACION DE PROYECTOS', 'O', '2', '2', '(III) 200310'),
('4', 'PLAN003', 200264, 'ESTADISTICA Y PROBABILIDADES', 'O', '2', '2', '(III) 200310'),
('4', 'PLAN003', 150290, 'INGLES IV', 'O', '0', '2', '(III) 150289'),
('4', 'PLAN003', 200296, 'PROCESOS DE SOFTWARE', 'O', '2', '2', '(III) 200292 - (III) 200263'),
('4', 'PLAN003', 200294, 'PROGRAMACION DE COMPUTADORAS II', 'O', '2', '4', '(III) 200293'),
('4', 'PLAN003', 200225, 'SISTEMAS DIGITALES', 'O', '2', '2', '(III) 132105'),
('4', 'PLAN003', 200265, 'DESARROLLO BASADO EN PLATAFORMAS', 'E', '2', '2', '(III) 200261'),
('5', 'PLAN003', 200242, 'BASE DE DATOS 2', 'O', '2', '2', '(IV) 200223'),
('5', 'PLAN003', 200268, 'FUNDAMENTOS DE SISTEMAS OPERATIVOS', 'O', '2', '2', '(IV) 200225'),
('5', 'PLAN003', 200224, 'INGENIERIA DE SOFTWARE 1', 'O', '2', '2', '(IV) 200296 - (IV) 131016'),
('5', 'PLAN003', 150291, 'INGLES V', 'O', '0', '2', '(IV) 150290'),
('5', 'PLAN003', 131023, 'INVESTIGACION OPERATIVA', 'O', '2', '4', '(IV) 200264 - (IV) 200196'),
('5', 'PLAN003', 200267, 'MICROPROCESADORES Y ARQUITECTURA DE COMPUTADORAS', 'O', '2', '2', '(IV) 200225'),
('5', 'PLAN003', 200295, 'PROGRAMACION DE COMPUTADORAS III', 'O', '2', '2', '(IV) 200294'),
('5', 'PLAN003', 200266, 'DISEÑO DE ALGORITMOS', 'E', '2', '2', '(IV) 200294'),
('6', 'PLAN003', 200297, 'EXPERIENCIA DE USUARIO Y USABILIDAD DEL SOFTWARE', 'O', '2', '2', '(V) 200224'),
('6', 'PLAN003', 200231, 'INGENIERIA DE SOFTWARE 2', 'O', '2', '2', '(V) 200224'),
('6', 'PLAN003', 150294, 'INGLES VI', 'O', '0', '2', '(V) 150291'),
('6', 'PLAN003', 200232, 'INTELIGENCIA DE NEGOCIOS Y ANALISIS DE DATOS', 'O', '2', '2', '(V) 200242'),
('6', 'PLAN003', 200270, 'INTERACCION HUMANO COMPUTADOR', 'O', '2', '2', '(V) 200268 - (V) 200267'),
('6', 'PLAN003', 200298, 'MARKETING DIGITAL', 'O', '2', '2', '(V) 200242'),
('6', 'PLAN003', 200271, 'PROCESOS ESTOCASTICOS', 'O', '2', '2', '(V) 131023'),
('6', 'PLAN003', 200269, 'REDES Y COMUNICACIONES', 'O', '2', '2', '(V) 200268'),
('6', 'PLAN003', 200272, 'MODELOS Y SIMULACION', 'E', '2', '2', '(V) 131023'),
('6', 'PLAN003', 200156, 'TECNOLOGIAS EMERGENTES I', 'E', '2', '2', '(V) 200268'),
('7', 'PLAN003', 200275, 'BIG DATA', 'O', '2', '4', '(VI) 200271'),
('7', 'PLAN003', 200300, 'CALIDAD DE SOFTWARE', 'O', '2', '2', '(VI) 200297'),
('7', 'PLAN003', 200299, 'GESTION DE PROYECTOS DE TI', 'O', '2', '2', '(VI) 200231'),
('7', 'PLAN003', 200276, 'INFRAESTRUCTURA DE TECNOLOGIAS DE INFORMACION', 'O', '2', '2', '(VI) 200269 - (VI) 200270'),
('7', 'PLAN003', 150297, 'INGLES VII', 'O', '0', '2', '(VI) 150294'),
('7', 'PLAN003', 200301, 'INNOVACION DE SISTEMAS DE INFORMACION Y NUEVAS TECNOLOGIAS', 'O', '2', '2', '(VI) 200232 - (VI) 200298'),
('7', 'PLAN003', 100077, 'LIDERAZGO EMPRESARIAL', 'O', '2', '2', '(VI) 200232'),
('7', 'PLAN003', 200311, 'SI DE GESTION EMPRESARIAL', 'O', '2', '2', '(VI) 200231'),
('7', 'PLAN003', 200243, 'LENGUAJE Y COMPILADORES', 'E', '2', '2', '(V) 131023'),
('7', 'PLAN003', 200256, 'TOPICOS AVANZADOS DE DISEÑO Y GESTION DE REDES', 'E', '2', '2', '(VI) 200269'),
('8', 'PLAN003', 200280, 'COMPUTACION EN LA NUBE', 'O', '2', '2', '(VII) 200275'),
('8', 'PLAN003', 200281, 'DISEÑO Y GESTION DE ARQUITECTURA EMPRESARIAL', 'O', '2', '2', '(VII) 200311 - (VII) 200276'),
('8', 'PLAN003', 200302, 'GESTION DE RIESGOS Y SEGURIDAD DE TI', 'O', '2', '4', '(VII) 200311'),
('8', 'PLAN003', 200279, 'IMPLEMENTACION Y DESPLIEGUE DE SOLUCIONES INFORMATICAS', 'O', '2', '4', '(VII) 200311 - (VII) 200300'),
('8', 'PLAN003', 150298, 'INGLES VIII', 'O', '0', '2', '(VII) 150297'),
('8', 'PLAN003', 250010, 'METODOLOGIA DE LA INVESTIGACION', 'O', '2', '2', '(VII) 200299 - (VII) 100077'),
('8', 'PLAN003', 200278, 'SEGURIDAD EN COMPUTADORAS', 'O', '2', '2', '(VII) 200276 - (VII) 200301'),
('8', 'PLAN003', 200153, 'COMPUTACION GRAFICA', 'E', '2', '2', '(V) 200266'),
('8', 'PLAN003', 200277, 'FUNDAMENTOS DE INTELIGENCIA ARTIFICIAL', 'E', '2', '4', '(V) 200266'),
('9', 'PLAN003', 200234, 'AUDITORIA DE SISTEMAS DE INFORMACION', 'O', '2', '2', '(VIII) 200278'),
('9', 'PLAN003', 200285, 'ETICA EN LA PROFESION Y GESTION DE PATENTES', 'O', '2', '2', '(VIII) 250010'),
('9', 'PLAN003', 200284, 'FUNDAMENTOS DE CIBERSEGURIDAD', 'O', '2', '2', '(VIII) 200278 - (VIII) 200280'),
('9', 'PLAN003', 200303, 'GESTION DE LA CONFIGURACION DEL SOFTWARE', 'O', '2', '2', '(VIII) 200279 - (VIII) 200281'),
('9', 'PLAN003', 150300, 'INGLES IX', 'O', '0', '2', '(VIII) 150298'),
('9', 'PLAN003', 200238, 'PRACTICAS PRE PROFESIONALES DE INGENIERIA DE SISTEMAS', 'O', '0', '2', '(VIII) 200279'),
('9', 'PLAN003', 200237, 'SEMINARIO DE INVESTIGACION 1 INGENIERIA DE SISTEMAS', 'O', '2', '4', '(VIII) 250010'),
('9', 'PLAN003', 200309, 'CONFIGURACION DE DISPOSITIVOS DE RED', 'E', '2', '2', '(VIII) 200279'),
('9', 'PLAN003', 200308, 'GESTION DE SERVICIOS DE TI', 'E', '2', '2', '(VIII) 200279'),
('9', 'PLAN003', 200283, 'INTERNET DE LAS COSAS', 'E', '2', '4', '(VI) 200269'),
('9', 'PLAN003', 200282, 'ROBOTICA', 'E', '2', '2', '(VIII) 200277'),
('10', 'PLAN003', 200290, 'EMPRENDIMIENTO Y TRANSFERENCIA TECNOLOGICA', 'O', '2', '0', '(IX) 200285 - (IX) 200238'),
('10', 'PLAN003', 200304, 'ESTRATEGIA, GESTION Y ADQUISICION DE SI', 'O', '2', '2', '(IX) 200303'),
('10', 'PLAN003', 200236, 'GERENCIA DE INFORMATICA Y DIRECCION ESTRATEGICA', 'O', '2', '2', '(VIII) 200281 - (IX) 200234'),
('10', 'PLAN003', 200305, 'GOBIERNO DE TI Y GOBERNANZA DE DATOS', 'O', '2', '2', '(IX) 200284'),
('10', 'PLAN003', 150303, 'INGLES X', 'O', '0', '2', '(IX) 150300'),
('10', 'PLAN003', 200241, 'SEMINARIO DE INVESTIGACION 2 INGENIERIA DE SISTEMAS', 'O', '2', '4', '(IX) 200237'),
('10', 'PLAN003', 200306, 'SISTEMAS DE GESTION DEL CONOCIMIENTO', 'O', '2', '4', '(IX) 200284'),
('10', 'PLAN003', 200288, 'TECNOLOGIA VERDE', 'O', '2', '0', '(IX) 200285'),
('10', 'PLAN003', 200287, 'TOPICOS AVANZADOS DE COMPUTACION GRAFICA', 'E', '2', '2', '(VIII) 200153')

;




-- Inserts para la tabla Estudiante
INSERT INTO Estudiante (CodEstudiante, CodCurso, CodProfesion, nombreE, beneficioE, categoriaE)
VALUES
(2022101028, 2000, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2000, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2000, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2000, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2000, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2000, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2000, 'PROF001', 'Valles, Luis', 'Regular', 'B'),

(2022101028, 2001, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2001, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2001, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2001, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2001, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2001, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2001, 'PROF001', 'Valles, Luis', 'Regular', 'B'),

(2022101028, 2002, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2002, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2002, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2002, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2002, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2002, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2002, 'PROF001', 'Valles, Luis', 'Regular', 'B'),

(2022101028, 2003, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2003, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2003, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2003, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2003, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2003, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2003, 'PROF001', 'Valles, Luis', 'Regular', 'B'),


(2022101028, 2004, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2004, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2004, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2004, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2004, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2004, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2004, 'PROF001', 'Valles, Luis', 'Regular', 'B'),

(2022101028, 2005, 'PROF001', 'Villalobos Silva, Khleiwin ', '1/4 beca', 'C'),
(2022101010, 2005, 'PROF001', ' Gómez, Carlos', '1/2 beca', 'A'),
(2022101011, 2005, 'PROF001', ' Martínez, Ana', '1/4 beca', 'B'),
(2022101012, 2005, 'PROF001', ' Gomes,Anaceli', 'Regular', 'B'),
(2022101013, 2005, 'PROF001', ' Crrazco, Martín', '1/2 beca', 'C'),
(2022101014, 2005, 'PROF001', 'Solis, Grabiel ', '1/4 beca', 'C'),
(2022101015, 2005, 'PROF001', 'Valles, Luis', 'Regular', 'B')

;




-- Inserts para la tabla Notas
INSERT INTO Notas (CodEstudiante, CodCurso, p1, p2, p3, ef, ec1, ec2, ec3, ec4, ec5, ev6)
VALUES
(2022101028, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101028, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101028, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101028, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101028, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101028, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101010, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101010, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101010, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101010, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101010, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101010, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101011, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101011, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101011, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101011, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101011, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101011, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101012, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101012, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101012, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101012, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101012, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101012, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101013, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101013, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101013, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101013, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101013, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101013, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101014, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101014, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101014, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101014, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101014, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101014, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),

(2022101015, 2000, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101015, 2001, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101015, 2002, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101015, 2003, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0),
(2022101015, 2004, 15.5, 16.0, 14.5, 15.8, 16.0, 15.5, 14.0, 16.0, 15.0, 14.5),
(2022101015, 2005, 14.0, 12.5, 13.0, 11.8, 12.0, 14.5, 13.0, 12.0, 13.5, 12.0)
;




-- Inserts para la tabla Pago
INSERT INTO Pago (CodPago, CodEstudiante, fechaV, numerocuota, monto, descuento)
VALUES
('PAG001', 2022101010, '2024-03-15 00:00:00', '1', 300.00, 'Descuento por pronto pago'),
('PAG002', 2022101010, '2024-04-15 00:00:00', '2', 300.00, 'Descuento por pronto pago'),
('PAG003', 2022101010, '2024-05-15 00:00:00', '3', 337.00, NULL),
('PAG004', 2022101010, '2024-06-15 00:00:00', '4', 300.00, NULL),
('PAG005', 2022101010, '2024-07-10 00:00:00', '5', 300.00, NULL),

('PAG001', 2022101011, '2024-03-15 00:00:00', '1', 450.00, 'Descuento por pronto pago'),
('PAG002', 2022101011, '2024-04-15 00:00:00', '2', 450.00, 'Descuento por pronto pago'),
('PAG003', 2022101011, '2024-05-15 00:00:00', '3', 467.00, NULL),
('PAG004', 2022101011, '2024-06-15 00:00:00', '4', 450.00, NULL),
('PAG005', 2022101011, '2024-07-10 00:00:00', '5', 450.00, NULL),

('PAG001', 2022101012, '2024-03-15 00:00:00', '1', 567.00, 'Descuento por pronto pago'),
('PAG002', 2022101012, '2024-04-15 00:00:00', '2', 567.00, 'Descuento por pronto pago'),
('PAG003', 2022101012, '2024-05-15 00:00:00', '3', 587.00, NULL),
('PAG004', 2022101012, '2024-06-15 00:00:00', '4', 567.00, NULL),
('PAG005', 2022101012, '2024-07-10 00:00:00', '5', 567.00, NULL),

('PAG001', 2022101013, '2024-03-15 00:00:00', '1', 300.00, 'Descuento por pronto pago'),
('PAG002', 2022101013, '2024-04-15 00:00:00', '2', 300.00, 'Descuento por pronto pago'),
('PAG003', 2022101013, '2024-05-15 00:00:00', '3', 337.00, NULL),
('PAG004', 2022101013, '2024-06-15 00:00:00', '4', 300.00, NULL),
('PAG005', 2022101013, '2024-07-10 00:00:00', '5', 300.00, NULL),

('PAG001', 2022101014, '2024-03-15 00:00:00', '1', 450.00, 'Descuento por pronto pago'),
('PAG002', 2022101014, '2024-04-15 00:00:00', '2', 450.00, 'Descuento por pronto pago'),
('PAG003', 2022101014, '2024-05-15 00:00:00', '3', 467.00, NULL),
('PAG004', 2022101014, '2024-06-15 00:00:00', '4', 450.00, NULL),
('PAG005', 2022101014, '2024-07-10 00:00:00', '5', 450.00, NULL),

('PAG001', 2022101015, '2024-03-15 00:00:00', '1', 500.00, 'Descuento por pronto pago'),
('PAG002', 2022101015, '2024-04-15 00:00:00', '2', 500.00, 'Descuento por pronto pago'),
('PAG003', 2022101015, '2024-05-15 00:00:00', '3', 567.00, NULL),
('PAG004', 2022101015, '2024-06-15 00:00:00', '4', 585.00, NULL),
('PAG005', 2022101015, '2024-07-10 00:00:00', '5', 585.00, NULL),

('PAG001', 2022101028, '2024-03-15 00:00:00', '1', 550.00, 'Descuento por pronto pago'),
('PAG002', 2022101028, '2024-04-15 00:00:00', '2', 550.00, 'Descuento por pronto pago'),
('PAG003', 2022101028, '2024-05-15 00:00:00', '3', 567.00, NULL),
('PAG004', 2022101028, '2024-06-15 00:00:00', '4', 567.00, NULL),
('PAG005', 2022101028, '2024-07-10 00:00:00', '5', 550.00, NULL)

;




-- Inserts para la tabla Planestudios
INSERT INTO Planestudios (codPlan, CodProfesion, anioValidacion)
VALUES
('PLAN003', 'PROF001', '2022')
;


