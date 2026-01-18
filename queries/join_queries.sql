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
    
    SELECT  courses.id, courses.name
    FROM teachers
    INNER JOIN course_teacher
    ON teachers.id = course_teacher.teacher_id
    INNER JOIN courses
    ON course_teacher.course_id = courses.id
    WHERE teachers.id = 44


4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome
    SELECT *
    FROM students
    INNER JOIN degrees
    ON students.degree_id = degrees.id
    INNER JOIN departments
    ON degrees.department_id = departments.id
    ORDER BY students.surname, students.name


5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

    SELECT *
    FROM degrees
    JOIN courses
    ON degrees.id = courses.degree_id
    JOIN course_teacher
    ON courses.id = course_teacher.teacher_id
    JOIN teachers
    ON course_teacher.teacher_id = teachers.id
   

6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

    SELECT DISTINCT teachers.*, departments.* 
    FROM teachers
    INNER JOIN course_teacher
    ON teachers.id = course_teacher.teacher_id
    INNER JOIN courses
    ON course_teacher.course_id = courses.id
    INNER JOIN degrees
    ON courses.degree_id = degrees.id
    INNER JOIN departments
    ON degrees.department_id = departments.id
    WHERE departments.name = "Dipartimento di Matematica"

7. Selezionare tutti gli appelli d esame del Corso di Laurea Magistrale in Fisica del primo anno
    
    SELECT *
    FROM exams
    INNER JOIN courses
    ON courses.id = exams.course_id
    INNER JOIN degrees
    ON courses.degree_id = degrees.id
    WHERE degrees.name = "Corso di Laurea Magistrale in Fisica"
    AND courses.year = 1

