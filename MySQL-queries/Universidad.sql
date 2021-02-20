-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre ASC;
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento >= '1999-01-01' AND fecha_nacimiento <= '1999-12-31';
-- 4. Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%k';
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = '1' AND id_grado = '7';
-- 6. Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT  p.apellido1, p.apellido2, p.nombre, d.nombre FROM profesor pp JOIN persona p ON p.id = pp.id_profesor JOIN departamento d ON d.id = pp.id_departamento ORDER BY p.apellido1, p.apellido2, p.nombre ASC;
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura asma JOIN asignatura a ON a.id = asma.id_asignatura JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar JOIN persona p ON p.id = asma.id_alumno WHERE nif = '26902806M';
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT d.nombre FROM departamento d, profesor pp, grado g, asignatura a WHERE pp.id_profesor = a.id_profesor AND g.id = a.id_grado AND g.id = '4';
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT p.nombre, p.apellido1, a.nombre FROM persona p, alumno_se_matricula_asignatura asma, curso_escolar ce, asignatura a WHERE p.id = asma.id_alumno AND ce.id = asma.id_curso_escolar AND a.id = asma.id_asignatura AND ce.id = '5' AND p.tipo = 'alumno' ;
-- LEFT/RIGHT JOIN
-- 1. Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pp ON p.id = pp.id_profesor JOIN departamento d ON d.id = pp.id_departamento ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre ASC;
-- 2. Retorna un llistat amb els professors que no estan associats a un departament.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pp ON p.id = pp.id_profesor JOIN departamento d ON d.id = pp.id_departamento WHERE pp.id_departamento IS NULL;
-- 3. Retorna un llistat amb els departaments que no tenen professors associats.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p RIGHT JOIN profesor pp ON p.id = pp.id_profesor JOIN departamento d ON d.id = pp.id_departamento WHERE pp.id_profesor IS NULL;
-- 4. Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT * FROM profesor pp LEFT JOIN asignatura a USING (id_profesor) WHERE a.id_profesor IS NULL;
-- 5. Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT * FROM profesor pp RIGHT JOIN asignatura a USING (id_profesor) WHERE pp.id_profesor IS NULL;
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre FROM departamento d WHERE id IN (SELECT pp.id_departamento FROM profesor pp LEFT JOIN asignatura a USING(id_profesor) WHERE a.id NOT IN (SELECT asma.id_asignatura FROM alumno_se_matricula_asignatura asma));
-- RESUM
-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT SUM(tipo) FROM persona WHERE tipo = 'alumno';
-- 2. Calcula quants alumnes van néixer en 1999.
SELECT SUM(tipo) FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
-- 3. Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT d.nombre, SUM(tipo) AS 'n_profesores' FROM profesor pp JOIN departamento d ON d.id = pp.id_departamento JOIN persona p ON p.id = pp.id_profesor GROUP BY d.nombre ORDER BY SUM(tipo) DESC;
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre, SUM(tipo) AS 'n_profesores' FROM profesor pp LEFT JOIN departamento d ON d.id = pp.id_departamento JOIN persona p ON p.id = pp.id_profesor GROUP BY d.nombre;
-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre, COUNT(a.nombre) AS 'n_asignaturas' FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT(a.nombre) DESC;




