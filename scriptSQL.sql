CREATE TABLE TipoOperacion(
	idTipo serial PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	CONSTRAINT u_nombreTipoOperacion UNIQUE (nombre)
);

CREATE TABLE Vendedor(
	idVendedor serial PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	idSupervisor INT
);
ALTER TABLE Vendedor ADD CONSTRAINT fk_vendedor
FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor)
ON DELETE cascade ON UPDATE cascade;

CREATE TABLE CompradorArrendador(
	rut INT PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL
);

CREATE TABLE Duenio(
	rut INT PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	celular INT NOT NULL,
	email VARCHAR(30) NOT NULL
);

CREATE TABLE TipoVivienda(
	idTipoVivienda serial PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	CONSTRAINT u_nombreVivienda UNIQUE (nombre)
);

CREATE TABLE Provincia(
	idProvincia serial PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	CONSTRAINT u_nombreProvincia UNIQUE (nombre)
);

CREATE TABLE Vivienda(
	idVivienda serial PRIMARY KEY,
	superficie INT NOT NULL check(superficie > 0),
	construido INT,
	tipo INT NOT NULL,
	provincia INT NOT NULL,
	rutDuenio INT NOT NULL,
	CONSTRAINT fk_tipoVivienda FOREIGN KEY (tipo)
	REFERENCES TipoVivienda(idTipoVivienda) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_provincia FOREIGN KEY (provincia)
	REFERENCES Provincia(idProvincia) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_rutDuenio FOREIGN KEY (rutDuenio)
	REFERENCES Duenio(rut) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Operacion(
	referencia serial PRIMARY KEY,
	fechaAlta DATE NOT NULL,
	precioVenta INT NOT NULL check (precioVenta > 0),
	fechaVenta DATE,
	IDtipoOperacion INT NOT NULL,
	idVendedor INT NOT NULL,
	rutCompradorArrendador INT NOT NULL,
	idVivienda INT NOT NULL,
	CONSTRAINT fk_tipoOperacion FOREIGN KEY (IDtipoOperacion)
	REFERENCES TipoOperacion(idTipo) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_vendedor FOREIGN KEY (idVendedor)
	REFERENCES Vendedor(idVendedor) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_rutCompradorArrendador FOREIGN KEY (rutCompradorArrendador)
	REFERENCES CompradorArrendador(rut) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_vivienda FOREIGN KEY (idVivienda)
	REFERENCES Vivienda(idVivienda) ON UPDATE CASCADE ON DELETE CASCADE
);
