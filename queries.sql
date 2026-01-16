
//Queries with SELECT

1. Selezionare tutti gli studenti nati nel 1990 (160)
    
    SELECT *
    FROM students
    WHERE YEAR(date_of_birth) = 1990;


2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

    SELECT *
    FROM courses    
    WHERE cfu > "10"
    ORDER BY cfu;


3. Selezionare tutti gli studenti che hanno più di 30 anni

    SELECT *, TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
    FROM students
    WHERE TIMESTAMPDIFF (YEAR, date_of_birth  , CURDATE())>30



4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

    SELECT *
    FROM courses
    WHERE period = "I semestre"
    AND year = "1";


5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

    SELECT * 
    FROM exams
    WHERE hour > "14:00:00"
    AND date = "2020-06-20";


6. Selezionare tutti i corsi di laurea magistrale (38)
    
    SELECT COUNT(*)
    FROM degrees
    WHERE level = "magistrale";


7. Da quanti dipartimenti è composta l'università? (12)

    SELECT COUNT(*)
    FROM departments


8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

    SELECT COUNT(*) AS numero_insegnanti
    FROM teachers
    WHERE phone IS NULL;





//Queries with GROUP

1. Contare quanti iscritti ci sono stati ogni anno

    SELECT YEAR(enrolment_date), COUNT(id)
    FROM students
    GROUP BY YEAR(enrolment_date)

2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
  
    SELECT office_address, COUNT(id)
    FROM teachers
    WHERE phone IS NULL
    GROUP BY office_address;

3. Calcolare la media dei voti di ogni appello d'esame

    SELECT exam_id, AVG(vote)
    FROM exam_student
    GROUP BY exam_id

4. Contare quanti corsi di laurea ci sono per ogni dipartimento

    SELECT department_id, COUNT(*)
    FROM degrees
    GROUP BY department_id




//Query con JOIN

1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

    SELECT *
    FROM students
    INNER JOIN degrees
    ON degrees.id = students.degree_id
    WHERE degrees.name = "Corso di Laurea in Economia"

2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
    
    SELECT *
    FROM degrees
    INNER JOIN departments
    ON department_id = degrees.department_id
    WHERE degrees.level = "magistrale"
    AND departments.name = "Dipartimento di Neuroscienze"

3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
    
    SELECT courses, id, name, teachers.id
    FROM teachers
    INNER JOIN course_teacher
    ON teachers.id = course_teacher.teacher_id
    INNER JOIN courses
    ON course_teacher.course.id = courses.id
    WHERE teachers.id = 44

4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome
    SELECT *
    FROM students
    INNER JOIN degrees
    ON students.degree_id = degrees.id
    INNER JOIN departments
    ON degrees.department_id = department.id
    ORDER BY students.surname, students.name


5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

    SELECT DISTINCT teachers.*, departments.* //with distinct we eliminate the repetishions
    FROM teachers
    INNER JOIN course_teacher
    ON teachers.id = course_teacher.teacher_id
    INNER JOIN courses
    ON course_teacher.course.id = courses.id
    INNER JOIN degrees
    ON courses.degree_id = degrees.id
    INNER JOIN departments
    ON degrees.department_id = department.id
    WHERE department.name = "Dipartimento di Matematica"


7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
superare ciascuno dei suoi esami

    SELECT students.id, students.name, students.surname, COUNT(exam_student.vote) MAX(exam_student.vote), exams.date
    FROM students
    INNER JOIN exam_student
    ON student.id = exam_student.student_id
    INNER JOIN exam_student
    ON exam_student.exam_id = exams.id
    GROUP BY students.id, courses.id
    ORDER BY students.id

   

8. Selezionare tutti gli appelli d'esame del Corso di Laurea Magistrale in Fisica del primo anno
    
    SELECT *
    FROM exams
    INNER JOIN courses
    ON courses.id = exams.course_id
    INNER JOIN degrees
    ON courses.degree_id = degrees.id
    WHERE degrees.name = "Corso di Laurea Magistrale in Fisica"
    AND courses.year = 1