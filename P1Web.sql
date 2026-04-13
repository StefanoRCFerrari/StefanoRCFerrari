/* Cria o banco de dados dbLocadora */
create database dbLocadora; 

/* Seleciona o banco dbLocadora */ 
use dbLocadora; 

/* Cria a tabela tbCategorias */ 
create table tbCategorias( 
idCategoria int NOT NULL AUTO_INCREMENT PRIMARY KEY,
nomeCategoria varchar(30) NOT NULL);

/* Cria a tabela */ 
create table tbFilmes( 
idFilme int NOT NULL AUTO_INCREMENT PRIMARY KEY,
tituloFilme varchar(100)  NOT NULL, 
duracaoFilme varchar(10) NOT NULL,
valorLocacao decimal(10,2) NOT NULL,
idCategoria  int FOREIGN KEY)
 
/* Insere dados na tabela tbFilmes */ 
INSERT INTO tbfilmes ( 

idFilme,tituloFilme,duracaoFilme,valorLocacao,idCategoria) 
VALUES 
(1,'Exterminador do Futuro','1:30',3.50,1), 
(2,'Indiana Jones','2:00',3.00,2), 
(3,'Rambo 2','2:30',3.00,1), 
(4,'Star Wars','1:45',3.00,3), 
(5,'Sexta-feira 13','2:10',3.00,4), 
(6,'Jornada nas Estrelas','1:60',3.00,3), 
(7,'O silêncio dos Inocentes','2:00',1.50,5), 
(8,'Freddy krueger','2:00',1.50,4), 
(9,'Comando para Matar','2:00',1.50,1), 
(10,'Connan o Barbaro','1:90',1.50,1), 
(11,'Missão: Impossivel','1:90',2.00,1), 
(12,'O Chamado','1:80',2.00,4), 
(13,'Hellboy','1:85',3.00,1), 
(14,'O sexto sentido','1:47',2.00,5), 
(15,'Cisne Negro','1:43',2.50,5), 
(16,'O senhor dos Anéis','3:20',3.00,2); 

/* Insere dados na tabela tbCategorias */ 
INSERT INTO tbCategorias(idCategoria, nomeCategoria) 
VALUES 
(NULL , 'Ação'), 
(NULL , 'Aventura'), 
(NULL , 'Ficção Cientifica'), 
(NULL , 'Terror'), 
(NULL , 'Suspense');