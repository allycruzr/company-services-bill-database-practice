DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE contrato CASCADE CONSTRAINTS;
DROP TABLE fatura CASCADE CONSTRAINTS;
DROP TABLE SERVICO CASCADE CONSTRAINTS;
DROP TABLE SERVICO_CONTRATADO CASCADE CONSTRAINTS;
DROP TABLE DETALHE_FATURA CASCADE CONSTRAINTS;
DROP TABLE tecnico CASCADE CONSTRAINTS;
DROP TABLE ASSISTENCIA_TECNICA CASCADE CONSTRAINTS;

create table CLIENTE (
  ID_CLIENTE        NUMBER(10)          not null,
  NOME                              VARCHAR2(500)       not null,
  MORADA            VARCHAR2(500)       not null,
  CODIGO_POSTAL            VARCHAR2(8)                        not null,
  NIF                                VARCHAR2(15)                not null,
  TELEFONE_FIXO                 VARCHAR2(15)                        ,
  TELEFONE_MOVEL        VARCHAR2(15)                ,
  GENERO                        CHAR(1)                                not null,
  DATA_NASCIMENTO        date                                 not null,
  DATA_DE_ADESAO        DATE                                 default sysdate not NULL, 

        constraint CLIENTE_PK                                 primary key (ID_CLIENTE),
        constraint CLIENTE_UK                                 unique (NIF),
        constraint CLIENTE_GENERO_CK                check (GENERO in ('F','M','O')),
        constraint CLIENTE_ALDULTO_CK             CHECK (MONTHS_BETWEEN(data_de_adesao, data_nascimento) /12 >=18)
);

create table CONTRATO (
   ID_CONTRATO                                                                                NUMBER(10)          not null,
   ID_CLIENTE                                                                                      NUMBER(10)          not null,
   DATA_INICIO                                                                                            DATE                                not null,
   DATA_FIM                                                                                               DATE                                              ,
   OBSERVACOES                                                                                            VARCHAR2(3000)                                ,

                   CONSTRAINT CONTRATO_PK                                          PRIMARY KEY (ID_CONTRATO),
                   constraint CONTRATO_CK                                  check (DATA_INICIO <= DATA_FIM)
);

create table FATURA (
        ID_FATURA                                                                                  NUMBER(10)                not null,
        ID_CONTRATO                                                                                           NUMBER(10)      not null,
        VALOR_TOTAL                                                                                           NUMBER(20,3)           not null,
        DATA_EMISSAO                                                                                    DATE                        not null,
        DATA_LIMITE_DE_PAGAMENTO                                                         DATE                        NOT NULL,
        data_do_pagamento                                   DATE                    ,
        DESCRICAO_FATURA                                                                    VARCHAR2(3000)                        ,

                CONSTRAINT fatura_PK                                          PRIMARY KEY(ID_FATURA),
                constraint FATURA_CK                                             check ( (data_emissao + 20) < data_limite_de_pagamento )
);

create table SERVICO (
        ID_SERVICO                          NUMBER(10)                          not null,
        NOME                                                   VARCHAR2(200)                   not null,
        DESCRICAO                                           VARCHAR2(500)                    ,
        CUSTO_REFERENCIA_MENSAL         NUMBER(20, 3)                            not null,
        
                CONSTRAINT ID_SERVICO_PK PRIMARY KEY(ID_SERVICO)
);

create table SERVICO_CONTRATADO (
        ID_CONTRATO                                     NUMBER(10)           not null,
        ID_SERVICO                                      NUMBER(10)           not null,
        CUSTO_MENSAL                                          NUMBER(20, 3)                 not NULL,

                CONSTRAINT SERVICO_CONTRATADO_PK PRIMARY KEY (ID_CONTRATO, ID_SERVICO)
);

create table DETALHE_FATURA (
        ID_FATURA           NUMBER(10)                    not null,
        ID_LINHA_FATURA     NUMBER(10)                    not null,
        ID_CONTRATO         NUMBER(10)                    not null,
        ID_SERVICO          NUMBER(10)                    not null,
        VALOR                 NUMBER(20,3)                                  not null,
        OBSERVACOES                 VARCHAR2(3000)
);

create table TECNICO (
        ID_TECNICO          NUMBER(10)            not null,
        NOME                VARCHAR2(200)   not null,
        TELEFONE             VARCHAR2(15),
        
                CONSTRAINT id_tecnico_pk primary KEY(id_tecnico)
);

