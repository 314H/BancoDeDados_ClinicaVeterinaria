=======================LBD=======================



REMOVER VETANIMAIS E FAZER FK DOS DADOS NA TABELA DE ATENDIMENTOS


--A clinica recebe diversos clientes e cada cliente pode ter vários animais.

--C = Cliente 
--A = Animal

  -------------------
--|					|	
--|    Clinica		|
--|     ↓ ↓ ↓		|
--|     C C C		| →	FK - referenciando a clinica vindo da tabela clientes CONSTRAINT FK_CLINICA FOREIGN KEY (...) REFERENCES CLINICA (...) 
--|     ↓ ↓ ↓		|
--|     A A A		| → FK - referenciando os clientes vindo dos animais CONSTRAINT FK_CLIENTE FOREIGN KEY (...) REFERENCES CLIENTES (...)
--|					| 
  -------------------

--Vet - Animais N-N																																							)

CREATE TABLE CLIENTES 
(
	cpf NUMBER (11) NOT NULL, --Primary key
	nome VARCHAR (100) NOT NULL,
	sobrenome VARCHAR (100) NOT NULL,
	email VARCHAR (100) NULL, --UNIQUE
	data_nascimento DATE NOT NULL, --CHECK
	convenio CHAR(1) NOT NULL,
	cad_ativo CHAR(1) NOT NULL
	
	CONSTRAINT PK_CLIENTES_CPF PRIMARY KEY (cpf),
	CONSTRAINT AK_CLIENTES_EMAIL UNIQUE (email),
	CONSTRAINT CK_CLIENTES_DATANASC CHECK ((EXTRACT (YEAR FROM DATE 'data_Nascimento') > 1919) 
)


CREATE TABLE ANIMAIS
(
	especie VARCHAR (100) NOT NULL,
	raca VARCHAR (100) NOT NULL,
	nome VARCHAR (100) NOT NULL, 
	ano_nascimento NUMBER (4) NOT NULL, --CHECK
	dono_cpf NUMBER (11) NOT NULL, --Foreign Key para cpf do cliente - 1 cliente → N animais.
	cod_paciente NUMBER (5) NOT NULL -- Primary Key
	
	CONSTRAINT PK_ANIMAIS_CODPAC PRIMARY KEY (cod_paciente),
	CONSTRAINT CK_ANIMAIS_ANONASC CHECK (ano_Nascimento > 1969),
	CONSTRAINT FK_CLIENTE_ANIMAIS FOREIGN KEY (dono_cpf) REFERENCES CLIENTES (cpf) 

)

CREATE TABLE VETERINARIOS
(																					
	crv NUMBER (5) NOT NULL, --Primary Key
	nome VARCHAR (100) NOT NULL,
	email VARCHAR (50) NOT NULL, --UNIQUE
	plantonista CHAR (1) NOT NULL, --'s' ou 'n'
	
	CONSTRAINT PK_VETERINARIOS_CRV PRIMARY KEY (crv),
	CONSTRAINT AK_VETERIANRIOS_EMAIL UNIQUE (email)
)

CREATE TABLE ATENDIMENTOS															
(																					
	cod_atendimento NUMBER (5) NOT NULL, --Primary Key/
	dataHora DATE NOT NULL,
	diagnostico VARCHAR (1000) NOT NULL,
	crv_atendente NUMBER (5) NOT NULL, --Foreign Key para veterinarios
	cod_paciente NUMBER (5) NOT NULL, --Foreign Key para animais
	exame CHAR(1) NOT NULL,
	
	CONSTRAINT PK_ATENDIMENTOS_CODATE PRIMARY KEY (cod_atendimento),
	CONSTRAINT AK_ATENDIMENTOS_DATA_CRV UNIQUE (dataHora, crv),
	CONSTRAINT AK_ATENDIMENTOS_DATA_CODPAC UNIQUE (dataHora, cod_paciente)
	CONSTRAINT FK_ATENDIMENTOS_ANIMAIS (cod_paciente) REFERENCES ANIMAIS (cod_paciente)
	CONSTRAINT FK_ATENDIMENTOS_VETERINARIOS crv_atendente REFERENCES VETERINARIOS (crv)
)																					

CREATE TABLE EXAMES
(
	cod_atendimento NUMBER (5) NOT NULL, --Foreign Key referenciando atendimentos. 1 atendimento → N exames
	cod_exame NUMBER (5) NOT NULL, --Primary Key/Foreign Key referenciando tiposexames. 1 tipo → N exames
	valor_praticado NUMERIC (8, 2) NOT NULL,
	
	CONSTRAINT PK_EXAMES_CODEX PRIMARY KEY (cod_exame),
	CONSTRAINT FK_EXAMES_ATENDIMENTOS FOREIGN KEY (cod_atendimento) REFERENCES ATENDIMENTOS (cod_atendimento)

)

CREATE TABLE TIPOSEXAMES 
(
	cod_exame NUMBER (5) NOT NULL, --Primary Key
	tipo VARCHAR (100) NOT NULL, --UNIQUE
	descricao VARHCAR (1000) NOT NULL,
	valor_tabelado NUMERIC (8, 2) NOT NULL

	CONSTRAINT PK_TIPOEXAMES_CODEX PRIMARY KEY (cod_exame),
	CONSTRAINT AK_TIPOEXAME_TIPO UNIQUE (tipo),
	CONSTRAINT FK_TIPO_EXAMES FOREIGN KEY (cod_exame) REFERENCES EXAMES (cod_exame)
)

INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (03899869057, 'Arthur', 'Maciel Gomes', 'arthur.maciel@edu.pucrs.br', DATE '2001-05-16', 'S', 'S');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (38703854921, 'Marina', 'Moreira', 'marina.moreira@edu.pucrs.br', DATE '1998-07-20', 'N', 'N');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (44966018020, 'Thaís', 'Fernandes', 'thais.fernandes@edu.pucrs.br', DATE '1998-12-11', 'N', 'S');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (15849236717, 'João', 'das Neves', 'joaostark@outlook.com', DATE '1919-12-25', 'S', 'N');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (56481397258, 'Daiane', 'Targânia', 'arthur.maciel@edu.pucrs.br', DATE '2001-05-16', 'S', 'S');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (38755102937, 'Gabriel', 'Moura', 'moura.gabriel@gmail.com', DATE '2000-08-28', 'S', 'N');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (88955063410, 'Alana', 'Fernandes', 'alaninha.fernandes@gmail.com', DATE '1975-02-19', 'N', 'S');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (35795140682, 'Camilla', 'Oliveira', 'camilla.oli98@hotmail.com', DATE '1998-07-21', 'S', 'S');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (68410315794, 'Giovanni', 'Madalozzo', 'madgio@yahoo.com.br', DATE '1996-05-11', 'N', 'N');
\
INSERT INTO CLIENTES (cpf, nome, sobrenome, email, data_nascimento, convenio, cad_ativo)
VALUES (23144824730, 'Arthur', 'Maciel Gomes', 'arthur.maciel@edu.pucrs.br', DATE '2001-05-16', 'S', 'S');







