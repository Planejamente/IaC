-- Table Usuario
CREATE TABLE Usuario (
    id CHAR(36) NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    dataDeNascimento DATE NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    genero VARCHAR(9) NOT NULL,
    dtCriacao DATETIME NOT NULL,
    crp VARCHAR(15) NULL,
    cnpj VARCHAR(14) NULL,
    cpf VARCHAR(11) NULL,
    email VARCHAR(255) NOT NULL,
    linkFotoPerfil VARCHAR(255) NULL,
    googleSub VARCHAR(122) NOT NULL,
    idCalendarioDisponivel VARCHAR(255) NULL,
    idCalendarioConsulta VARCHAR(255) NULL,
    linkAnamnese VARCHAR(255) NULL,
    idAnamnese VARCHAR(255) NULL,
    linkFotoDeFundo VARCHAR(255) NULL
);
GO
-- Table Consulta
CREATE TABLE Consulta (
    id CHAR(36) NOT NULL PRIMARY KEY,
    avaliacao VARCHAR(255) NULL,
    nota DECIMAL(2,1) NULL,
    dtCriacao DATETIME NULL,
    idPac CHAR(36) NOT NULL,
    idPsi CHAR(36) NOT NULL,
    linkMeet VARCHAR(255) NULL,
    linkAnamnese VARCHAR(255) NULL,
    inicio DATETIME NULL,
    fim DATETIME NULL,
    idAnamnese VARCHAR(255) NULL,
    CONSTRAINT fk_Avaliacao_Usuario1 FOREIGN KEY (idPac) REFERENCES Usuario(id),
    CONSTRAINT fk_Avaliacao_Usuario2 FOREIGN KEY (idPsi) REFERENCES Usuario(id)
);
GO
-- Table Especialidade
CREATE TABLE Especialidade (
    id CHAR(36) NOT NULL PRIMARY KEY,
    Descricao VARCHAR(255) NOT NULL,
    Titulo VARCHAR(45) NOT NULL
);
GO
-- Table ExperienciaFormacao
CREATE TABLE ExperienciaFormacao (
    id CHAR(36) NOT NULL PRIMARY KEY,
    DataInicio DATE NOT NULL,
    DataFim DATE NULL,
    Instituicao VARCHAR(255) NOT NULL,
    Cargo VARCHAR(255) NULL,
    Descricao VARCHAR(255) NOT NULL,
    Tipo VARCHAR(255) NULL,
    Titulo VARCHAR(255) NULL,
    usuario CHAR(36) NOT NULL,
    CONSTRAINT fk_ExperienciaFormacao_Usuario FOREIGN KEY (usuario) REFERENCES Usuario(id)
);
GO
-- Table Endereço
CREATE TABLE Endereço (
    id INT NOT NULL PRIMARY KEY,
    cep VARCHAR(9) NULL,
    rua VARCHAR(122) NULL,
    estado VARCHAR(122) NULL,
    cidade VARCHAR(122) NULL,
    usuario CHAR(36) NOT NULL,
    CONSTRAINT fk_Endereço_Usuario1 FOREIGN KEY (usuario) REFERENCES Usuario(id)
);
GO
-- Table EspecialidadeUsuario
CREATE TABLE EspecialidadeUsuario (
    especialidade CHAR(36) NOT NULL,
    usuario CHAR(36) NOT NULL,
    PRIMARY KEY (especialidade, usuario),
    CONSTRAINT fk_Especialidade_has_Usuario_Especialidade1 FOREIGN KEY (especialidade) REFERENCES Especialidade(id),
    CONSTRAINT fk_Especialidade_has_Usuario_Usuario1 FOREIGN KEY (usuario) REFERENCES Usuario(id)
);
GO