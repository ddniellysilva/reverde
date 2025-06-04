CREATE TABLE Usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL CHECK (
    email REGEXP '^[a-zA-Z0-9._%+-]+@(gmail\\.com|outlook\\.com|hotmail\\.com)$'
  ),
  senha VARCHAR(255) NOT NULL CHECK (
    senha REGEXP '^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-={}\\[\\]|;:\\"<>,.?/]).{6,}$'
  )
);

CREATE TABLE Habito (
  id_habito INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT,
  pontuacao INT NOT NULL
);

CREATE TABLE PerguntaValidacao (
  id_pergunta INT AUTO_INCREMENT PRIMARY KEY,
  id_habito INT,
  pergunta TEXT NOT NULL,
  resposta_correta VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_habito) REFERENCES Habito(id_habito)
);

CREATE TABLE RegistroHabito (
  id_registro INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_habito INT,
  data_registro DATE NOT NULL,
  validado BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_habito) REFERENCES Habito(id_habito)
);

CREATE TABLE QuizTentativa (
  id_tentativa INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_pergunta INT,
  resposta_usuario VARCHAR(255),
  correta BOOLEAN,
  data_tentativa DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_pergunta) REFERENCES PerguntaValidacao(id_pergunta)
);

CREATE TABLE EcoPontos (
  id_ponto INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  total_pontos INT DEFAULT 0,
  atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Certificados (
  id_certificado INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_ponto INT,
  descricao TEXT,
  certificado LONGBLOB, -- para armazenar imagem do certificado
  data_geracao DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_ponto) REFERENCES EcoPontos(id_ponto)
);
