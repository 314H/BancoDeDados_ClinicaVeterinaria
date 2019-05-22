=======================LBD=======================

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
	CONSTRAINT CK_ANIMAIS_ANONASC CHECK (ano_Nascimento > 1969)

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

CREATE TABLE VETERINARIOSANIMAIS
(
	cod_paciente NUMBER (5) NOT NULL, --tabela para a relação N-N entre animais e veterinarios. N animais → N veterinarios
	crv NUMBER (5) NOT NULL,
	id NUMBER(4) NOT NULL --UNIQUE
	
	CONSTRAINT PK_VETANI_CRV_CODPAC PRIMARY KEY (cod_pac, crv),
	CONSTRAINT AK_VETUNI_ID UNIQUE (id)
	
)

CREATE TABLE ATENDIMENTOS															
(																					
	cod_atendimento NUMBER (5) NOT NULL, --Primary Key/
	dataHora DATE NOT NULL,
	diagnostico VARCHAR (1000) NOT NULL,
	crv_atendente NUMBER (5) NOT NULL, --Foreign Key para veterinarios
	cod_paciente NUMBER (5) NOT NULL, --Foreign Key para animais
	exame CHAR(1) NOT NULL,
	-- id_relacao NUMBER(4) NOT NULL // fk ID VETANI
	
	CONSTRAINT PK_ATENDIMENTOS_CODATE PRIMARY KEY (cod_atendimento),
	CONSTRAINT AK_ATENDIMENTOS_DATA_CRV UNIQUE (dataHora, crv),
	CONSTRAINT AK_ATENDIMENTOS_DATA_CODPAC UNIQUE (dataHora, cod_paciente)
	-- CONSTRAINT FK_ATENDIMENTOS_ANIMAIS nome_animal REFERENCES ANIMAIS (nome)
	-- CONSTRAINT FK_ATENDIMENTOS_VETERINARIOS crv_atendente REFERENCES VETERINARIOS (crv)
	-- CONSTRAINT AK_ANIMAIS 
	--
)																					

CREATE TABLE EXAMES
(
	cod_atendimento NUMBER (5) NOT NULL, --Foreign Key referenciando atendimentos. 1 atendimento → N exames
	cod_exame NUMBER (5) NOT NULL, --Primary Key/Foreign Key referenciando tiposexames. 1 tipo → N exames
	valor_praticado NUMERIC (8, 2) NOT NULL,
	
	CONSTRAINT PK_EXAMES_CODEX PRIMARY KEY (cod_exame)

)

CREATE TABLE TIPOSEXAMES 
(
	cod_exame NUMBER (5) NOT NULL, --Primary Key
	tipo VARCHAR (100) NOT NULL, --UNIQUE
	descricao VARHCAR (1000) NOT NULL,
	valor_tabelado NUMERIC (8, 2) NOT NULL

	CONSTRAINT PK_TIPOEXAMES_CODEX PRIMARY KEY (cod_exame),
	CONSTRAINT AK_TIPOEXAME_TIPO UNIQUE (tipo)
)