create table ASSISTENCIA_TECNICA (
        ID_CONTRATO         NUMBER(10)              not null,
        ID_SERVICO                 NUMBER(10)              not null,
        ID_TECNICO                 NUMBER(10)              not null,
        DATA_HORA_INICIO    DATE                    not null,
        DATA_HORA_FIM            DATE                    not null,
        OBSERVACOES                 VARCHAR2(3000),

                constraint                 CK_ASSISTENCIA_TECNICA         check (DATA_HORA_INICIO < DATA_HORA_FIM)        
);

--10 clientes
INSERT INTO CLIENTE
VALUES (0,'Bernardo','Loureslt41', '4448', '789', '218655825', '901524788','M',to_date('1980-05-12', 'yyyy-mm-dd'), DEFAULT);
INSERT INTO CLIENTE values(1,'nome1','Avenida de Madrid Lote 45, 3Dt', '21900126', 'nif1', 'fixo1', 'movel1','M',to_date('1980-02-03','yyyy-mm-dd'), DEFAULT);
INSERT INTO CLIENTE values(2,'nome2','Avenida de Madrid Lote 45, 5Dt', 'cp2', 'nif2', 'fixo2', 'movel2','O',to_date('1980-02-03','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(3,'nome3','morada3', 'cp3', 'nif3', 'fixo3', 'movel3','F',to_date('1980-02-12','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(4,'nome4','morada4', 'cp4', 'nif4', 'fixo4', 'movel4','M',to_date('1990-04-25','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(5,'nome5','morada5', 'cp5', 'nif5', null, 'movel5','O',to_date('1990-05-25','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(6,'nome6','morada6', 'cp6', 'nif6', null, null,'F',to_date('1990-06-25','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(7,'nome7','morada7', 'cp7', 'nif7', 'fixo7', 'movel7','M',to_date('1990-07-25','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(8,'nome8','morada8', 'cp8', 'nif8', 'fixo8', 'movel8','O',to_date('1990-08-12','yyyy-mm-dd'),DEFAULT);
INSERT INTO CLIENTE values(9,'Allyson','morada9', 'cp9', 'nif130', 'fixo9', 'movel9','F',to_date('1990-09-12','YYYY-MM-DD'),DEFAULT);


--10 serviços
INSERT INTO SERVICO values(0, 'free', 'sem carregamentos', 0.00);
INSERT INTO SERVICO values(1, 'low', '5++', 5.01);
INSERT INTO SERVICO values(2, 'tv', 'so tv', 17.02);
INSERT INTO SERVICO values(3, 'total sms', 'so sms', 3.99);
INSERT INTO SERVICO values(4, 'net 5+', '5gb ', 6);
INSERT INTO SERVICO values(5, 'net 10+', '10gb', 11);
INSERT INTO SERVICO values(6, '100% novel', 'dados ilimitados ', 40);
INSERT INTO SERVICO values(7, 'nao dorme', 'sem restriçoes das 24:00 as 08:00', 30.55);
INSERT INTO SERVICO values(8, 'sol', 'todos os serviços dia', 0);
INSERT INTO SERVICO values(9, 'vip', 'todos os serviços qualquer hora!', 99.99);


----10 tecnicos
INSERT INTO tecnico values(0,'bernardo','91547858');
INSERT INTO tecnico values(1,'joao','91547456');
INSERT INTO tecnico values(2,'patricia','44548666');
INSERT INTO tecnico values(3,'jose','456586868');
INSERT INTO tecnico values(4,'ricardo','91548658');
INSERT INTO tecnico values(5,'ana','91577758');
INSERT INTO tecnico values(6,'antonio','99947858');
INSERT INTO tecnico values(7,'maria','91547118');
INSERT INTO tecnico values(8,'vitor','91547811');
INSERT INTO tecnico values(9,'Allyson','937019152');



/*
--Apenas temos linhas dentro dos géneros permitidos
select GENERO from cliente where GENERO  in ('F','M','O'); 

--Não há NIFs repetidos dentro dos clientes (use apenas os comandos que aprendeu)
select DISTINCT NIF from cliente;

--Os clientes têm 18 ou mais anos
select  TRUNC(MONTHS_BETWEEN (to_char(DATA_DE_ADESAO),to_char(DATA_NASCIMENTO))/12) "Idades de todos os clientes" FROM cliente; 

--Apenas um cliente nasceu no dia 1980-02-12
select * from Cliente where DATA_NASCIMENTO=to_date('1980-02-12','YYYY-MM-DD'); 

--Foram inseridos os 10 serviços que são todos diferentes
select DISTINCT * from SERVICO;

--Foram inseridos os 10 técnicos que são todos diferentes
select DISTINCT * from tecnico;

--Altere a data de nascimento do cliente que nasceu a 3 de fevereiro de 1980 para 4 de maio de 1981
update CLIENTE c 
SET DATA_NASCIMENTO = To_date('1981-05-04','YYYY-MM-DD') where DATA_NASCIMENTO= to_date('1980-02-03','YYYY-MM-DD');

--Altere a morada de todos os clientes que vivem na Avenida de Madrid Lote 45 para a mesma avenida, 
--nº 14, mantendo os respetivos andares. Por exemplo, se a morada era“Av. de Madrid Lote 45, 3ºB”a 
--morada passa para “Av. de Madrid, nº14, 3ºB”
update CLIENTE c SET morada = REPLACE(MORADA, 'Avenida de Madrid Lote 45', 'Av. de Madrid, nº 14 ')
WHERE morada LIKE ('Avenida de Madrid Lote 45%');

--verificação de mudança na morada

SELECT morada FROM cliente WHERE morada LIKE ('Av%');

DELETE FROM CLIENTE WHERE DATA_NASCIMENTO = to_date('1980-02-12', 'yyyy-mm-dd');

*/


-- ************************ ETAPA 2 ************************

-- Criação dos relacionamentos entre as tabelas
alter table contrato 
add constraint CONTRATO_FK1                         foreign key (ID_CLIENTE)
references CLIENTE(ID_CLIENTE);

ALTER TABLE SERVICO_CONTRATADO
ADD CONSTRAINT SERVICO_CONTRATADO_FK1 FOREIGN KEY (ID_CONTRATO)
REFERENCES CONTRATO (ID_CONTRATO);

ALTER TABLE SERVICO_CONTRATADO
ADD CONSTRAINT SERVICO_CONTRATADO_FK2 FOREIGN KEY (ID_SERVICO)
REFERENCES SERVICO (ID_SERVICO);

alter table  FATURA 
add constraint FATURA_FK1                             foreign key(ID_CONTRATO)
references CONTRATO(ID_CONTRATO) ;

ALTER TABLE DETALHE_FATURA
ADD CONSTRAINT DETALHE_FATURA_FK1 FOREIGN KEY (ID_FATURA)
REFERENCES FATURA(ID_FATURA);

ALTER TABLE DETALHE_FATURA
ADD CONSTRAINT DETALHE_FATURA_FK2 FOREIGN KEY (ID_CONTRATO, ID_SERVICO)
REFERENCES SERVICO_CONTRATADO (ID_CONTRATO, ID_SERVICO);

ALTER TABLE ASSISTENCIA_TECNICA
ADD CONSTRAINT ASSISTENCIA_TECNICA_FK1 FOREIGN KEY (ID_CONTRATO, ID_SERVICO)
REFERENCES SERVICO_CONTRATADO (ID_CONTRATO, ID_SERVICO);

ALTER TABLE ASSISTENCIA_TECNICA
ADD CONSTRAINT ASSISTENCIA_TECNICA_FK2 FOREIGN KEY (ID_TECNICO)
REFERENCES TECNICO (ID_TECNICO);        

-- Cada cliente tem um contrato

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (999, 0, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 0)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (998, 1, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 1)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (997, 2, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 2)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (996, 4, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 4)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (995, 5, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 5)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (994, 6, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 6)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (993, 7, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 7)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (992, 8, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 8)
                        ),
null, null );

INSERT INTO CONTRATO (id_contrato, ID_CLIENTE, DATA_INICIO, DATA_FIM, OBSERVACOES) 
VALUES (991, 9, to_date(
                        (SELECT data_de_adesao 
                          FROM cliente c 
                          WHERE c.ID_CLIENTE = 9)
                        ),
null, null );
                     

-- Serviço contratado: todos os contratos têm 2 serviços contratados e um deles tem pelo menos 3;

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (999,1, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 1)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (999,2, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 2)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (998,3, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 3)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (998,4, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 4)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (997,3, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 3)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (997,5, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 5)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (996,3, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 3)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (996,4, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 4)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (995,7, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 7)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (995,5, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 5)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (994,8, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 8)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (994,4, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 4)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (993,3, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 3)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (993,6, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 6)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (992,3, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 3)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (992,4, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 4)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (991,0, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 0)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (991,1, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 1)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (991,4, (SELECT custo_referencia_mensal 
                FROM servico s 
                WHERE s.id_servico = 4)
);

INSERT INTO SERVICO_CONTRATADO (id_contrato, id_servico, custo_mensal)
VALUES (991,5, (SELECT 
                                custo_referencia_mensal 
                                FROM servico s 
                                WHERE s.id_servico = 5)
);


/* 
 * Todos os serviços são contratos por clientes, exceto um serviço que ninguém contratou; 
 * O custo mensal de cada serviço contratado é igual ao custo de referência mensal
 * do respetivo serviço;
 * */

-- Serviço 'vip' de ID 9 não será contratado por ninguém.
        
-- Fatura: todos os serviços *CONTRATADOS* têm uma fatura no mês de outubro. Deixe o campo valor total de fatura zero.

INSERT INTO FATURA (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (001, 999, 0, to_date('2019-10-01', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, 'Fatura xyz'); 

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (002, 998, 0, to_date('2018-10-03', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (003, 997, 0, to_date('2017-10-02', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (004, 996, 0, to_date('2016-10-04', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (005, 995, 0, to_date('2015-10-01', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (006, 994, 0, to_date('2014-10-05', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (007, 993, 0, to_date('2013-10-09', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (008, 992, 0, to_date('1999-02-07', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);

INSERT INTO fatura (id_fatura, ID_CONTRATO, VALOR_TOTAL, DATA_EMISSAO, DATA_LIMITE_DE_PAGAMENTO, DATA_DO_PAGAMENTO, DESCRICAO_FATURA)
VALUES (009, 991, 0, to_date('1999-02-08', 'yyyy-mm-dd'), to_date('2019-10-30', 'yyyy-mm-dd'), null, null);


-- Detalhe de fatura: cada fatura tem uma linha de detalhe para os serviços contratados pelo cliente. 
-- O valor do detalhe da fatura deverá ser igual ao valor do respetivo serviço, exceto para duas linhas à sua escolha, que deverão apresentar um valor superior.
        
INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (001, 001, 999, 1, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 1)+1, null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (001, 002, 999, 2, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 2), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (002, 001, 998, 3, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 3), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (002, 002, 998, 4, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 4), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (003, 001, 997, 3, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 3), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (003, 002, 997, 5, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 5), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (004, 001, 996, 3, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 3), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (004, 002, 996, 4, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 4), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (005, 001, 995, 5, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 5), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (005, 012, 995, 7, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 7), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (006, 001, 994, 4, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 4), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (006, 002, 994, 8, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 8), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (007, 001, 993, 3, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 3), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (007, 002, 993, 6, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 6), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (008, 001, 992, 3, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 3), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (008, 002, 992, 4, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 4), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (009, 001, 991, 0, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 0), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (009, 002, 991, 1, (SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 1), null);

INSERT INTO DETALHE_FATURA (id_fatura, ID_LINHA_FATURA, ID_CONTRATO, ID_SERVICO, valor, OBSERVACOES)
VALUES (009, 005, 991, 4, ((SELECT custo_referencia_mensal FROM servico s WHERE s.ID_SERVICO = 4)+1), null);



-- Assistência técnica: 3 serviços de assistência técnica com duração de 1,3 e 5 
 
INSERT INTO ASSISTENCIA_TECNICA (id_contrato, ID_SERVICO, ID_TECNICO, DATA_HORA_INICIO, DATA_HORA_FIM, OBSERVACOES)
VALUES (991, 4, 9, to_date('09:45:00 2019-05-01', 'hh24:mi:ss yyyy-mm-dd'), to_date('10:45:00 2019-05-01', 'hh24:mi:ss yyyy-mm-dd'), 'Nada a observar');

INSERT INTO ASSISTENCIA_TECNICA (id_contrato, ID_SERVICO, ID_TECNICO, DATA_HORA_INICIO, DATA_HORA_FIM, OBSERVACOES)
VALUES (992, 4, 9, to_date('13:29:00 2019-05-01', 'hh24:mi:ss yyyy-mm-dd'), to_date('16:29:00 2019-05-01', 'hh24:mi:ss yyyy-mm-dd'), 'Nada a observar');

INSERT INTO ASSISTENCIA_TECNICA (id_contrato, ID_SERVICO, ID_TECNICO, DATA_HORA_INICIO, DATA_HORA_FIM, OBSERVACOES)
VALUES (993, 6, 9, to_date('13:10:00 2019-05-02', 'hh24:mi:ss yyyy-mm-dd'), to_date('18:10:00 2019-05-02', 'hh24:mi:ss yyyy-mm-dd'), 'Nada a observar');

--SELECT * FROM ASSISTENCIA_TECNICA;

-- Mostre o nome e NIF do cliente assim como o número de serviços contratados por cada cliente. Um dos clientes deverá ter mais que 2 serviços contratados;

SELECT cli.nome, 
           cli.nif,
           (SELECT count(id_servico) 
                   FROM SERVICO_CONTRATADO sc 
                   WHERE sc.id_contrato LIKE con.id_contrato) 
                   AS NUMERO_SERVICOS_CONTRATADOS
FROM 
        CLIENTE cli
INNER JOIN 
        CONTRATO con on (cli.ID_CLIENTE = con.ID_CLIENTE);



-- Mostre que há um serviço que não foi contratado por nenhum cliente;
        
SELECT s.nome, count(sc.id_servico) as numero_contratacoes
FROM 
    servico s
left JOIN servico_contratado sc ON (s.id_servico=sc.id_servico) 
group by s.nome
HAVING COUNT(sc.ID_SERVICO) = 0
order by numero_contratacoes;

-- Mostre que TODOS OS SERVIÇOS CONTRATADOS foram faturados no mês de outubro;
--Consideramos aqui todos os serviços contratados mesmo sem distinção e os respectivos contratos a que pertence o serviço contratado.

SELECT DISTINCT sc.ID_SERVICO,
           --f.id_fatura,            
           (to_char(f.DATA_EMISSAO, 'DD-mon-YYYY')) AS "DATA DE FATURAÇÃO",
           f.id_contrato 
FROM 
        fatura f
INNER JOIN 
        SERVICO_CONTRATADO sc ON (f.ID_CONTRATO = sc.id_contrato)
ORDER BY sc.ID_SERVICO;

/*
Seria últil para mostrar que cada serviço (dos que foram contratados) possuem pelo menos uma fatura em Outubro.
   SELECT DISTINCT sc.ID_SERVICO,
           --f.id_fatura, 
           --f.id_contrato, 
           (to_char(DATA_EMISSAO, 'MONTH')) AS MES_FATURAÇÃO_DO_SERVIÇO
FROM 
        fatura f
INNER JOIN 
        SERVICO_CONTRATADO sc ON (f.ID_CONTRATO = sc.id_contrato)
ORDER BY sc.ID_SERVICO;
*/

-- Mostre quanto vai pagar cada cliente no mês de outubro;

SELECT cli.id_cliente,
           cli.nif,
           (SELECT sum(valor) 
                   FROM DETALHE_FATURA df
                   WHERE df.id_contrato LIKE con.id_contrato)
                   AS VALOR_A_PAGAR_OUTUBRO
FROM 
        CLIENTE cli
INNER JOIN 
        CONTRATO con on cli.ID_CLIENTE = con.ID_CLIENTE
INNER JOIN        
        fatura f ON f.id_contrato = con.ID_CONTRATO AND f.DATA_EMISSAO >= to_char('01-10-2019') AND f.DATA_EMISSAO <= to_char('31-10-2019');


-- Mostre o tempo médio, máximo e mínimo nas assistências técnicas;

SELECT avg(AT.data_hora_fim - AT.data_hora_inicio) * 24 AS TEMPO_MEDIO_HORAS,
           max(AT.data_hora_fim - AT.data_hora_inicio) * 24 AS TEMPO_MAXIMO_HORAS,
           min(AT.data_hora_fim - AT.data_hora_inicio) * 24 AS TEMPO_MINIMO_HORAS
FROM ASSISTENCIA_TECNICA at;

-- Mostre quais os clientes que vão pagar serviços em outubro acima do custo mensal de referência para esse contrato;

SELECT ID_CLIENTE, nif from(
        SELECT cli.id_cliente,
           cli.nif,
           (SELECT sum(valor) 
                   FROM DETALHE_FATURA df
                   WHERE df.id_contrato LIKE con.id_contrato)
                   AS VALOR_A_PAGAR_OUTUBRO,
                   (SELECT sum(custo_referencia_mensal) 
                   FROM SERVICO s, SERVICO_CONTRATADO sc
                   WHERE s.id_servico LIKE sc.id_servico
                           AND con.id_contrato like sc.id_contrato
                           AND s.id_servico LIKE sc.id_servico)
                   AS VALOR_REFERENCIA
FROM 
        CLIENTE cli
INNER JOIN 
        CONTRATO con on cli.ID_CLIENTE = con.ID_CLIENTE
INNER JOIN        
        fatura f ON f.id_contrato = con.ID_CONTRATO AND f.DATA_EMISSAO >= to_char('01-10-2019') AND f.DATA_EMISSAO <= to_char('31-10-2019')
)
WHERE VALOR_A_PAGAR_OUTUBRO > VALOR_REFERENCIA;

commit;

select * from fatura;

-----------------------------------------------------------
