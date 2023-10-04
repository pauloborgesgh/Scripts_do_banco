CREATE TABLE Aluno(
idaluno int  not null,
matricula varchar(20) not null,
nome varchar(50)not null,
PRIMARY KEY (idaluno)
);
CREATE TABLE Disciplina(
iddisciplina int not null,
nome varchar(50)not null,
cargahorario int not null,
primary key(iddisciplina)
);
create table Curso (
idCurso int not null,
nome varchar(50)not null,
primary key(idCurso)
);
create table Grade(
idGrade int not null,
idCurso int not null,
ano int not null,
cargaHorariaTotal int not null,
primary key(idGrade),
foreign KEY(idCurso) references Curso (idCurso)
);
create	table GradeDisciplina(
idGrade int not null,
iddisciplina int not null,
foreign key (iddisciplina) references Disciplina(iddisciplina)
);
CREATE TABLE AlunoCurso (
idaluno int not null,
idcurso integer not null,
anoEntrada int not null,
foreign key (idaluno) references Aluno(idaluno),
foreign key (idCurso) references Curso(idCurso)
);
CREATE TABLE Historico(
idaluno int not null, 
iddisciplina int not null,
nota float not null,
dataHistorico date not null,
foreign key (idaluno)references Aluno (idaluno) ,
foreign key (iddisciplina)references Disciplina (iddisciplina)
);

ChatGPT
Vou fornecer as consultas SQL para cada uma das suas solicitações:

2. Consulta para listar o quantitativo de cursos existentes:

sql
Copy code
SELECT COUNT(*) AS QuantidadeCursos
FROM Curso;
Esta consulta retornará o número total de cursos existentes.

4. Consulta para listar o nome de todos os cursos e seus respectivos alunos em ordem decrescente pelo nome dos cursos:

sql
Copy code
SELECT Curso.nome AS NomeCurso, GROUP_CONCAT(Aluno.nome ORDER BY Aluno.nome DESC SEPARATOR ', ') AS Alunos
FROM Curso
LEFT JOIN AlunoCurso ON Curso.idCurso = AlunoCurso.idCurso
LEFT JOIN Aluno ON AlunoCurso.idaluno = Aluno.idaluno
GROUP BY Curso.nome
ORDER BY NomeCurso DESC;
Esta consulta irá listar o nome de todos os cursos e seus respectivos alunos em ordem decrescente pelo nome dos cursos. Os nomes dos alunos estão agrupados em uma única coluna chamada "Alunos".

5. Consulta para listar a média das notas das disciplinas de todos os cursos:

sql
Copy code
SELECT Curso.nome AS NomeCurso, AVG(Historico.nota) AS MediaNotas
FROM Curso
LEFT JOIN Grade ON Curso.idCurso = Grade.idCurso
LEFT JOIN GradeDisciplina ON Grade.idGrade = GradeDisciplina.idGrade
LEFT JOIN Disciplina ON GradeDisciplina.iddisciplina = Disciplina.iddisciplina
LEFT JOIN Historico ON Disciplina.iddisciplina = Historico.iddisciplina
GROUP BY Curso.nome;
Esta consulta irá listar o nome de todos os cursos e a média das notas das disciplinas de cada curso.

6. Consulta para listar o nome de todos os cursos e a quantidade de alunos em cada curso:

sql
Copy code
SELECT Curso.nome AS NomeCurso, COUNT(AlunoCurso.idaluno) AS QuantidadeAlunos
FROM Curso
LEFT JOIN AlunoCurso ON Curso.idCurso = AlunoCurso.idCurso
GROUP BY Curso.nome;
Esta consulta irá listar o nome de todos os cursos e a quantidade de alunos em cada curso.

Certifique-se de executar essas consultas no contexto do seu banco de dados Faculdade.





